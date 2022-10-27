<?php

define( 'DB_NAME', getenv('DB_NAME') );

define( 'DB_USER', getenv('DB_USER') );

define( 'DB_PASSWORD', getenv('DB_PASSWORD') );

define( 'DB_HOST', getenv('DB_HOST') );

define( 'DB_CHARSET', 'utf8' );

define( 'DB_COLLATE', '' );

// define( 'FS_METHOD', 'direct' )
$table_prefix = 'wp_';

// Enable WP_DEBUG mode
define( 'WP_DEBUG', true );
// Enable Debug logging to the /tmp/wp-errors.log file
define( 'WP_DEBUG_LOG', '/tmp/wp-errors.log' );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
