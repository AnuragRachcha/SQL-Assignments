SELECT t.title AS Title,
SUM(t.price * s.qty) AS totalSales
FROM titles t 
FULL outer join sales s ON (s.title_id = t.title_id)
WHERE year(s.ord_date) < (select MAX( YEAR(s.ord_date)) from sales s)
GROUP BY t.title
ORDER BY totalSales;

select * from sales;
select * from titles;