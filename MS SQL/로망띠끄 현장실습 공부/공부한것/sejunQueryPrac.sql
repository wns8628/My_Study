----���� =�ε���, Ʈ���� �̰Դ���


--ǥ�طα��� ���� sql��������
exec sp_addlogin 'user1', '1234'  
go 


create table T1(
	idx int,
	test_column varchar(100),
	test_column2 text
)

select * from T1

insert into T1 values(1,'hello','world')
insert into T1(idx,test_column,test_column2) values(2,'hello2','world2')

drop table T1

-------------------------------------------

create table Test_table(
idx bigint,
Name varchar(10),
�б� varchar(10),
�г� char(1)
)

insert into Test_table values(1,'ȫ�浿','���','1');
insert into Test_table values(2,'���','����','2');
insert into Test_table values(3,'ȣ����','���','1');
insert into Test_table values(4,'�޶ѱ�','���','2');
insert into Test_table values(5,'�⸰','����','1');
insert into Test_table values(6,'�����','����','2');
insert into Test_table values(7,'���ϳ�','���','1');
insert into Test_table values(8,'���ĸ�Ÿ','����','2');
insert into Test_table values(9,'����','���','1');
insert into Test_table values(10,'�߱�','����','2');



select * from Test_table
select * from Test_table where �б� = '����'
select * from Test_table where �б� = '����' and �г� = 1
select * from Test_table where (�б�='����' and �г�=1) or (�б�='���' and  �г�=2)


select * from Test_table where idx>=3 and idx <= 8     -- �̷��Ծ��°��� ������ 
select * from Test_table where idx between 3 and 8     -- �̷��Ծ���
select * from Test_table where idx in (3,5,8,9)
select  DISTINCT(�г�) from Test_table				   -- �ߺ����� �г����� �̾Ƴ���


--�������� �� ��������� ������ �ٽ� ��������� �ϴ� ��---------------------------------------------------------

select * from Test_table
select �б� from Test_table where Name='���'  -- ����

-- ����
select * from Test_table where �б� ='����'
select * from Test_table where �б� = ( select �б� from Test_table where Name='���' )
-- 

select DISTINCT(�б�) from Test_table where �г�='2' -- �б��� �˾Ƴ��� 2�г���ģ������

select * from Test_table where �б� = ANY(select DISTINCT(�б�) from Test_table where �г�='2')

-- �б��� 2�г�ģ����� ���� �����͸��̾Ƴ��� 

select * from Test_table order by idx desc --idx�� �������� �������� 

select top(3) * from Test_table order by idx desc -- idx�� �������� �������� ������ ž3�� �̾ƿ´�.


select count (*) from Test_table --10��
select top(select count (*) / 5 from Test_table) * from Test_table order by idx asc --������������20
select top(20)percent * from Test_table order by idx asc -- �̷��Ծ�

---- �׷����

select * from Test_table; 
select �б�,count(*) from Test_table group by �б�   --�б����� �������
select �б�,�г�,count(*) from Test_table group by �б�,�г� -- �б��г⺰�� �������

-- + having 
select �б�,�г�,count(*) from Test_table group by �б�,�г� having �г� =2    -- 
select �б�,�г�,count(*) from Test_table where  �г� = 2 group by �б�,�г�   -- ����.


 
/*���� ���� ����� ��Ÿ���ϴ�. ���� ���⼭ having�� where ���� ���̸� �̾߱� ���ڸ� ���� �����ϴ�.
���� �����͸� ������ ������ ���� �����δ� having �� ���� ���� ����� ������������ ���� ���̰� ���ٰ� ���� �ǰڽ��ϴ�.
�׷� ������ where �� �������� �� having���� �������� ������ ��� �ǰڴµ� ���� ���� �� �ִ� �κ��� �����������̶��
���ϰ� �ͽ��ϴ�. ���� ��� ������ �ϴ� ���� where ���� ���� ����� ����ϰ� �˴ϴ�.
�� where ���� ������ �ʹ� ���� ���� ������ �������� �翬�� �������� �Ǿ��ֽ��ϴ�. 
�� �������� �����̶� ���̱� ���ؼ� where �� ���� �ʰ� �ٸ� ���·� ���� �� �ִ� ���� �ִ��� ������ �������� 
�������� ���ؼ� �ʿ��ϴٰ� �����ϴ� �κ��Դϴ�. */

------------------------------------
--���� ����ϴ� �Լ�--------------------------------------------------------------------------------------------

