# Задание 1. Установка RabbitMQ
![](https://github.com/OlgaLesnykh/screenshots/blob/main/RabbitMQ_001.png)
# Задание 2. Отправка и получение сообщений
Отправляю сообщение, выполняя скрипт producer.py, в админке RabbitMQ появляется новая очередь, в которой одно сообщение, которое еще никто не прочитал (в колонке Ready):    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/RabbitMQ_002.png)    

Выполняю скрипт consumer.py (читаю сообщение из очереди), результат:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/RabbitMQ_003.png)    

Проверяю очередь в админке RabbitMQ: число непрочитанных сообщений должно стать 0:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/RabbitMQ_004.png)    
# Задание 3. Подготовка HA кластера
Объединяю две машины в кластер и создаю политику ha-all на все очереди:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/RabbitMQ_005.png)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/RabbitMQ_006.png)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/RabbitMQ_007.png)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/RabbitMQ_008.png)    
Выполняю скрипт producer.py.    
Вывод команды ```rabbitmqadmin get queue='hello'``` с первой ноды:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/RabbitMQ_009.png)    
Вывод команды ```rabbitmqadmin get queue='hello'``` со второй ноды:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/RabbitMQ_010.png)    
Останавливаю первую ноду и запускаю скрипт consumer.py со второй ноды:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/RabbitMQ_011.png)    
