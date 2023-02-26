# Задание 1
```sudo find /etc -maxdepth 1 -type f -name "*.conf" > test_find.txt```    
Указываю глубину поиска ```-maxdepth 1``` для того, чтобы поиск осуществлялся только внутри каталога /etc  
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Bash_040.png)    
```sudo locate --regex '^\/etc\/[^\/]*\.conf$' > test_locate.txt```    
Использую регулярное выражение для поиска только внутри каталога /etc    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Bash_041.png)    
Убеждаемся, что найденное количество файлов одинаково:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Bash_042.png)    
Делаю вывод, что при необходимости поиска в конкретной директории удобнее и быстрее использовать утилиту find, а утилита locate дает больше возможностей при глобальном поиске.
# Задание 2
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Bash_045.png)    
# Задание 3
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Bash_046.png)    
# Задание 4
```find /home/lesnykh -name ".*" | wc -l```    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Bash_043.png)    
В моем домашнем каталоге (включая вложенные каталоги) 45 скрытых файлов.
