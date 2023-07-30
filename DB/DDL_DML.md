# Задание 1
Устанавливаю на ВМ MySQL ```sudo apt install mysql-server```    
Создаю учётную запись sys_temp ```create user sys_temp@localhost identified by '12345678';```    
Выполняю запрос на получение списка пользователей в базе данных ```select user from mysql.user;```    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/DB_001.png)    
    
Даю все права для пользователя sys_temp ```grant all privileges on *.* to sys_temp@localhost;```    
Выполняю запрос на получение списка прав для пользователя sys_temp ```show grants for sys_temp@localhost;```     

![](https://github.com/OlgaLesnykh/screenshots/blob/main/DB_002.png)    

Скачиваю дамп базы данных, распаковываю архив, импортирую файлы в mysql ```mysql < sakila-schema.sql```, ```mysql < sakila-data.sql```    
Переподключаюсь к базе данных от имени sys_temp ```mysql -u sys_temp -p```    
Проверяю, что в списке баз данных появилась база данных sakila ```show databases;```    
Перехожу в базу данных sakila ```use sakila```    
Получаю список всех таблиц ```show tables;```    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/DB_003.png)    
