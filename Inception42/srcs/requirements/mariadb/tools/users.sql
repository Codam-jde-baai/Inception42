-- Create the database
CREATE DATABASE IF NOT EXISTS `${MYSQL_DATABASE}`;

-- Allow root to connect from any host
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

-- Create the admin and grant privileges
CREATE USER IF NOT EXISTS `${MYSQL_USER}`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT SELECT, INSERT, UPDATE, DELETE ON `${MYSQL_DATABASE}`.* TO `${MYSQL_USER}`@'%';

-- Create the admin and grant privileges
CREATE USER IF NOT EXISTS `${MYSQL_ADMIN}`@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON `${MYSQL_DATABASE}`.* TO `${MYSQL_ADMIN}`@'%';


-- Apply the changes
FLUSH PRIVILEGES;

SELECT 'Script executed successfully';
