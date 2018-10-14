------------------------------------------------------------------------------------------실습

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

--테이블삭제
drop table ebook
drop table ebookset
drop table myshelf


select * from ebook
select * from ebookset
select * from myshelf


				 -- 전자책= 책번호, 책이름, 책코드, 이미지, 등록날짜, 작가, 출판사, 19세여부, 세트번호, 페이지수, 장르, 가격, 평점, 판매여부, 책순서

insert into ebook values(1,'나루토1권','N001','img_1','2018-07-01','김나루','나뭇잎','Y',1,200,'액션',3500,4,'Y',1);
insert into ebook values(2,'나루토2권','N002','img_2','2018-07-01','김나루','나뭇잎','Y',1,200,'액션',3500,4,'Y',2);
insert into ebook values(3,'나루토3권','N003','img_3','2018-07-01','김나루','나뭇잎','Y',1,200,'액션',3500,4,'Y',3);
insert into ebook values(4,'나루토4권','N004','img_4','2018-07-01','김나루','나뭇잎','Y',1,200,'액션',3500,4,'Y',4);
insert into ebook values(5,'나루토5권','N005','img_5','2018-07-05','김나루','나뭇잎','Y',1,200,'액션',3500,4,'Y',5);

insert into ebook values(6,'삼국지1권','S001','img_6','2018-07-02','이문열','민음사','N',2,300,'역사소설',5000,5,'Y',1);
insert into ebook values(7,'삼국지2권','S002','img_7','2018-07-02','이문열','민음사','N',2,300,'역사소설',5000,5,'Y',2);
insert into ebook values(8,'삼국지3권','S003','img_8','2018-07-02','이문열','민음사','N',2,300,'역사소설',5000,5,'Y',3);
insert into ebook values(9,'삼국지4권','S004','img_9','2018-07-03','이문열','민음사','N',2,300,'역사소설',5000,5,'Y',4);
insert into ebook values(10,'삼국지5권','S005','img_10','2018-07-04','이문열','민음사','N',2,300,'역사소설',5000,5,'Y',5);

--단권
insert into ebook values(11,'데이터베이스','D001','img_11','2018-07-06','오세종','생능출판사','N', Null,300,'교육',10000,5,'Y',1);
insert into ebook values(12,'SQL서버','D002','img_12','2018-07-05','김서버','영진닷컴','N', Null,300,'교육',10000,5,'Y',1);
insert into ebook values(13,'PHP입문','P001','img_13','2018-07-04','김동섭','남가람북스','N',Null,300,'교육',5000,5,'Y',1);


			     --세트 = 세트번호,세트제목,이미지,등록날짜(젤최근거등록),작가,출판사,장르,총권수
insert into ebookset values(1,'나루토','set_img1','2018-07-01','김나루','나뭇잎','액션',10);                  --1번세트 나루토
insert into ebookset values(2,'삼국지','set_img2','2018-07-04','이문열','민음사','역사소설',10);              --2번세트 삼국지

update ebookset set set_RegDate ='2018-07-05' where set_No=1 --새로 세트책이 들어오면 최근등록날짜로바꿈


--내 서재데이터넣기      idx,회원번호,책 번호,세트여부,세트번호,구매시간

--1번회원 
insert into myshelf values(1,1,1,'Y',1,'2018-07-04');    --나루토1권    
insert into myshelf values(2,1,2,'Y',1,'2018-07-05');    --나루토2권
insert into myshelf values(3,1,6,'Y',2,'2018-07-05');    --삼국지1권
insert into myshelf values(4,1,7,'Y',2,'2018-07-06');    --삼국지2권 
insert into myshelf values(5,1,11,'N',Null,'2018-07-06'); -- 단권
insert into myshelf values(6,1,12,'N',Null,'2018-07-06'); -- 단권 
          
--2번회원 
insert into myshelf values(7,2,6,'Y',2,'2018-07-05');    --삼국지1권
insert into myshelf values(8,2,7,'Y',2,'2018-07-05');    --삼국지2권 
insert into myshelf values(9,2,8,'Y',2,'2018-07-05');    --삼국지3권
insert into myshelf values(10,2,9,'Y',2,'2018-07-05');    --삼국지4권 
insert into myshelf values(11,2,10,'Y',2,'2018-07-05');    --삼국지5권

-------------------------------------------

--인덱스

create nonclustered index ebook_index   -- 전자책 인덱스 
on ebook(ebook_setNo);

create nonclustered index myshelf_index -- 내 서재 인덱스1
on myshelf(ebook_no);

create nonclustered index myshelf_index2 -- 내 서재 인덱스2
on myshelf(set_no);

--확인
EXEC SP_HELPINDEX ebook
EXEC SP_HELPINDEX myshelf

--삭제	
DROP INDEX ebook.ebook_index
DROP INDEX myshelf.myshelf_index
DROP INDEX myshelf.myshelf_index2


-----------------------쿼리---------------------------------------------------------------------------------------------------------------------------------------------------- 
select * from ebook
select * from ebookset
select * from myshelf
-------------------------
 DECLARE @search varchar(20)
 DECLARE @sort varchar(20)
 DECLARE @sort2 varchar(10)

 SET @search=''				-- 검색어입력
 SET @sort='ebook_author'	-- 제목,등록일,작가순
 SET @sort2='ASC'			-- 오름차순,내림차순
   
 select * from
	(
		select ebook_name,ebook_img, ebook_RegDate,ebook_author,ebook_MakeCom,ebook_genre,amount,is_set,set_No ,ROW_NUMBER() OVER (ORDER BY 
		(
		CASE @sort2
			WHEN 'ASC' THEN 
					CASE @sort
						WHEN 'ebook_name' THEN ebook_name       --제목순
						WHEN 'ebook_RegDate' THEN ebook_RegDate --등록일순
						WHEN 'ebook_author' THEN ebook_author   --작가순 
					END
		END
		) ASC,
		(
		CASE @sort2
			WHEN 'DESC' THEN 
					CASE @sort
						WHEN 'ebook_name' THEN ebook_name       --제목순
						WHEN 'ebook_RegDate' THEN ebook_RegDate --등록일순
						WHEN 'ebook_author' THEN ebook_author   --작가순 
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
