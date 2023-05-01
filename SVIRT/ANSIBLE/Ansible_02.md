# Задание 1
1.1 Скачиваем архив на управляемом хосте, создаем директорию, в которую будем распаковывать архив, распаковываем архив. Playbook:
```
---
- name: "Task 1.1"
  hosts: all
  gather_facts: false
  tasks:
    - name: "Download file"
      get_url:
        url: https://downloads.apache.org/kafka/3.4.0/kafka-3.4.0-src.tgz
        dest: /home/user/kafka3.4.0.tgz
    - name: "Create directory"
      file:
        path: /home/user/task_1
        state: directory
        mode: "u=rwx,g=r,o=r"
    - name: "Unarchive file"
      unarchive:
        src: /home/user/kafka3.4.0.tgz
        dest: /home/user/task_1
        remote_src: yes
 ```    
Файл с плейбуком [здесь](https://github.com/OlgaLesnykh/SYS/blob/main/SVIRT/ANSIBLE/playbook_1_1.yml).    
Результат выполнения:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/ANSIBLE_011.png)    
    
Подключаемся к хосту, проверяем корректность выполнения:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/ANSIBLE_013.png)    
    
1.2 Устанавливаем пакет tuned, запускаем сервис, добавляем сервис в автозагрузку:    
```
---
- name: "Task 1.2"
  hosts: all
  become: true
  gather_facts: false
  tasks:
    - name: "Install tuned"
      apt:
        name: tuned
        state: present
    - name: "Start tuned"
      service:
        name: tuned
        state: started
        enabled: yes
 ```    
Файл с плейбуком [здесь](https://github.com/OlgaLesnykh/SYS/blob/main/SVIRT/ANSIBLE/playbook_1_2.yml).    
Результат выполнения:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/ANSIBLE_012.png)    
    
Подключаемся к хосту, проверяем корректность выполнения:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/ANSIBLE_014.png)    
    
1.3
