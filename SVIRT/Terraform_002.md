# Задание 1
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_051.png)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_070.png)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_071.png)    
    
По команде ```terraform apply``` ВМ успешно создана:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_072.png)    
        
Добавляем полученный ip адрес в файл inventory  для Ansible и проверяем пинг:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_073.png)    
    
Создадим для Ansible playbook, который установит nginx, передаст конфигурационный файл nginx:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_075.png)    
    
Запускаем его, убеждаемся в успешности выполнения всех задач, проверяем:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_076.png)
