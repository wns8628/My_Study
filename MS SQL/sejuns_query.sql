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

--���̺����
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

-------------------------------------------

--�ε���

create nonclustered index ebook_index   -- ����å �ε��� 
on ebook(ebook_setNo);

create nonclustered index myshelf_index -- �� ���� �ε���1
on myshelf(ebook_no);

create nonclustered index myshelf_index2 -- �� ���� �ε���2
on myshelf(set_no);

--Ȯ��
EXEC SP_HELPINDEX ebook
EXEC SP_HELPINDEX myshelf

--����	
DROP INDEX ebook.ebook_index
DROP INDEX myshelf.myshelf_index
DROP INDEX myshelf.myshelf_index2


-----------------------����---------------------------------------------------------------------------------------------------------------------------------------------------- 
select * from ebook
select * from ebookset
select * from myshelf
-------------------------
 DECLARE @search varchar(20)
 DECLARE @sort varchar(20)
 DECLARE @sort2 varchar(10)

 SET @search=''				-- �˻����Է�
 SET @sort='ebook_author'	-- ����,�����,�۰���
 SET @sort2='ASC'			-- ��������,��������
   
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

-------------------------------------------------------------------------
