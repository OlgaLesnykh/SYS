# Задание 1
```
SELECT (sum(index_length) / (sum(data_length) + sum(index_length)) * 100)
FROM INFORMATION_SCHEMA.TABLES;
```
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Index_001.png)
# Задание 2
В запросе требуется представить информацию о сумме платежей каждого покупателя за аренды всех арендуемых ими фильмов за 30.07.2005.    
explain analyze исходного запроса:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Index_002.png)    
Видим, что по длительности выполнения узким местом являются временные таблицы и оконная функция. Для оптимизации запроса избавимся от них, и в качестве бонуса добавим упорядочение по фамилии покупателя - для более красивого представления:    
```
SELECT CONCAT(customer.last_name, ' ', customer.first_name), SUM(payment.amount)
FROM payment
JOIN rental ON rental.rental_date=payment.payment_date
JOIN customer ON customer.customer_id=rental.customer_id
JOIN inventory ON inventory.inventory_id=rental.inventory_id
WHERE DATE(payment.payment_date) = '2005-07-30'
GROUP BY customer.customer_id
ORDER BY customer.last_name;
```
explain analyze запроса после оптимизации:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Index_003.png)    
Запрос выполняется моментально.
