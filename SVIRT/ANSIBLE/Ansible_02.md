# Задание 1
1.1 Скачиваем архив на управляемом хосте. Playbook:
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
    
1.2 
