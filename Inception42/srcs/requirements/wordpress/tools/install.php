<?php
// Function to generate a random salt key
function generate_salt_key($length = 64) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+-=[]{}|;:,.<>?';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[random_int(0, $charactersLength - 1)];
    }
    return $randomString;
}

// Verify environment variables are set
$required_env = [
    'MYSQL_DATABASE',
    'MYSQL_USER',
    'MYSQL_PASSWORD',
    'MYSQL_HOST',
    'WP_URL'
];

foreach ($required_env as $env) {
    if (!getenv($env)) {
        die("Error: Required environment variable $env is not set\n");
    }
}

// Load the sample configuration file
$config_sample = '/var/www/html/wp-config-sample.php';
if (!file_exists($config_sample)) {
    die("Error: wp-config-sample.php not found\n");
}

$config = file_get_contents($config_sample);

// Prepare salt keys
$salt_keys = [
    'AUTH_KEY', 
    'SECURE_AUTH_KEY', 
    'LOGGED_IN_KEY', 
    'NONCE_KEY', 
    'AUTH_SALT', 
    'SECURE_AUTH_SALT', 
    'LOGGED_IN_SALT', 
    'NONCE_SALT'
];

// Replace placeholders in the config
$replacements = [
    "database_name_here" => getenv('MYSQL_DATABASE'),
    "username_here" => getenv('MYSQL_USER'),
    "password_here" => getenv('MYSQL_PASSWORD'),
    "localhost" => getenv('MYSQL_HOST')
];

foreach ($replacements as $placeholder => $value) {
    $config = str_replace($placeholder, $value, $config);
}

// Add configuration for WP_HOME and WP_SITEURL
$wp_url = getenv('WP_URL');
$config .= "\n// Custom WordPress URL configuration\n";
$config .= "define('WP_HOME', '$wp_url');\n";
$config .= "define('WP_SITEURL', '$wp_url');\n";

// Add salt keys with generated random values
$config .= "\n// WordPress Authentication Unique Keys and Salts\n";
foreach ($salt_keys as $key) {
    $salt_value = generate_salt_key();
    $config .= "define('$key', '$salt_value');\n";
}

// Add debug configuration
$debug_enabled = filter_var(getenv('WP_DEBUG'), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) ?? false;
$config .= "\n// WordPress Debug Settings\n";
$config .= "define('WP_DEBUG', " . ($debug_enabled ? 'true' : 'false') . ");\n";

// Write the updated configuration to wp-config.php
$config_file = '/var/www/html/wp-config.php';
if (file_put_contents($config_file, $config) === false) {
    die("Error: Failed to write wp-config.php\n");
}

echo "wp-config.php created successfully with unique salt keys.\n";
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


