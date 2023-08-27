# Задание 1
При репликации Master-Slave, Master - основной сервер БД, куда поступают все данные, и все изменения в данных (добавление, обновление, удаление) должны происходить на этом сервере. Slave - вспомогательный сервер, который копирует данные с Master. В обратную сторону (со Slave на Master) данные не копируются.    
При репликации Master-Master данные копируются в обе стороны (т.е. каждый сервер одновременно является и Master, и Slave).
# Задание 2
В файле конфигурации в блоке [mysqld] указываем следующую информацию:    
Для Master:    
```
bind-address=0.0.0.0
server_id = 1
log_bin = /var/log/mysql/mybin.log
```
Для Slave:    
```
bind-address=0.0.0.0
server_id = 2
log_bin = /var/log/mysql/mybin.log
```
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Replication_002.png)    
Перезапускаем сервис mysql, подключаемся к mysql.    
На обоих серверах создаем пользователя для репликации и назначаем ему права:    
```
create user 'replicator'@'%' identified with mysql_native_password by 'password';
```
```
grant replication slave on *.* to 'replicator'@'%';
```
На Master-сервере выполняем команду ```SHOW MASTER STATUS;``` и запоминаем значение поля Position (990 - с какой позиции Slave-серверу начинать репликацию)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Replication_003.png)    
Идем на Slave-сервер, выполняем команду    
```
CHANGE MASTER TO MASTER_HOST = '10.129.0.14', MASTER_USER='replicator', MASTER_PASSWOE = 'mybin.000001', MASTER_LOG_POS = 990;
```
Включаем репликацию ```start slave;```    
Смотрим состояние репликации ```show slave status\G;``` Убеждаемся, что ошибок нет.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Replication_001.png)    
Проверим, что репликация работает: на Master-сервере создадим базу данных lesnykh_test и убедимся, что она реплицировалась на Slave-сервер:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Replication_004.png)    
