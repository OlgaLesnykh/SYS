# Задание 1
Создаем 2 виртуальные машины, таргет-группу и сетевой балансировщик нагрузки.    
[Terraform Playbook](https://github.com/OlgaLesnykh/SYS/blob/main/fault_resilience/main2.tf)    
[Файл meta.yml для Terraform Playbook](https://github.com/OlgaLesnykh/SYS/blob/main/fault_resilience/meta2.yml)    
Проверяем в Yandex Cloud состояние созданного балансировщика и состояние виртуальных машин в целевой группе:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/In_Cloud_003.png)    

Устанавливаем на обе виртуальные машины nginx с помощью Ansible.    
[Ansible Playbook](https://github.com/OlgaLesnykh/SYS/blob/main/fault_resilience/playbook_nginx.yml)    
Проверяем - делаем запрос на 80 порт внешнего ip балансировщика:    

![](https://github.com/OlgaLesnykh/screenshots/blob/main/In_Cloud_004.png)    
# Задание 2
[Terraform Playbook](https://github.com/OlgaLesnykh/SYS/blob/main/fault_resilience/main.tf)    
[Файл meta.yml для Terraform Playbook](https://github.com/OlgaLesnykh/SYS/blob/main/fault_resilience/meta.yml)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/In_Cloud_002.png)    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/In_Cloud_001.png)    
