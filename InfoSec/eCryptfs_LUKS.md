# Задание 1
Создаю нового пользователя cryptouser с зашифрованным каталогом командой ```sudo adduser --encrypt-home cryptouser```
Просматриваю содержимое директории /home/cryptouser под пользователями cryptouser, root, user поочередно. Убеждаюсь, что просмотр содержимого директории возможен только под пользователем cryptouser.    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/InfoSec_001.png)
# Задание 2
Создаю раздел диска vdb1 размером 100 Мб.    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/InfoSec_002.png)    
    
Создаю LUKS-раздел (раздел инициализируется, создается пароль), монтирую раздел, смотрю состояние устройства:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/InfoSec_003.png)    
    
Форматирую раздел, создаю файловую систему ext4:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/InfoSec_004.png)    
    
Монтирую раздел:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/InfoSec_005.png)    
    
Отключаю устройство и защищаю данные:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/InfoSec_006.png)    