create table ����(
   idx bigint primary key identity(1,1),
   Name varchar(100),
   ���� decimal(18,0),
   ���� decimal(18,0),
   ���� decimal(18,0)
   )

 insert into ���� (Name,����,����,����) values('ȫ�浿',80,78,89);
 insert into ���� (Name,����,����,����) values('���',65,65,21);
 insert into ���� (Name,����,����,����) values('ȣ����',98,67,97);
 insert into ���� (Name,����,����,����) values('�޶ѱ�',65,48,37);
 insert into ���� (Name,����,����,����) values('�⸰',91,64,78);
 insert into ���� (Name,����,����,����) values('�����',19,54,76);
 insert into ���� (Name,����,����,����) values('���ϳ�',98,65,78)
 insert into ���� (Name,����,����,����) values('���ĸ�Ÿ',64,18,59);
 insert into ���� (Name,����,����,����) values('����',98,79,98);
 insert into ���� (Name,����,����,����) values('�߱�',88,67,49);

 delete ���� where idx='11'
 
 

 select * from  ����
 select count(*) from ���� --���ڵ尳��
 select sum(����) as ���������հ�,sum(����),sum(����) from ���� --�հ�
 
 -- �����ռ����� ���� group by�� ���� ��� ����ϴ� ��찡 �����ϴ�.
 -- convert = ����ȯ


 select convert(int,(����/10))*10 ,count(*) ,sum(����)
 from ���� group by convert(int,(����/10)) having convert(int,(����/10))>=7 
--//���� int ���� / 10�� �ߴµ� �Ǽ������� �ڵ����� ���� �Ǿ� ���� �ٽ� int ������ convert �� ���� ���Դϴ�.
-- ��ó�� ���α׷��� ���� ������ �ణ �ణ �ٸ��� �����Ͻñ� �ٶ��ϴ�.)


/*
 AVG() - ����� ���ϴ� �ռ�
 MIN() - �ּҰ��� ���ϴ� �Լ�
 MAX() - �ִ밪�� ���ϴ� �Լ�
 STDEV() - ǥ�� ������ ���ϴ� �Լ�
*/

select avg(����),min(����),max(����),STDEV(����) from ����



--//insert, delete, update---------------------------------------------------------------------------

 insert into Test_table(idx,name,�б�,�г�) values(11,'����','�߾�','3')  --1
 insert into Test_table values(12,'����','���','1')  --2
 select * from Test_table

create table Test_table2(
 idx bigint,
 Name varchar(10),
 �б� varchar(10),
 �г� char(1)
)

select * from Test_table2

insert into Test_table2 select idx,Name,�б�,�г� from Test_table --3 

-- update ���̺� �̸� set �÷��� = �����Ͱ� where ����

update Test_table2     --idx�� 11�� ���� �б��� �������ιٲ۴�
set �б� ='����'
where idx=11


--Delete ���̺�� where ���ǹ�
delete Test_table2 where idx='12' --����� 

select * from Test_table2


--------------------------------------------------------

-----DDL ,  create.alter,drop
/* DDL ���� �� Table ������ ���Ǵ� ���� �̴մϴ�.
   Procedure, Index���� ������ ���ϴ� ��� ���� DDL�̶�� �մϴ�.
   �׷��Ƿ� Create Procedure, Create Index �μ� ������ ����մϴٸ�,
   ������ �������� Procedure, Index�� �ϸ� ������ �찥���� Table
   �������� �Ϻ��������� �����ϵ��� �ϰڽ��ϴ�.*/

create table Test_table2(
 idx bigint,
 �б� varchar(10),
 ���� varchar(10)
)

--alter table ���̺�� add �÷��� ����Ÿ��       alter =���̺���� 
--�÷��� �÷� �̸��� �������� ���ϰ� ���������̳� ���߿� ��� ���� ���� ������ �� �ֽ��ϴ�.

 select * from Test_table2

 alter table Test_table2 add ���� varchar(10) --�÷��߰� 
 
 alter table Test_table2
 alter column ���� varchar(100)       --������������


 alter table Test_table2
 drop column ����                     --�÷�������

 drop table Test_table2               --���̺� ������

 ------------------------------------------------------------------
