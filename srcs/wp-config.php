<?php
/**
 * The sample config file can be found here: https://github.com/WordPress/WordPress/blob/master/wp-config-sample.php
 */

/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpress' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/** File System writing type. */
define('FS_METHOD', 'direct');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         ' m=|q-pI/a[Q2px$gWuw/[Mj&<u+Z|l<|-Y]7(KOZV!.G0F:mYn%sq;8]Btg&XhF');
define('SECURE_AUTH_KEY',  'LOW f} %d/2 40=%}jn}5Dr-+Z^lKp-9-3>o(.+wIz^K9x 2lTW,3RNML/UIc|XQ');
define('LOGGED_IN_KEY',    'CiHy55K4QpmlAK8=21spnz`+V),UOY-6Z<kzx=}-f/BT+yXgqA[Kv*Z-e48JdB6=');
define('NONCE_KEY',        ':K=KoGP2vQjg6Z#d5j^ap}07e2;xz2z~l@z{tVM ,j*aJS/{0x2!f7pKBp8pgk%R');
define('AUTH_SALT',        '^wt&GH6sv>d=[z+H|85i)TYvV{|EP_d$L-tFt|yhBOr}wwiu.~j,V%KL7|}Sat#O');
define('SECURE_AUTH_SALT', 'xP/b;.?YIHlS=6rz-ZS.^2.]!q<Vnx;v-5tFYqr#$4:L|`]92bz_l#15Ok2_-dvM');
define('LOGGED_IN_SALT',   'B.IH<Sv{1/TlCB@ZF-+)gp-jaO?KS6Z_|-C<=+Ud#6msE,i3t6ZO_G#>x?Qz~9v0');
define('NONCE_SALT',       '`07nf~G@N0{N}qJCMLaC|dM 1tL||[{:db?3B+/@Jq9sWm&#<<s`KU<mF_5VPNXf');

/**#@-*/

/**
 * WordPress Database Table prefix.
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
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';