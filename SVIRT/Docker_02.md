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
    restart: always # Режим перезапуска контейнера. Контейнер всегда будет перезапускаться```
# Задание 4
# Задание 5
# Задание 6
# Задание 7
# Задание 8