--join
 select * from Test_table
 select * from ����
 
 select * from [dbo].[Test_table]
 select * from [dbo].[����]

 --��ȫ�浿�� ����б��� 1�г�, ������ ��.��.���Դϴ�.��

 /* �׷��� ���ؼ��� �� ���̺��� �����÷�(Ű)�� �����ϴµ� 
 ���� �ε���(idx)�� Ű�� ����, �� �б�, �г� ���� ���̺��� 
 idx 1�� ���� ���̺��� idx 1�� ���� ������� ������ �ϴ� ���Դϴ�.*/


 --SELECT <�����> FROM <���̺� 1> INNER JOIN <���̺� 2> ON <�˻��� ����> WHERE <�˻�����>

 SELECT
    a.Name,             -- �б�, �г� ���̺��� Name �÷�
    a.�б�,               -- �б�, �г� ���̺��� �б� �÷�
    a.�г�,               -- �б�, �г� ���̺��� �г� �÷�
    b.����,               -- ���� ���̺��� ���� �÷�
    b.����,               -- ���� ���̺��� ���� �÷�
    b.����                -- ���� ���̺��� ���� �÷�
FROM
    Test_table a        -- �б�, �г� ���̺� a�� ġȯ
    INNER JOIN          -- ����
    ���� b                -- ���� ���̺��� b�� ġȯ
ON a.idx = b.idx  

Create table �뵷(
	idx bigint identity(1,1),
	Name varchar(20),
	�� decimal(18,0)
)
select * from �뵷

insert into �뵷 values('ȫ�浿',1000);
insert into �뵷 values('���',2000);

 SELECT
    a.Name,             -- �б�, �г� ���̺��� Name �÷�
    a.�б�,               -- �б�, �г� ���̺��� �б� �÷�
    a.�г�,               -- �б�, �г� ���̺��� �г� �÷�
    b.����,               -- ���� ���̺��� ���� �÷�
    b.����,               -- ���� ���̺��� ���� �÷�
    b.����,               -- ���� ���̺��� ���� �÷�
    c.��                 -- �뵷 ���̺��� ��
FROM
    Test_table a        -- �б�, �г� ���̺� a�� ġȯ
    INNER JOIN          -- ����
    ���� b                -- ���� ���̺��� b�� ġȯ
    ON a.idx = b.idx    -- Ű ����
    INNER JOIN
    �뵷 c                -- �뵷 ���̺��� c�� ġȯ
    ON a.idx = c.idx   

--�����Ͱ� ��� ��Ÿ����
SELECT
    a.Name,             -- �б�, �г� ���̺��� Name �÷�
    a.�б�,               -- �б�, �г� ���̺��� �б� �÷�
    a.�г�,               -- �б�, �г� ���̺��� �г� �÷�
    b.����,               -- ���� ���̺��� ���� �÷�
    b.����,               -- ���� ���̺��� ���� �÷�
    b.����,               -- ���� ���̺��� ���� �÷�
    c.��                 -- �뵷 ���̺��� ��
FROM
    Test_table a        -- �б�, �г� ���̺� a�� ġȯ
    INNER JOIN          -- ����
    ���� b                -- ���� ���̺��� b�� ġȯ
    ON a.idx = b.idx    -- Ű ����
    LEFT OUTER JOIN
    �뵷 c                -- �뵷 ���̺��� c�� ġȯ
    ON a.idx = c.idx    -- Ű ����


--����б��� 1�г����� ���� ���̰�
--�뵷�� ���� �ʰ� 
--���������� 80���� �л��� ����������� ��Ÿ����� �ǹ��Դϴ�.

SELECT
    a.Name,             -- �б�, �г� ���̺��� Name �÷�
    a.�б�,               -- �б�, �г� ���̺��� �б� �÷�
    a.�г�,               -- �б�, �г� ���̺��� �г� �÷�
    b.����,               -- ���� ���̺��� ���� �÷�
    b.����,               -- ���� ���̺��� ���� �÷�
    b.����,               -- ���� ���̺��� ���� �÷�
    isnull(c.��,0) as ��  -- �뵷 ���̺��� ��
FROM
    Test_table a          -- �б�, �г� ���̺� a�� ġȯ
    INNER JOIN            -- ����
    ���� b                -- ���� ���̺��� b�� ġȯ
    ON a.idx = b.idx      -- Ű ����
    LEFT OUTER JOIN
    �뵷 c                -- �뵷 ���̺��� c�� ġȯ
    ON a.idx = c.idx      -- Ű ����
WHERE
    a.�б� = '���'
AND
    a.�г� = '1'
AND
    b.���� > 80
AND
    c.�� is null
ORDER BY
    ���� DESC

---------------------------

------------------------------------------------------------------------------------------�ǽ�

