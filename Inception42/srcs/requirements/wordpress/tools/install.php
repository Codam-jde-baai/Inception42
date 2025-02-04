<?php

// Load the sample configuration file
$config = file_get_contents('/var/www/html/wordpress/wp-config-sample.php');

// Define replacements for placeholders in the sample config
$replacements = [
    "database_name_here" => getenv('MYSQL_DATABASE'),
    "username_here" => getenv('MYSQL_USER'),
    "password_here" => getenv('MYSQL_PASSWORD'),
    "localhost" => getenv('MYSQL_HOST')
];

// Replace placeholders with environment variable values
foreach ($replacements as $placeholder => $value) {
    $config = str_replace($placeholder, $value, $config);
}

// Add SALT keys to the configuration
$salt_keys = [
    'AUTH_KEY' => '!;k)EMUyn<3TfYC{a] 4SNLd6`XGB;EMgg-CMt:+Bsii<y9j+b4!VAC.<2 ;U-,P',
    'SECURE_AUTH_KEY' => 'HGb%s~0~_KDDrI&o<^![mp1Jl-S+Njn9n&.&3x+vz.cy*pUR)4-jevd!rC%k:o!~',
    'LOGGED_IN_KEY' => 'sq-brCqz`L{l$Q@Uz+m<kk+Jfn1FPk_|`Nb<I.Tit!vki,9-lv[A0pVYGsduFecH',
    'NONCE_KEY' => 'BZ{:$FJQb3j7|L4[?$$[!op<OF5~7v:xIZH56LP0+$y|`$F=~~OftvAz3|(RCl2t',
    'AUTH_SALT' => 'e1af4>.cNi79WE(Lmy%FxD+`SVcE;-m/uTj76[1{d3@]d4/&|& JVuZ|z-)W;ow-',
    'SECURE_AUTH_SALT' => '3E A<_;=(h+ N,Z2*0=XNASIWr~w+z/^xsB-_^k#+6iE7G#j[Ei#m[@=a$(&6?| ',
    'LOGGED_IN_SALT' => '7^g4zAW~szi#-rD6}F[7frO<8YFqi}-^Dh?qjcm}%j!xHYE&O}}.c|Z;,h=8h3< ',
    'NONCE_SALT' => 'cxui#!MtwCLQD|!DJ4ai 9PeI7~Cs+S`:vZds9URa!@nc/#%p>n8|96l]fYxsR6Y'
];

foreach ($salt_keys as $key => $value) {
    $config .= "define('$key', '$value');\n";
}

// Add additional configurations
$config .= "\ndefine('WP_DEBUG', filter_var(getenv('WP_DEBUG'), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) ?? false);\n";

// Write the updated configuration to wp-config.php
file_put_contents('/var/www/html/wordpress/wp-config.php', $config);
echo "wp-config.php created successfully.";

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


