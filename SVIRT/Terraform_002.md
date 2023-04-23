# Задание 1
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_051.png)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_070.png)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_071.png)    
    
По команде ```terraform apply``` ВМ успешно создана:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_072.png)    
        
Добавляем полученный ip адрес в файл inventory  для Ansible и проверяем пинг:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_073.png)    
    
Создаем для Ansible playbook, который установит nginx, передаст конфигурационные файлы nginx:    
    

