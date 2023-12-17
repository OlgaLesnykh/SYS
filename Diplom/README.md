# Дипломная работа по профессии «Системный администратор»
# 1. Подготовка к развертыванию инфраструктуры
Для развертывания инфраструктуры необходимо выполнить  следующее:
1. подготовить рабочую машину с доступом в сеть интернет и установленной на нее операционной системой Linux (протестировано на Debian 11);
2. установить на рабочую машину пакеты Terraform (для создания основной инфраструктуры) и Ansible (для последующей донастройки);
3. сгенерировать ssh-ключ для последующего доступа к созданным виртуальным машинам.
# 2. Развертывание инфраструктуры
1. Из директории ~/Terraform выполняем команду ```terraform apply```, подтверждаем выполнение операции: ``` Enter a value: yes``` и ждем завершения 7-10 минут.
2. Проверяем созданные инстансы. В результате получаем:
- 6 виртуальных машин: два web-сервера в разных зонах, имеющих только внутренние ip-адреса; bastion-host, имеющий публичный ip-адрес; сервер для zabbix, имеющий публичный ip-адрес; сервер для elasticsearh, имеющий только внутренний ip-адрес;, сервер для kibana, имеющий публичный ip-адрес:
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_012.png)    
        
- одна сеть, четыре подсети: две подсети в разных зонах для web-серверов, подсеть для bastion-host, zabbix-сервера, сервера kibana, и подсеть для elasticsearh-сервера:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_003.png)    

- группы безопасности:

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_004.png)    

- HTTP-роутер:

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_005.png)    

- target-group:

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_006.png)    

- backend-group:

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_007.png)    

- балансировщик нагрузки (проверку состояния смотрим после установки Nginx):

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_008.png)    

- расписание снапшотов (снапшот диска начинает сниматься в 0:00 по расписанию, проверить наличие можно на следующий день после развертывания инфраструктуры):

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_001.png)    

- Формируется файл inventory.ini в директории ~/ansible для последующей настройки с помощью Ansible:

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_009.png)    
# 3. Настройка с помощью Ansible
Для настройки с помощью Ansible требуется перейти в директорию ~/ansible, проверить доступность созданных виртуальных машин командой ```ansible all -m ping```,  возможно, потребуется выполнить команду дважды:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_010.png)    

Убедившись, что все виртуальные машины доступны, запускаем плейбук ```ansible-playbook playbook_diplom.yml``` и ждем завершения 6-9 минут. В результате:    
1. На web-сервера устанавливается Nginx, выполняется обновление файла index.html. Сервис доступен по публичному адресу балансировщика http://158.160.138.211

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_011.png)    

2. На все виртуальные машины устанавливается zabbix-agent, на zabbix-сервере соответственно разворачивается zabbix-сервер. Web-интерфейс доступен по адресу http://158.160.71.201/zabbix. Логин ```Admin``` пароль ```zabbix``` стандартно. Машины с Zabbix-agent подключаются к zabbix-серверу автоматически при выполнении роли zabbix через API. Также, через API Zabbix, создаются дашборды web-серверов.    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_013.png)    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_014.png)    

3. На виртуальной машине для Elasticsearch разворачивается Elasticsearch при выполнении роли elasticsearch, копируется файл конфигурации. На виртуальной машине для kibana разворачивается kibana, копируется файл конфигурации. На web-сервера устанавливается Filebeat, копируются файлы конфигурации. Использую версию Elasticsearch 7.17.14. Web-интерфейс доступен по адресу http://158.160.74.207:5601.

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_015.png)    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Diplom_016.png)    
