# Задание 1
Настройка интерфейса GigabitEthernet0/1 первого машрутизатора (Router1) - добавлен track на интерфейс GigabitEthernet0/0; изменен приоритет на 95 для того, чтобы приоритет данного маршрутизатора стал выше при понижении на 10 пунктов приоритета второго маршрутизатора; назначена опция preempt на интерфейсе GigabitEthernet0/1, чтобы он переходил в состояние master в случае обрыва нулевой группы:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/HSRP_001.png)    
    
Настройка интерфейса GigabitEthernet0/1 второго машрутизатора (Router2) - добавлен track на интерфейс GigabitEthernet0/0:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/HSRP_003.png)    

Файл pkt [здесь](https://github.com/OlgaLesnykh/SYS/blob/main/fault_resilience/hsrp_lesnykh.pkt)    

В результате проверки при обрыве любого соединения сеть работоспособна.
# Задание 2
Запустила 2 ВМ в VirtualBox, установила и настроила на каждой nginx и keepalived.    
Скрипт для проверки доступности порта веб-сервера и существования файла index.html возвращает 0, если оба условия выполняются, возвращает 1, если одно из условий не выполняется:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/HSRP_004.png)    

Конфигурационный файл для первого сервера (основного):    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/HSRP_005.png)    

Конфигурационный файл для второго сервера (резервного):    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/HSRP_006.png)    

На первой машине посмотрим ip адреса, видим наш виртуальный ip адрес 192.168.0.105:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/HSRP_007.png)    

Остановим сервис nginx на первой машине и посмотрим статус сервиса keepalived, видим, что он перешел в состояние Fault, а также видим, что наш виртуальный ip адрес 192.168.0.105 пропал из списка ip адресов:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/HSRP_008.png)    

Посмотрим статус сервиса keepalived на второй машине, видим, что он перешел в состояние Master, а также видим, что наш виртуальный ip адрес 192.168.0.105 появился в списке ip адресов:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/HSRP_009.png)    

При изменение названия файла index.nginx-debian.html на первой машине или его удалении процесс выполняется аналогичным образом.
