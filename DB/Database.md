# Задание 1
Сотрудники (
- идентификатор, первичный ключ, serial;
- фамилия varchar(50);
- имя varchar(50);
- отчество varchar(50);
- идентификатор структурного подразделения, внешний ключ, integer).
  
Список должностей (
- идентификатор, первичный ключ, serial;
- наименование должности varchar(50);)

Типы подразделений (    
- идентификатор структурного подразделения, первичный ключ, integer;
- тип подразделения varchar(50))

Список структурных подразделений (    
- идентификатор, первичный ключ, serial;
- имя структурного подразделения, varchar(50);

Список филиалов (    
- идентификатор, первичный ключ, serial;
- адрес