Create table ebook(
	ebook_no int PRIMARY KEY,
	ebook_name varchar(50),
	ebook_code varchar(10),
	ebook_img  varchar(100),
	ebook_RegDate varchar(20),
	ebook_author varchar(10),
	ebook_MakeCom varchar(10),
	ebook_isadult char,
	ebook_setNo int, -- FOREIGN KEY REFERENCES ebookset(set_No),
	ebook_totalpage smallint,
    ebook_genre varchar(20),
	ebook_price int,
	ebook_grade tinyint,
	ebook_issell char,
	ebook_count tinyint 
)



Create table ebookset(
	set_No int PRIMARY KEY,
	set_name varchar(50),
	set_img  varchar(100),
	set_RegDate varchar(20),
	set_author varchar(10),
	set_MakeCom varchar(10),
	set_genre varchar(20),
	set_amount tinyint 
)

Create table myshelf(
	idx int PRIMARY KEY,
	user_No int,
	ebook_no int, --FOREIGN KEY REFERENCES ebook(ebook_no),
	is_set char,
	set_No int, --FOREIGN KEY REFERENCES ebookset(set_No),
	ebook_buytime varchar(20)
)

drop table ebook
drop table ebookset
drop table myshelf


select * from ebook
select * from ebookset
select * from myshelf


				 -- ����å= å��ȣ, å�̸�, å�ڵ�, �̹���, ��ϳ�¥, �۰�, ���ǻ�, 19������, ��Ʈ��ȣ, ��������, �帣, ����, ����, �Ǹſ���, å����

insert into ebook values(1,'������1��','N001','img_1','2018-07-01','�質��','������','Y',1,200,'�׼�',3500,4,'Y',1);
insert into ebook values(2,'������2��','N002','img_2','2018-07-01','�質��','������','Y',1,200,'�׼�',3500,4,'Y',2);
insert into ebook values(3,'������3��','N003','img_3','2018-07-01','�質��','������','Y',1,200,'�׼�',3500,4,'Y',3);
insert into ebook values(4,'������4��','N004','img_4','2018-07-01','�質��','������','Y',1,200,'�׼�',3500,4,'Y',4);
insert into ebook values(5,'������5��','N005','img_5','2018-07-05','�質��','������','Y',1,200,'�׼�',3500,4,'Y',5);

insert into ebook values(6,'�ﱹ��1��','S001','img_6','2018-07-02','�̹���','������','N',2,300,'����Ҽ�',5000,5,'Y',1);
insert into ebook values(7,'�ﱹ��2��','S002','img_7','2018-07-02','�̹���','������','N',2,300,'����Ҽ�',5000,5,'Y',2);
insert into ebook values(8,'�ﱹ��3��','S003','img_8','2018-07-02','�̹���','������','N',2,300,'����Ҽ�',5000,5,'Y',3);
insert into ebook values(9,'�ﱹ��4��','S004','img_9','2018-07-03','�̹���','������','N',2,300,'����Ҽ�',5000,5,'Y',4);
insert into ebook values(10,'�ﱹ��5��','S005','img_10','2018-07-04','�̹���','������','N',2,300,'����Ҽ�',5000,5,'Y',5);

--�ܱ�
insert into ebook values(11,'�����ͺ��̽�','D001','img_11','2018-07-06','������','�������ǻ�','N', Null,300,'����',10000,5,'Y',1);
insert into ebook values(12,'SQL����','D002','img_12','2018-07-05','�輭��','��������','N', Null,300,'����',10000,5,'Y',1);
insert into ebook values(13,'PHP�Թ�','P001','img_13','2018-07-04','�赿��','�������Ͻ�','N',Null,300,'����',5000,5,'Y',1);





			     --��Ʈ = ��Ʈ��ȣ,��Ʈ����,�̹���,��ϳ�¥(���ֱٰŵ��),�۰�,���ǻ�,�帣,�ѱǼ�
insert into ebookset values(1,'������','set_img1','2018-07-01','�質��','������','�׼�',10);                  --1����Ʈ ������
insert into ebookset values(2,'�ﱹ��','set_img2','2018-07-04','�̹���','������','����Ҽ�',10);              --2����Ʈ �ﱹ��

update ebookset set set_RegDate ='2018-07-05' where set_No=1 --���� ��Ʈå�� ������ �ֱٵ�ϳ�¥�ιٲ�


--�� ���絥���ͳֱ�      idx,ȸ����ȣ,å ��ȣ,��Ʈ����,��Ʈ��ȣ,���Žð�

