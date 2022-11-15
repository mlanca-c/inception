# **************************************************************************** #
# Makefile
#
# User: mlanca-c
# URL: https://github.com/mlanca-c/inception
# Description: this is a Makefile for the setup of a docker app.
# **************************************************************************** #

PROJECT	:= inception
VERSION	:= 1.0

USER	:= mlanca-c

# This flag signals if I'm using my home computer or my school one.
HOME	:= true

# **************************************************************************** #
# Configs
# **************************************************************************** #

# Operative System
OS	:= $(shell uname)

# Verbose levels
# 0: Make will be totaly silenced
# 1: Make will print echos and printf
# 2: Make will not be silenced but target commands will not be printed
# 3: Make will print each command
# 4: Make will print all debug info
#
# If no value is specified or an incorrect value is given make will print each
# command like if VERBOSE was set to 3.
VERBOSE	:= 2

# **************************************************************************** #
# File Manipulation
# **************************************************************************** #

RM		:= rm -rf
PRINT	:= printf
MKDIR	:= mkdir -p
CP		:= cp -r
MV		:= mv

ifeq (${OS},Linux)
 SED	:= sed -i.tmp --expression
else ifeq (${OS},Darwin)
 SED	:= sed -i.tmp
endif

# Definitions
T		:= 1
comma	:= ,
empty	:=
space	:= $(empty) $(empty)
tab		:= $(empty)	$(empty)

# **************************************************************************** #
# Colors and Messages
# **************************************************************************** #

