# Задание 1
Виртуализация бывает:    
● Аппаратная - виртуализация с поддержкой специальной процессорной архитектуры. В отличие от программной виртуализации,
с помощью данной техники возможно использование изолированных гостевых систем, управляемых гипервизором напрямую. Примеры технологии: Intel VT (Intel Virtualization Technology), AMD-V.
Примеры платформ, использующих аппаратную виртуализацию: VMware, Hyper-V, KVM.    
● Программная - виртуализация, которая происходит на уровне ядра ОС. ПВ эмулирует все железо от процессора до сетевого адаптера (если он нужен). В отличие от
аппаратной виртуализации, не важно, какое аппаратное обеспечение, будет работать на любом железе. Примеры: Oracle VM VirtualBox, BlueStacks App Player, DOSBox.    
● Контейнерная - виртуализация, при которой ядро операционной системы поддерживает несколько изолированных экземпляров пространства пользователя вместо одного. 
Эти экземпляры (контейнеры) с точки зрения выполняемых в них процессов идентичны отдельному экземпляру операционной системы. Примеры: Docker, OpenVZ, Podman.    
● Хостинговая - виртуализация, при которой вычислительная среда предоставляется провайдером как услуга на базе платы за почасовое потребление ресурсов. Примеры: Google Compute Engine, Yandex Cloud.
# Задание 2
Устанавливаю QEMY:    
```sudo apt install qemu-kvm qemu qemu-system```    
Создаю диск для будущей ВМ по команде ```qemu-img create -f qcow2 VM1_test 4G```    
Запускаю установку ВМ по команде: ```qemu-system-x86_64 -hda VM1_test -boot d -cdrom ./alpine-standard-3.13.5-x86 -m 512```, открывается окно QEMU:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_025.png)   
ВМ работает.
# Задание 3
Устанавливаю libvirt0 и virt-manager    
Создаю виртуальную машину VM1, воспользовавшись командой:
    
```virt-install --name VM1 --cdrom "./alpine-standard-3.13.5-x86.iso" --vcpus=1 --memory=256 --disk size=1```    
В процессе возникает ошибка:    
```ERROR    Requested operation is not valid: network 'default' is not active```    
Выполняю команду ```virsh --connect=qemu:///system net-start default```, запускаю заново установку.    
В процессе открывается virt-manager:
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_022.png)    
Судя по всему, установка выполнена успешно.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_023.png)  
# Задание 4
Разворачиваю в VirtualBox сервер GNS3:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_026.png)    
Подключаюсь к GNS3 серверу через браузер по ip.    
Возвращаюсь к ВМ на Debian, создаю две ВМ с ОС alpine, аналогично, как в задание 3.    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_028.png)    
Добавляю объекты в проект GNS3, поправляю конфиг, проверяю работоспособность сети. Вроде бы всё, как должно быть:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/SVIRT_027.png) 