--1��ȸ�� 
insert into myshelf values(1,1,1,'Y',1,'2018-07-04');    --������1��    
insert into myshelf values(2,1,2,'Y',1,'2018-07-05');    --������2��
insert into myshelf values(3,1,6,'Y',2,'2018-07-05');    --�ﱹ��1��
insert into myshelf values(4,1,7,'Y',2,'2018-07-06');    --�ﱹ��2�� 
insert into myshelf values(5,1,11,'N',Null,'2018-07-06'); -- �ܱ�
insert into myshelf values(6,1,12,'N',Null,'2018-07-06'); -- �ܱ� 
          
--2��ȸ�� 
insert into myshelf values(7,2,6,'Y',2,'2018-07-05');    --�ﱹ��1��
insert into myshelf values(8,2,7,'Y',2,'2018-07-05');    --�ﱹ��2�� 
insert into myshelf values(9,2,8,'Y',2,'2018-07-05');    --�ﱹ��3��
insert into myshelf values(10,2,9,'Y',2,'2018-07-05');    --�ﱹ��4�� 
insert into myshelf values(11,2,10,'Y',2,'2018-07-05');    --�ﱹ��5��


 
-----------------------����---------------------------------------------------------------------------------------------------------------------------------------------------- 

select * from ebook
select * from ebookset
select * from myshelf

----------
select user_No,set_No from myshelf 

------------


select set_name as ��Ʈ����, set_img as ��Ʈ�̹���, set_RegDate as ��ϳ�¥, set_author as �۰���, set_MakeCom as ���ǻ�, set_genre as �帣, set_amount as �ѱǼ� from ebookset
select set_name as ��Ʈ����, set_img as ��Ʈ�̹���, set_RegDate as ��ϳ�¥, set_author as �۰���, set_MakeCom as ���ǻ�, set_genre as �帣, set_amount as �ѱǼ� from ebookset where set_No=1 or set_No=2

---------------------------��Ʈ����å �����ͻ̱�

select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y'  --ȸ����ȣ 1�λ���� ��Ʈ������ ��� 

--1��ȸ��
select b.set_name as ��Ʈ����, b.set_img as ��Ʈ�̹���, b.set_RegDate as ��ϳ�¥, b.set_author as �۰���, b.set_MakeCom as ���ǻ�, b.set_genre as �帣, b.set_amount as �ѱǼ� from 
(
select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
) a INNER JOIN ebookset b ON a.set_No = b.set_No

--2��ȸ��
select b.set_name as ��Ʈ����, b.set_img as ��Ʈ�̹���, b.set_RegDate as ��ϳ�¥, b.set_author as �۰���, b.set_MakeCom as ���ǻ�, b.set_genre as �帣, b.set_amount as �ѱǼ� from 
(
select DISTINCT(set_No) from myshelf where user_No =2 and is_set= 'Y' 
) a INNER JOIN ebookset b ON a.set_No = b.set_No


-------------------------��Ʈ�ƴ�����å ������ �̱�
--ȸ��1
select ebook_no from myshelf where user_No='1' and is_set='N'

select b.ebook_name as å����, b.ebook_img as �̹���, b.ebook_RegDate as ��ϳ�¥, b.ebook_author as �۰���, b.ebook_MakeCom as ���ǻ�, b.ebook_genre as �帣 from    -- '0' as �ѱǼ� ??
(
select ebook_no from myshelf where user_No='1' and is_set='N'
) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no


------------------------------------��ġ��-------------------------------------------   ������ ��� ��Ͽ��� ������ ������ ���� �־�� �մϴ�.
select * from
(
	select b.set_name as ����, b.set_img as �̹���, b.set_RegDate as ��ϳ�¥, b.set_author as �۰���, b.set_MakeCom as ���ǻ�, b.set_genre as �帣, b.set_amount as �ѱǼ�, 'set' as ���ο�,
	0 as ���� , 'set' as �Ǹſ���, 0 as ���� from 
	(
	select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
	) a INNER JOIN ebookset b ON a.set_No = b.set_No

	union all 

	select b.ebook_name as ����, b.ebook_img as �̹���, b.ebook_RegDate as ��ϳ�¥, b.ebook_author as �۰���, b.ebook_MakeCom as ���ǻ�, b.ebook_genre as �帣, 0 as �ѱǼ�, b.ebook_isadult as ���ο�, b.ebook_grade as ���� ,
	       b.ebook_issell as �Ǹſ���, b.ebook_price as ���� from  
	(
	select ebook_no from myshelf where user_No='1' and is_set='N'
	) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no

) as tablesum

--------------------------------------------------------------

select * from ebook where ebook_setNo=1 and ebook_issell='Y'


