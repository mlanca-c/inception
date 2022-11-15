<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('DB_NAME') );

/** Database username */
define( 'DB_USER', getenv('DB_USER') );

/** Database password */
define( 'DB_PASSWORD', getenv('DB_PASSWORD') );

/** Database hostname */
define( 'DB_HOST', getenv('DB_HOST') );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );


/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
/* define( 'AUTH_KEY',         '%Wyv#Iq:1$AZgG`n4=FU~jE^U-Td@r*=X?sR06*m!nk5i=E/KzU+`PfMwyPX:4[ ' ); */
/* define( 'SECURE_AUTH_KEY',  '7-JUC_HlX5<=,a<#/^Y7t;6+p?iu@Qifzf,7miIUDeCF>SiC-H:BmfjQ[Y 1@;yO' ); */
/* define( 'LOGGED_IN_KEY',    '%*|)lrAWAwe$U6%m=z`yWR<8^:.J+0vu~>%j}GJe Po<>8{SwEV0R0&J568xlc01' ); */
/* define( 'NONCE_KEY',        'GbkJpLVwl/gYDHmc_x/Rti(p^BQbN`mjGK7a905ETk-iX,T/Otw=XABhGaFn J|B' ); */
/* define( 'AUTH_SALT',        'Ppvj`(+&GSL/wTu.296o<x]nG!%-~561}QReVi-0k5/QiS>=bX[<*J[RGiPt<5kK' ); */
/* define( 'SECURE_AUTH_SALT', '_$hUWR_+bg`vor`;kCU(2z5vIJw;0u![4DfP9}sjwK[j*RAk7GZzwu(:Ru%AT5yX' ); */
/* define( 'LOGGED_IN_SALT',   'G;k?(/ccLDRPIZZ7mqec!@/q|]}(PxR#fcj*P#eg|Fworp}NlD<<;i.jNlu5:.r<' ); */
/* define( 'NONCE_SALT',       'xnn8L)g=s;I_-/GLY;h-vNTpt#K<j+_qx8y:sZG&whG8rQ/x`Ml1kie0#XiV=KMk' ); */

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', '/var/www/wordpress/wp-errors.log' );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

