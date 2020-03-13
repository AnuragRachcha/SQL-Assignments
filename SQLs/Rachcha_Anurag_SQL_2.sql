SELECT t.title AS titleColoumn, 
	   SUM(price*s.qty) AS totalSales 
	   FROM titles t
FULL OUTER JOIN sales s 
ON (s.title_id = t.title_id) 
GROUP BY title 
ORDER BY totalSales			                                                                    --1


SELECT t.title AS titleColoumn, 
	   st.stor_name AS storeName, 
SUM(price*s.qty) AS totalSales 
FROM titles t
FULL OUTER JOIN sales s ON (s.title_id = t.title_id) 
FULL OUTER JOIN stores st ON (st.stor_id = s.stor_id)
GROUP BY title, stor_name 
ORDER BY totalSales									                            				--2


SELECT t.title AS titleColoumn, 
	   r.lorange, 
	   r.hirange, 
	   r.royalty 
FROM titles t, 
	 roysched r
WHERE r.title_id = t.title_id 
ORDER BY titleColoumn                                                                           --3

SELECT DISTINCT st.stor_name AS storeName, 
				s.ord_num AS orderNumber FROM stores st
JOIN sales s ON (st.stor_id = s.stor_id)
WHERE s.ord_num IN
(SELECT s.ord_num FROM sales s 
 GROUP BY s.ord_num 
 HAVING COUNT(DISTINCT title_id)>1)                                                             --4


SELECT (SUBSTRING(emp_id, 9,1)) AS Gender, 
	   COUNT(*) AS countNumber FROM employee
GROUP BY (SUBSTRING(emp_id, 9,1))                                                               --5

SELECT e.fname, 
	   e.lname, 
SUBSTRING(e.emp_id, 9,1) AS Gender FROM employee e                                              --6






