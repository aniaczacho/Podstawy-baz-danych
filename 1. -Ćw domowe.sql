use library

--1.1
select title, title_no from title

--1.2
select title, title_no from title where title_no=10

--1.3
select member_no, isnull(fine_assessed,0)-isnull(fine_waived,0)-isnull(fine_paid,0) as fine 
from loanhist where isnull(fine_assessed,0)-isnull(fine_waived,0)-isnull(fine_paid,0) between 8 and 9

--1.4
select title, title_no from title where author = 'Charles Dickens' or author= 'Jane Austen'

--1.5
select title, title_no from title where title like '%adventures%'

--1.6
select member_no, isnull(fine_paid,0) as finePaid 
from loanhist where isnull(fine_paid,0)=0 and isnull(fine_assessed,0)>0

--1.7
select distinct city, state from adult 

--2.1
select title from title order by 1

--2.2.a
select member_no, isbn, fine_assessed from loanhist where isnull(fine_assessed,0)>0

--2.2.b
select member_no, isbn, fine_assessed, 2*fine_assessed from loanhist where isnull(fine_assessed,0)>0

--2.2.c
select member_no, isbn, fine_assessed, 2*fine_assessed as 'double fine' from loanhist 
where isnull(fine_assessed,0)>0

--2.3.a
select firstname + middleinitial + lastname  from member where lastname='Anderson'

--2.3.b
select firstname + middleinitial + lastname as email_name from member where lastname='Anderson'

--2.3.c
select lower(firstname + middleinitial + substring(lastname, 1, 2))  from member where lastname='Anderson'

--2.4
select 'The title is: '+ title + ', title number '+ str(title_no) from title 