-------------����
 --ROW_NUMBER() OVER (ORDER BY ebookWriter ASC) AS RowNum

select ����,�̹���, ��ϳ�¥, �۰���, ���ǻ�, �帣 ,�ѱǼ�, ROW_NUMBER() OVER (ORDER BY ��ϳ�¥ DESC) AS RowNum 
from
(

	select b.set_name as ����, b.set_img as �̹���, b.set_RegDate as ��ϳ�¥, b.set_author as �۰���, b.set_MakeCom as ���ǻ�, b.set_genre as �帣, b.set_amount as �ѱǼ� from 
	(
	select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
	) a INNER JOIN ebookset b ON a.set_No = b.set_No

	union all 

	select b.ebook_name, b.ebook_img , b.ebook_RegDate as ��ϳ�¥, b.ebook_author as �۰���, b.ebook_MakeCom as ���ǻ�, b.ebook_genre as �帣, '0' as �ѱǼ� from  
	(
	select ebook_no from myshelf where user_No='1' and is_set='N'
	) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no

) as sort


--����¡ 
select * from
	(

		select ����,�̹���, ��ϳ�¥, �۰���, ���ǻ�, �帣 ,�ѱǼ�, ROW_NUMBER() OVER (ORDER BY �۰��� ASC) AS RowNum from
		(

			select b.set_name as ����, b.set_img as �̹���, b.set_RegDate as ��ϳ�¥, b.set_author as �۰���, b.set_MakeCom as ���ǻ�, b.set_genre as �帣, b.set_amount as �ѱǼ� from 
			(
			select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
			) a INNER JOIN ebookset b ON a.set_No = b.set_No

			union all 

			select b.ebook_name, b.ebook_img , b.ebook_RegDate as ��ϳ�¥, b.ebook_author as �۰���, b.ebook_MakeCom as ���ǻ�, b.ebook_genre as �帣, '0' as �ѱǼ� from  
			(
			select ebook_no from myshelf where user_No='1' and is_set='N'
			) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no
		) as sort 

	) as pageing WHERE RowNum BETWEEN 1 AND 3 
	

--1 . �˻�  : �۰� or �۰��� , �˻������ ����¡
select * from
	(

		select ����,�̹���, ��ϳ�¥, �۰���, ���ǻ�, �帣 ,�ѱǼ�, ROW_NUMBER() OVER (ORDER BY ��ϳ�¥ DESC) AS RowNum from
		(

			select b.set_name as ����, b.set_img as �̹���, b.set_RegDate as ��ϳ�¥, b.set_author as �۰���, b.set_MakeCom as ���ǻ�, b.set_genre as �帣, b.set_amount as �ѱǼ� from 
			(
			select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
			) a INNER JOIN ebookset b ON a.set_No = b.set_No where b.set_name like '%������%' or b.set_author like '%�̹���%'
			
			union all 

			select b.ebook_name, b.ebook_img , b.ebook_RegDate as ��ϳ�¥, b.ebook_author as �۰���, b.ebook_MakeCom as ���ǻ�, b.ebook_genre as �帣, '0' as �ѱǼ� from  
			(
			select ebook_no from myshelf where user_No='1' and is_set='N'
			) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no where b.ebook_name like '%������%'  or b.ebook_author like '%�̹���%'
		) as sort 
	) as search WHERE RowNum BETWEEN 1 AND 3 


--------------------------------


--2.���� : 6���� ���Ĺ�� - ���ż� ,�۰���, ��ǰ�� (ASC,DESC)
select * from																
	(																					--��ϳ�¥,�۰���,���� ASC , DESC
		select ����,�̹���, ��ϳ�¥, �۰���, ���ǻ�, �帣 ,�ѱǼ�, ROW_NUMBER() OVER (ORDER BY ���� ASC) AS RowNum from
		(

			select b.set_name as ����, b.set_img as �̹���, b.set_RegDate as ��ϳ�¥, b.set_author as �۰���, b.set_MakeCom as ���ǻ�, b.set_genre as �帣, b.set_amount as �ѱǼ� from 
			(
			select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
			) a INNER JOIN ebookset b ON a.set_No = b.set_No

			union all 

			select b.ebook_name, b.ebook_img , b.ebook_RegDate as ��ϳ�¥, b.ebook_author as �۰���, b.ebook_MakeCom as ���ǻ�, b.ebook_genre as �帣, '0' as �ѱǼ� from  
			(
			select ebook_no from myshelf where user_No='1' and is_set='N'
			) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no
		) as sort 
	) as sort

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--3. nonŬ����Ƽ�� �ε��� �ɱ�
select * from ebook
select * from ebookset
select * from myshelf

