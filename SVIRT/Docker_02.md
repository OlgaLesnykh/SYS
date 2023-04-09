# Задание 1
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_041.png)    
Docker Compose используется для одновременного управления несколькими контейнерами, входящими в состав приложения. 
Этот инструмент предполагает те же возможности, что и Docker, но позволяет работать с более сложными приложениями. Docker Compose может существенно облегчить развертывание 
приложений со сложной архитектурой - с его использованием не придется настраивать все сервисы отдельно по-одному (не без риска что-то забыть). Например, перенос проекта 
на новый сервер при использовании Docker Compose можно осуществить с помощью нескольких команд, без использования Docker Compose этот процесс длительный и трудоемкий.
# Задание 2
```
version: "3"
services:


networks:
  LesnykhOA-my-netology-hw:
    driver: bridge
    ipam:
      config:
      - subnet: 172.22.0.0/24
```
# Задание 3
```
services:
  lesnykhoa-db:
    image: postgres:latest # Образ, который мы будем использовать
    container_name: lesnykhoa-netology-db # Имя, которым будет называться наш контейнер
    ports: # Порты, которые мы пробрасываем с нашего докер сервера внутрь контейнера
      - 5432:5432
    volumes: # Папка, которую мы пробросим с докер сервера внутрь контейнера
      - ./pg_data:/var/lib/postgresql/data/pgdata
    environment: # Переменные среды
      POSTGRES_PASSWORD: lesnykhoa12!3!! # Задаём пароль от пользователя postgres
      POSTGRES_DB: lesnykhoa-db # БД которая сразу же будет создана
      PGDATA: /var/lib/postgresql/data/pgdata # Путь внутри контейнера, где будет папка pgdata
    networks:
      lesnykhoa-my-netology-hw:
        ipv4_address: 172.22.0.2
    restart: always # Режим перезапуска контейнера. Контейнер всегда будет перезапускаться
  ```    
# Задание 4
```
pgadmin:
    image: dpage/pgadmin4
    container_name: lesnykhoa-pgadmin
    environment:
      PGADMIN_DEFAULT_EMAIL: lesnykhoa@ilove-netology.com
      PGADMIN_DEFAULT_PASSWORD: 123
    ports:
      - "61231:80"
    networks:
      lesnykhoa-my-netology-hw:
        ipv4_address: 172.22.0.3
    restart: always
```    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_042.png)    
# Задание 5
```
zabbix-server:
    image: zabbix/zabbix-server-pgsql
    links:
      - lesnykhoa-db
    container_name: lesnykhoa-zabbix-netology
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: lesnykhoa12!3!!
    ports:
      - "10051:10051"
    networks:
      lesnykhoa-my-netology-hw:
        ipv4_address: 172.22.0.4
    restart: always
```    
# Задание 6
```
zabbix_wgui:
    image: zabbix/zabbix-web-apache-pgsql
    links:
      - lesnykhoa-db
      - zabbix-server
    container_name: lesnykhoa-netology-zabbix-frontend
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: 'postgres'
      POSTGRES_PASSWORD: lesnykhoa12!3!!
      ZBX_SERVER_HOST: "lesnykhoa-netology-zabbix-frontend"
      PHP_TZ: "Europe/Moscow"
    ports:
      - "80:8080"
      - "443:8443"
    networks:
      lesnykhoa-my-netology-hw:
        ipv4_address: 172.22.0.5
    restart: always
```    
# Задание 7
```
version: "3"
services:
  lesnykhoa-db:
    image: postgres:latest # Образ, который мы будем использовать
    container_name: lesnykhoa-netology-db # Имя, которым будет называться наш контейнер
    ports: # Порты, которые мы пробрасываем с нашего докер сервера внутрь контейнера
      - 5432:5432
    volumes: # Папка, которую мы пробросим с докер сервера внутрь контейнера
      - ./pg_data:/var/lib/postgresql/data/pgdata
    environment: # Переменные среды
      POSTGRES_PASSWORD: lesnykhoa12!3!! # Задаём пароль от пользователя postgres
      POSTGRES_DB: lesnykhoa-db # БД которая сразу же будет создана
      PGDATA: /var/lib/postgresql/data/pgdata # Путь внутри контейнера, где будет папка pgdata
    networks:
      lesnykhoa-my-netology-hw:
        ipv4_address: 172.22.0.2
    restart: always # Режим перезапуска контейнера. Контейнер всегда будет перезапускаться

  pgadmin:
    image: dpage/pgadmin4
    container_name: lesnykhoa-pgadmin
    environment:
      PGADMIN_DEFAULT_EMAIL: lesnykhoa@ilove-netology.com
      PGADMIN_DEFAULT_PASSWORD: 123
    ports:
      - "61231:80"
    networks:
      lesnykhoa-my-netology-hw:
        ipv4_address: 172.22.0.3
    restart: always

  zabbix-server:
    image: zabbix/zabbix-server-pgsql
    links:
      - lesnykhoa-db
    container_name: lesnykhoa-zabbix-netology
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: lesnykhoa12!3!!
    ports:
      - "10051:10051"
    networks:
      lesnykhoa-my-netology-hw:
        ipv4_address: 172.22.0.4
    restart: always
    
  zabbix_wgui:
    image: zabbix/zabbix-web-apache-pgsql
    links:
      - lesnykhoa-db
      - zabbix-server
    container_name: lesnykhoa-netology-zabbix-frontend
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: 'postgres'
      POSTGRES_PASSWORD: lesnykhoa12!3!!
      ZBX_SERVER_HOST: "lesnykhoa-netology-zabbix-frontend"
      PHP_TZ: "Europe/Moscow"
    ports:
      - "80:8080"
      - "443:8443"
    networks:
      lesnykhoa-my-netology-hw:
        ipv4_address: 172.22.0.5
    restart: always

networks:
  lesnykhoa-my-netology-hw:
    driver: bridge
    ipam:
      config:
      - subnet: 172.22.0.0/24
```    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_043.png)    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_044.png)
# Задание 8
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_045.png)
