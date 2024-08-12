select * from mysql.user;

SELECT host FROM mysql.user WHERE User = 'root';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';

FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'root' PASSWORD EXPIRE NEVER;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '{root}';

select Host,User,plugin from mysql.user;