GREEN		:= \e[38;5;2m
YELLOW		:= \e[38;5;3m
RED			:= \e[38;5;1m
RESET		:= \e[0m

_SUCCESS	:= ${GREEN}[ok]:${RESET}
_FAILURE	:= ${RED}[error]:${RESET}
_INFO		:= ${YELLOW}[info]:${RESET}

# **************************************************************************** #
# Root Folders
# **************************************************************************** #

SRC_ROOT	:= ./srcs/
REQ_ROOT	:= ./srcs/requirements/
TOOLS_ROOT	:= ./srcs/requirements/tools/
ifeq (${HOME},true)
	VOL_ROOT	:= /home/mlancac/data/
else
	VOL_ROOT	:= /home/${USER}/data/
endif

# Images of project separated by ':'
IMGS	:= nginx:mariadb:wordpress
# Volumes of project separated by ':'
VOLS	:= mariadb-volume:wordpress-volume
# Networks of project separated by ':'
NETS	:= inception-network

IMG_NAMES_LIST	:= $(foreach dl,${IMGS},$(subst :,${space},${dl})) 
IMG_DIRS_LIST	:= $(addprefix ${REQ_ROOT},${IMGS})
IMG_DIRS_LIST	:= $(foreach dl,${IMG_DIRS_LIST},$(subst :,:${REQ_ROOT},${dl}))

VOL_NAMES_LIST	:= $(foreach dl,${VOLS},$(subst :,${space},${dl})) 
VOL_DIRS_LIST	:= $(addprefix ${VOL_ROOT},${VOLS})
VOL_DIRS_LIST	:= $(foreach dl,${VOL_DIRS_LIST},$(subst :,:${VOL_ROOT},${dl}))

NET_NAMES_LIST	:= $(foreach dl,${NETS},$(subst :,${space},${dl})) 

IMG_DIRS	= $(call rmdup,$(subst :,${SPACE},${IMG_DIRS_LIST}))
VOL_DIRS	= $(call rmdup,$(subst :,${SPACE},${VOL_DIRS_LIST})) 

# **************************************************************************** #
# Docker
# **************************************************************************** #

DOCKER	:= docker

# Docker Compose
COMPOSE			:= docker-compose
COMPOSE_UP		:= ${COMPOSE} --project-directory ${SRC_ROOT} --project-name \
					inception up -d 
COMPOSE_DOWN	:= ${COMPOSE} --project-directory ${SRC_ROOT} down --rmi all
COMPOSE_LOGS	:= ${COMPOSE} --project-directory ${SRC_ROOT} logs --follow

# **************************************************************************** #
# Conditions
# **************************************************************************** #

ifeq (${OS},Linux)
	SED := sed -i.tmp --expression
else ifeq (${OS},Darwin)
	SED := sed -i.tmp
endif

ifeq ($(VERBOSE),0)
	MAKEFLAGS += --silent
	BLOCK := &>/dev/null
else ifeq ($(VERBOSE),1)
	MAKEFLAGS += --silent
else ifeq ($(VERBOSE),2)
	AT := @
else ifeq ($(VERBOSE),4)
	MAKEFLAGS += --debug=v
endif

# **************************************************************************** #
# Project Targets
# **************************************************************************** #

all: up container_logs

up: volumes
	${AT} \
	if [ ! -f ${SRC_ROOT}.env ]; then \
		${PRINT} "${_FAILURE} no srcs/.env file found\n"; \
	else \
		source ${SRC_ROOT}.env; \
		${COMPOSE_UP} && ${MAKE} hosts_up && ${COMPOSE_LOGS} \
		|| ${PRINT} "${_FAILURE} ${COMPOSE} failed"; \
	fi \
	${BLOCK}

up_detach: COMPOSE_LOGS="true"
up_detach: up

# down: hosts_down
down:
	${AT} ${COMPOSE_DOWN} ${BLOCK}

# **************************************************************************** #
# Clean Targets
# **************************************************************************** #

clean: clean_images hosts_down

fclean: clean clean_volumes_folder clean_volumes clean_networks

re: fclean all

clean_images: ;
	${AT}$(foreach img,${IMG_NAMES_LIST},$(call make_clean_img,${img}))${BLOCK}

clean_volumes: ;
	${AT}$(foreach vol,${VOL_NAMES_LIST},$(call make_clean_volume,${vol}))${BLOCK}

clean_volumes_folder: ;
	${AT}$(foreach vol,${VOL_NAMES_LIST},$(call make_clean_volume_folder,${vol}))${BLOCK}

clean_networks: ;
	${AT}$(foreach net,${NET_NAMES_LIST},$(call make_clean_network,${net}))${BLOCK}

clean_all: _clean_all status

_clean_all:
	${AT} ${DOCKER} stop `docker ps -qa` || true ${BLOCK}
	${AT} ${DOCKER} rm `docker ps -qa` || true ${BLOCK}
	${AT} ${DOCKER} rmi -f `docker images -qa` || true ${BLOCK}
	${AT} ${DOCKER} volume rm `docker volume ls -q` || true ${BLOCK}
	${AT} ${DOCKER} network rm `docker network ls -q` || true ${BLOCK}

# **************************************************************************** #
# Other Project Targets
# **************************************************************************** #

volumes: ;
	$(foreach vol,${VOL_NAMES_LIST},$(call make_create_volume,${vol}))

status:
	${AT} ${PRINT} "containers:\n" ${BLOCK}
	${AT} ${DOCKER} container ls --format "{{.Names}}: {{.ID}}" ${BLOCK}
	${AT} ${PRINT} "images:\n" ${BLOCK}
	${AT} ${DOCKER} images --format "{{.Repository}}: {{.ID}}" || \
		${DOCKER} images --format "{{.Name}}: {{.ID}}" ${BLOCK}
	${AT} ${PRINT} "volumes:\n" ${BLOCK}
	${AT} ${DOCKER} volume ls --format "{{.Name}}: {{.Driver}}" ${BLOCK}
	${AT} ${PRINT} "networks:\n" ${BLOCK}
	${AT} ${DOCKER} network ls --format "{{.Name}}: {{.ID}}" \
		--filter type=custom ${BLOCK}

container_logs:
	${AT} ${COMPOSE_LOGS} ${BLOCK}

hosts_check: ;

# ${AT} sudo bash ${TOOLS_ROOT}host_config.sh check && \
# ${PRINT} "${_SUCCESS} hosts were successfully configured in /etc/hosts\n" || \
# ${PRINT} "${_FAILURE} hosts are not configured in /etc/hosts\n" ${BLOCK}

hosts_re: hosts_check hosts_down hosts_up hosts_check

hosts_up: ;

# ${AT} sudo bash ${TOOLS_ROOT}host_config.sh up && \
# ${PRINT} "${_SUCCESS} host configured in /etc/hosts\n" ${BLOCK}

hosts_down: ;

# ${AT} sudo bash ${TOOLS_ROOT}host_config.sh down && \
# ${PRINT} "${_SUCCESS} host disconfigured in /etc/hosts\n" ${BLOCK}

# **************************************************************************** #
# Debug Targets
# **************************************************************************** #

print-%: ;
	${AT} echo $*=$($*) ${BLOCK}

# **************************************************************************** #
# .PHONY
# **************************************************************************** #

# Phony execution targets
.PHONY: all up down up_detach

# Phony other execution targets
.PHONY: status volumes

# Phony host targets
.PHONY: hosts_check hosts_re hosts_up hosts_down

# Phony clean targets
.PHONY: clean fclean re

# Phony debug targets
.PHONY: %-print

# Phony docker clean targets
.PHONY: clean_images clean_volumes clean_networks clean_all _clean_all

# **************************************************************************** #
# Constants
# **************************************************************************** #

NULL			=
SPACE			= ${NULL} #
CURRENT_FILE	= ${MAKEFILE_LIST}

# **************************************************************************** #
# Functions
# **************************************************************************** #

# Get the index of a given word in a list
_index = $(if $(findstring $1,$2),$(call _index,$1,\
	$(wordlist 2,$(words $2),$2),x $3),$3)
index = $(words $(call _index,$1,$2))

# Get value at the same index
lookup = $(word $(call index,$1,$2),$3)

# Remove duplicates
rmdup = $(if $1,$(firstword $1) $(call rmdup,$(filter-out $(firstword $1),$1)))

# Get files for a specific binary
get_files = $(subst :,${SPACE},$(call lookup,$1,${NAMES},$2))

# Get default target for libs given a rule
get_lib_target = $(foreach lib,$1,${lib}/$2)

# **************************************************************************** #
# Target Generator
# **************************************************************************** #

define make_clean_img
(docker rmi -f ${1}:prod && \
	${PRINT} "${_SUCCESS} ${1} image removed\n");
endef

define make_create_volume
(${MKDIR} ${VOL_ROOT}${1} && \
	${PRINT} "${_SUCCESS} ${1} folder created\n");
endef

define make_clean_volume_folder
(sudo ${RM} ${VOL_ROOT}${1} && \
	${PRINT} "${_SUCCESS} ${1} volume folder removed\n");
endef

define make_clean_volume
(docker volume rm ${1} && \
	${PRINT} "${_SUCCESS} ${1} volume removed\n") || \
	${PRINT} "${_FAILURE} ${1} volume couldn't be removed\n";
endef

define make_clean_network
(docker network rm ${1} && \
	${PRINT} "${_SUCCESS} ${1} network removed\n") || \
	${PRINT} "${_FAILURE} ${1} network couldn't be removed\n";
endef