create nonclustered index ebook_index
on ebook(ebook_setNo);

create nonclustered index myshelf_index
on myshelf(ebook_no,set_no);


--Ȯ��
EXEC SP_HELPINDEX ebook
EXEC SP_HELPINDEX myshelf

--����	
DROP INDEX ebook.ebook_index
DROP INDEX myshelf.myshelf_index
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--4.������ ���� ����
 --����1 : �˻��� 
 --����2 : ���ļ���            

 
 DECLARE @search varchar(20)
 DECLARE @sort varchar(20)
 DECLARE @sort2 varchar(10)
 
 SET @search='%%'
 SET @sort='�۰���'
 SET @sort2=DESC
   

 select * from
	(

		select ����,�̹���, ��ϳ�¥, �۰���, ���ǻ�, �帣 ,�ѱǼ�, ROW_NUMBER() OVER (ORDER BY @sort + @sort2) AS RowNum from
		(

			select b.set_name as ����, b.set_img as �̹���, b.set_RegDate as ��ϳ�¥, b.set_author as �۰���, b.set_MakeCom as ���ǻ�, b.set_genre as �帣, b.set_amount as �ѱǼ� from 
			(
			select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
			) a INNER JOIN ebookset b ON a.set_No = b.set_No where b.set_name like @search or b.set_author like @search or b.set_MakeCom like @search or b.set_genre like @search 
			
			union all 

			select b.ebook_name, b.ebook_img , b.ebook_RegDate as ��ϳ�¥, b.ebook_author as �۰���, b.ebook_MakeCom as ���ǻ�, b.ebook_genre as �帣, '0' as �ѱǼ� from  
			(
			select ebook_no from myshelf where user_No='1' and is_set='N'
			) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no where b.ebook_name like @search or  b.ebook_author like @search or  b.ebook_MakeCom like @search or b.ebook_genre like @search
		) as sort 
	) as search WHERE RowNum BETWEEN 1 AND 3 


------------------------------------------------------------------

--4.������ ���� ����   ---����	
 --����1 : �˻��� 
 --����2 : ���ļ���            


 DECLARE @search varchar(20)
 DECLARE @sort varchar(20)
 DECLARE @sort2 varchar(10)

 SET @search=''				-- �˻����Է�
 SET @sort='ebook_author'	-- ����,�����,�۰���
 SET @sort2='DESC'			-- ��������,��������
   
 select * from
	(
		select ebook_name,ebook_img, ebook_RegDate,ebook_author,ebook_MakeCom,ebook_genre,amount,is_set,set_No ,ROW_NUMBER() OVER (ORDER BY 
		(
		CASE @sort2
			WHEN 'ASC' THEN 
					CASE @sort
						WHEN 'ebook_name' THEN ebook_name       --�����
						WHEN 'ebook_RegDate' THEN ebook_RegDate --����ϼ�
						WHEN 'ebook_author' THEN ebook_author   --�۰��� 
					END
		END
		) ASC,
		(
		CASE @sort2
			WHEN 'DESC' THEN 
					CASE @sort
						WHEN 'ebook_name' THEN ebook_name       --�����
						WHEN 'ebook_RegDate' THEN ebook_RegDate --����ϼ�
						WHEN 'ebook_author' THEN ebook_author   --�۰��� 
					END
		END
		) DESC
		) AS RowNum from
		(

			select b.set_name as ebook_name, b.set_img as ebook_img, b.set_RegDate as ebook_RegDate, b.set_author as ebook_author, b.set_MakeCom as ebook_MakeCom, b.set_genre as ebook_genre,
				   b.set_amount as amount, a.is_set as is_set, a.set_No as set_No
			from 
			(
			select DISTINCT(set_No),is_set from myshelf where user_No =1 and is_set= 'Y' 
			) a INNER JOIN ebookset b ON a.set_No = b.set_No where b.set_name like '%'+ @search +'%' or b.set_author like '%'+ @search +'%' or b.set_MakeCom like '%'+ @search +'%' or b.set_genre like '%'+ @search +'%' 
			
			union all 

			select b.ebook_name, b.ebook_img , b.ebook_RegDate as ebook_RegDate, b.ebook_author as ebook_author, b.ebook_MakeCom as ebook_MakeCom, b.ebook_genre as ebook_genre, '0' as amount, 
				   a.is_set as is_set ,Null as set_No
			from  
			(
			select ebook_no,is_set from myshelf where user_No='1' and is_set='N'
			) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no where b.ebook_name like '%'+ @search +'%' or  b.ebook_author like '%'+ @search +'%' or  b.ebook_MakeCom like '%'+ @search +'%' or b.ebook_genre like '%'+ @search +'%'
		) as sort 
	) as search WHERE RowNum BETWEEN 1 AND 4 

