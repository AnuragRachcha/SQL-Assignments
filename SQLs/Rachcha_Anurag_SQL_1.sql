SELECT * 
FROM authors a 
WHERE a.state = 'CA';                                                                          --1

SELECT t.title,
	   a.au_fname AS 'First Name',
	   a.au_lname AS 'Last Name'
FROM titles t, authors a, titleauthor ta
WHERE ta.title_id = t.title_id 
AND ta.au_id = a.au_id;                                                                        --2

SELECT e.emp_id AS 'Employee ID',
	   e.fname AS 'First Name',
	   e.lname AS 'Last Name',
	   j.job_desc AS 'Job Description' 
FROM employee e, jobs j
WHERE e.job_id = j.job_id;                                                                     --3

SELECT t.title AS 'Title',
	   price*s.qty as 'Total Sales' 
FROM titles t, sales s
WHERE s.title_id = t.title_id;                                                                 --4

SELECT s.stor_name AS 'Store Name', 
SUM(t.ytd_sales) as 'Sales' 
FROM stores s, titles t, sales sa
WHERE sa.stor_id = s.stor_id 
AND sa.title_id = t.title_id 
AND s.state = 'CA' 
GROUP BY s.stor_name;                                                                          --5

USE [pubs]
GO

/****** Object:  Table [dbo].[authors]    Script Date: 9/21/2019 4:38:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[authors1](
	[au_id] [dbo].[id] NOT NULL,
	[au_lname] [varchar](40) NOT NULL,
	[au_fname] [varchar](20) NOT NULL,
	[phone] [char](12) NOT NULL,
	[address] [varchar](40) NULL,
	[city] [varchar](20) NULL,
	[state] [char](2) NULL,
	[zip] [char](5) NULL,
	[contract] [bit] NOT NULL,
 CONSTRAINT [UPKCL_auidind1] PRIMARY KEY CLUSTERED 
(
	[au_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[authors1] ADD  DEFAULT ('UNKNOWN') FOR [phone]
GO

ALTER TABLE [dbo].[authors1]  WITH CHECK ADD CHECK  (([au_id] like '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]'))
GO

ALTER TABLE [dbo].[authors1]  WITH CHECK ADD CHECK  (([zip] like '[0-9][0-9][0-9][0-9][0-9]'))
GO                                                                                              --6

SELECT * FROM authors1; --Query for output of query 6

-- Answer to 7th question has been given in the attached document, Rachcha_Anurag_SQL_1.doc

SELECT s.stor_name AS 'Store Name',
	   t.title_id AS 'Title ID',
	   t.title,sa.qty AS 'Quantity' 
FROM stores s, titles t, sales sa 
WHERE s.stor_id = sa.stor_id 
AND t.title_id = sa.title_id 
AND sa.payterms LIKE 'Net 30';                                                                 --8

SELECT title FROM titles WHERE ytd_sales IS NULL;                                              --9

SELECT title FROM titles WHERE ISNULL(ytd_sales, 1) = 1;                                       --10