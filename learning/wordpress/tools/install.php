<?php
define('WP_INSTALL', true);
define('WP_DEBUG', false);
define('WP_POST_REVISIONS', 5);
define('AUTOMATIC_UPDATER_DISABLED', true);
define('DISABLE_WP_CRON', true);
define('DISALLOW_FILE_EDIT', true);



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

<?php
define( 'DB_NAME', getenv('WORDPRESS_DB_NAME') );
define( 'DB_USER', getenv('WORDPRESS_DB_USER') );
define( 'DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD') );
define( 'DB_HOST', getenv('WORDPRESS_DB_HOST') );
define( 'DB_CHARSET', 'utf8mb4' );
define( 'DB_COLLATE', '' );

define('AUTH_KEY',         '!;k)EMUyn<3TfYC{a] 4SNLd6`XGB;EMgg-CMt:+Bsii<y9j+b4!VAC.<2 ;U-,P');
define('SECURE_AUTH_KEY',  'HGb%s~0~_KDDrI&o<^![mp1Jl-S+Njn9n&.&3x+vz.cy*pUR)4-jevd!rC%k:o!~');
define('LOGGED_IN_KEY',    'sq-brCqz`L{l$Q@Uz+m<kk+Jfn1FPk_|`Nb<I.Tit!vki,9-lv[A0pVYGsduFecH');
define('NONCE_KEY',        'BZ{:$FJQb3j7|L4[?$$[!op<OF5~7v:xIZH56LP0+$y|`$F=~~OftvAz3|(RCl2t');
define('AUTH_SALT',        'e1af4>.cNi79WE(Lmy%FxD+`SVcE;-m/uTj76[1{d3@]d4/&|& JVuZ|z-)W;ow-');
define('SECURE_AUTH_SALT', '3E A<_;=(h+ N,Z2*0=XNASIWr~w+z/^xsB-_^k#+6iE7G#j[Ei#m[@=a$(&6?| ');
define('LOGGED_IN_SALT',   '7^g4zAW~szi#-rD6}F[7frO<8YFqi}-^Dh?qjcm}%j!xHYE&O}}.c|Z;,h=8h3< ');
define('NONCE_SALT',       'cxui#!MtwCLQD|!DJ4ai 9PeI7~Cs+S`:vZds9URa!@nc/#%p>n8|96l]fYxsR6Y');

$table_prefix = 'wp_';

define( 'WP_DEBUG', filter_var(getenv('WP_DEBUG'), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) ?? false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';

# I generate the secure SALT key from https://api.wordpress.org/secret-key/1.1/salt/


