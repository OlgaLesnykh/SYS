# Задание 1
![](https://github.com/OlgaLesnykh/screenshots/blob/main/ZABBIX_014.png)
# Задание 2
Устанавливаю Zabbix Agent на 2 ВМ - lesnykhoa-1 и lesnykhoa-2, прикрепляю за каждым хостом шаблон Linux by Zabbix Agent, настраиваю подключение к серверу.    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/ZABBIX_011.png)    

Проверяю, что в разделе Latest Data начали появляться данные с добавленных агентов:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/ZABBIX_012.png)
# Задание 3
Если я правильно поняла задание, то к каждому наблюдаемому хосту требуется привязать шаблон, созданный в первом задании (содержащий два item - информация о загрузке процессора и ОЗУ), а также шаблон Linux by Zabbix Agent.
Сделать это Zabbix не даст, поскольку в этих шаблонах есть повторяющиеся элементы. Привязываю только свой шаблон. Проверяю, что в раздел Latest Data начали поступать необходимые данные:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/ZABBIX_013.png)    

Скриншоты хостов, где видно, что привязан мой шаблон Task_1:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/ZABBIX_015.png)    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/ZABBIX_016.png)  
# Задание 4
Создаю новый дашборд Netology_Dashboards, размещаю на нем графики загрузки процессора и ОЗУ своих двух хостов.    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/ZABBIX_017.png) 