-------------

--��Ʈ���� ȸ������ ��Ʈ������ϴ����? 
select * from
(
select DISTINCT(set_No),is_set from myshelf where user_No =1 and is_set= 'Y' 
) a INNER JOIN 
(select * from ebook where ebook_issell='Y') b ON a.set_No = b.ebook_setNo



-------------------------------------------------------------------------

--�ε����� ���� �� �ش� ���̺��� �뵵�� ��Ȯ�� �����ؾ��Ѵ�.

create table tb(

col1 int ,

col2 char(6)

)

insert into tb values(12,'ȫ�浿');
insert into tb values(14,'�Ȱ���');
insert into tb values(28,'��ġ��');
insert into tb values(27,'����ź');
insert into tb values(13,'��ȣ��');
insert into tb values(22,'�谨��');
insert into tb values(17,'�ѱ���');
insert into tb values(15,'�ڻ系');
insert into tb values(19,'���ְ�');
insert into tb values(21,'���⳪');
insert into tb values(18,'�̸���');
insert into tb values(26,'��ġ��');
insert into tb values(16,'�����');
insert into tb values(24,'������');
insert into tb values(23,'������');
insert into tb values(20,'�踻��');
insert into tb values(25,'�����');
insert into tb values(11,'��ڻ�');

--���̺��� �����ϰ� �����͸� insert �ϸ� �����ʹ� �������������� �������� ����� �ȴ�. �ϳ��� �������������� ũ��� 8kb�̸�, row���� �ʵ� ũ�⸸ŭ ������ �ȴ�.
drop table tb

select * from tb 

create unique nonclustered index tb_ix_col1              --�� + ��Ŭ����Ƽ��
on tb(col1);

select * from tb where col1 = 19

------------------------------------------

create unique clustered index tb_ix_col3   -- col1�� Ŭ�������ε���
on tb(col1);

create unique nonclustered index tb_ix_col4 --col2�� nonŬ�������ε���
on tb(col2);

select * from tb where col2 = '����ź'


-- tb�� Column_01�� �׻� �˻��� ���� �ʿ��ϰ�, Column_02�� �˻��� ����� ������ ������, ���� �ʿ��� ���� �ִ�.
-- �� ��쿡�� �Ʒ��� ���� INCLUDE ������ ���� ������ ������ų �� �ִ�.
CREATE INDEX tb_ix_col2
ON tb(col1) INCLUDE (col2)

create unique clustered index tb_ix_col1
on tb(col1);

-- tb�� Column_01�� �ִ� �ε��� tb_ix_col1�� ����

DROP INDEX tb.tb_ix_col1
DROP INDEX tb.tb_ix_col2

select * from tb where col2 = '����ź'

--tb�ε���Ȯ�� 
EXEC SP_HELPINDEX tb

--* �����ͺ��̽��� ��� �ε��� Ȯ��
select distinct ft.owner_name, ft.table_name, ft.index_name, ft.column_name
from (
 select s.name as owner_name, t.name as table_name, i.name as index_name, c.name as column_name
 from sys.tables t
  inner join sys.schemas s
  on t.schema_id = s.schema_id
  inner join sys.indexes i
  on i.object_id = t.object_id
  inner join sys.index_columns ic
  on ic.object_id = t.object_id
  inner join sys.columns c
  on c.object_id = t.object_id
   and ic.column_id = c.column_id
 where i.index_id > 0    
  and i.type in (1, 2) -- clustered & nonclustered only
  and i.is_primary_key = 0 -- do not include PK indexes
  and i.is_unique_constraint = 0 -- do not include UQ
  and i.is_disabled = 0
  and i.is_hypothetical = 0
  and ic.key_ordinal > 0
  --and t.name = 'A_Table'
 ) as ft 
 -------------------











 CREATE TABLE Table1 (
	Seq	int not null,
	CONSTRAINT PK_Table1 PRIMARY KEY NONCLUSTERED(Seq)
)
GO

CREATE TABLE Table2 (
	Seq	int not null,
	CONSTRAINT PK_Table2 PRIMARY KEY CLUSTERED(Seq)
)
GO
