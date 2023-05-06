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
    
1.3 Для изменения приветствия копируем новый файл motd на управляемый хост. Предварительно в файле меняем дефолтный текст на "HELLO, DEAR ADMIN!!!:)". Задаем путь к файлу как переменную:    
    
```
---
- name: "Task 1.3"
  hosts: all
  become: true
  vars:
    file_motd: /root/ansible/motd 
  gather_facts: true
  tasks:
    - name: "Copy file /etc/motd"
      copy:
        src: "{{ file_motd }}"
        dest: /etc/motd
        force: yes
        owner: root
        group: root
        mode: u+rw,g-wx,o-wx
```    
Файл с плейбуком [здесь](https://github.com/OlgaLesnykh/SYS/blob/main/SVIRT/ANSIBLE/playbook_1_3.yml).    
Результат выполнения:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/ANSIBLE_015.png)    
    
Подключаемся к хосту, проверяем корректность выполнения:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/ANSIBLE_016.png)    
    
# Задание 2
Использую templates. Имя хоста задаю в файле hosts, для вывода ip-адресов использую встроенные переменные.    
    
```
---
- name: "Task 2"
  hosts: all
  become: true
  gather_facts: true
  tasks:
    - name: "Copy file /etc/motd"
      template:
        src: motd.j2
        dest: /etc/motd
        force: yes
        owner: root
        group: root
        mode: u+rw,g-wx,o-wx
```    
    
Файл с плейбуком [здесь](https://github.com/OlgaLesnykh/SYS/blob/main/SVIRT/ANSIBLE/playbook_2.yml).    
Содержимое файла motd.j2:    
    
```
      HELLO, DEAR ADMIN!
      Input IP-adress is {{ ansible_facts.all_ipv4_addresses[0] }}
      Output IP-adress is {{ inventory_hostname }}
      hostname is {{ host }}
      Have a good day!
```    
    
Результат выполнения:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/ANSIBLE_017.png)    
    
Подключаемся к хосту, проверяем корректность выполнения:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/ANSIBLE_019.png)    

# Задание 3
Плейбук:    
    
```
---
- name: "Task 3"
  hosts: all
  become: true
  gather_facts: true
  roles:
    - apache
```   
    
Файл с плейбуком [здесь](https://github.com/OlgaLesnykh/SYS/blob/main/SVIRT/ANSIBLE/playbook_3.yml).    
    
Роль:    
    
```
---
- name: "Install apache"
  apt:
    name: apache2
    state: present
- name: "Copy file index.html"
  template:
    src: index.html.j2
    dest: /var/www//html/index.html
    force: yes
    owner: root
    group: root
    mode: "u=rwx,g=rx,o=rx"
- name: "Copy file conf"
  copy:
    src: /root/ansible/netology.conf
    dest: /etc/apache2/sites-available/000-default.conf
    force: yes
    owner: root
    group: root
    mode: "u=rwx,g=rx,o=rx"
- name: "Restart apache"
  service:
    name: apache2
    state: restarted
    enabled: yes
- name: Waits for port 80 of any IP to close active connections, don't start checking for 10 seconds
  wait_for:
    port: 80
    delay: 10
    state: present
- uri:
    url: http://{{ inventory_hostname }}
```    
    
Файл с ролью [здесь](https://github.com/OlgaLesnykh/SYS/blob/main/SVIRT/ANSIBLE/main.yml).
    
Результат выполнения:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/ANSIBLE_022.png)    
    
Проверяем:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/ANSIBLE_023.png)    
