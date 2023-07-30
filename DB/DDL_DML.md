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
Выбираю базу данных sakila для дальнейшей работы с ней ```use sakila```    
Получаю список всех таблиц ```show tables;```    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/DB_003.png)    
# Задание 2
Информацию о первичном ключе беру из описания таблицы, например ```describe payment;```    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/DB_004.png)    
