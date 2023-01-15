# Задание 1.
1. В VirtualBox создаю две виртуальные машины (Debian 11), vm1 и vm2.

![](https://github.com/OlgaLesnykh/screenshots/blob/f65e18b0cf24bd5b1a80ba0f227edf98e7ffbe3d/Firewall_001.png)

2. Создаю вируальный адаптер для сети 192.168.123.0

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Firewall_002.png)

3. Включаю для vm1 два адаптера: виртуальный адаптер хоста (для доступа в виртуальную сеть 192.168.123.0) и сетевой мост (для доступа в интернет).
4. Включаю для vm2 один адаптер - виртуальный адаптер хоста (для доступа в виртуальную сеть 192.168.123.0).
5. Для vm1 настраиваю статический IP адрес у интерфейса смотрящего в сеть 192.168.123.0 (выбираю адрес 192.168.123.111). Проверяю доступность по ICMP c vm1 до 8.8.8.8.

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Firewall_003.png)

Для того, чтобы значение статического ip адреса сохранилось после перезагрузки ВМ, делаю записи в файле /etc/network/interfaces

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Firewall_004.png)

6. Для vm2 настраиваю статический IP адрес у интерфейса смотрящего в сеть 192.168.123.0 (выбираю адрес 192.168.123.112), шлюзом указываю IP vm1 192.168.123.111.

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Firewall_005.png)

7. Проверяю доступность по ICMP vm1 с vm2 по IP:

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Firewall_006.png)

Проверяю доступность по ICMP vm2 с vm1 по IP:

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Firewall_007.png)

8. Настраиваю пересылку трафика на vm1, чтобы с vm2 можно было отправить ICMP-запросы на 8.8.8.8.

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Firewall_008.png)

Пробую отправить ICMP-запрос на 8.8.8.8 с vm2

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Firewall_009.png)

# Задание 2.
Настраиваю проброс портов из локальной сети компьютера с VirtualBox через vm1 порт 12322 в виртуальную сеть VirtualBox на 22 порт vm2.

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Firewall_010.png)

Запускаю с хоста Putty, пробую подключиться к 192.168.0.103 через порт 12322

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Firewall_011.png)

После введения логина и пароля подключение выполняется к vm2, значит настройки выполнены корректно.

![](https://github.com/OlgaLesnykh/screenshots/blob/main/Firewall_012.png)



