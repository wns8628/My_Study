----디비는 =인덱스, 트리거 이게다임


--표준로그인 생성 sql서버인증
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
학교 varchar(10),
학년 char(1)
)

insert into Test_table values(1,'홍길동','노원','1');
insert into Test_table values(2,'명월','강북','2');
insert into Test_table values(3,'호동이','노원','1');
insert into Test_table values(4,'메뚜기','노원','2');
insert into Test_table values(5,'기린','강북','1');
insert into Test_table values(6,'배신자','강북','2');
insert into Test_table values(7,'도둑놈','노원','1');
insert into Test_table values(8,'스파르타','강북','2');
insert into Test_table values(9,'멍지','노원','1');
insert into Test_table values(10,'야기','강북','2');



select * from Test_table
select * from Test_table where 학교 = '강북'
select * from Test_table where 학교 = '강북' and 학년 = 1
select * from Test_table where (학교='강북' and 학년=1) or (학교='노원' and  학년=2)


select * from Test_table where idx>=3 and idx <= 8     -- 이렇게쓰는것은 안좋다 
select * from Test_table where idx between 3 and 8     -- 이렇게쓰자
select * from Test_table where idx in (3,5,8,9)
select  DISTINCT(학년) from Test_table				   -- 중복제거 학년종류 뽑아내기


--하위쿼리 는 쿼리결과를 가지고 다시 쿼리계산을 하는 것---------------------------------------------------------

select * from Test_table
select 학교 from Test_table where Name='명월'  -- 강북

-- 같음
select * from Test_table where 학교 ='강북'
select * from Test_table where 학교 = ( select 학교 from Test_table where Name='명월' )
-- 

select DISTINCT(학교) from Test_table where 학년='2' -- 학교를 알아낸다 2학년인친구들의

select * from Test_table where 학교 = ANY(select DISTINCT(학교) from Test_table where 학년='2')

-- 학교가 2학년친구들과 같은 데이터를뽑아낸다 

select * from Test_table order by idx desc --idx를 기준으로 내림차순 

select top(3) * from Test_table order by idx desc -- idx를 기준으로 내림차순 했을때 탑3개 뽑아온다.


select count (*) from Test_table --10개
select top(select count (*) / 5 from Test_table) * from Test_table order by idx asc --오름차순상위20
select top(20)percent * from Test_table order by idx asc -- 이렇게씀

---- 그룹바이

select * from Test_table; 
select 학교,count(*) from Test_table group by 학교   --학교별로 몇명인지
select 학교,학년,count(*) from Test_table group by 학교,학년 -- 학교학년별로 몇명인지

-- + having 
select 학교,학년,count(*) from Test_table group by 학교,학년 having 학년 =2    -- 
select 학교,학년,count(*) from Test_table where  학년 = 2 group by 학교,학년   -- 같다.


 
/*역시 같은 결과를 나타냅니다. 제가 여기서 having과 where 절의 차이를 이야기 하자면 거의 없습니다.
많은 데이터를 가지고 있을때 로직 상으로는 having 이 좀더 빠른 결과를 내보내겠으나 거의 차이가 없다고 보면 되겠습니다.
그럼 귀찮게 where 로 통일하지 왜 having으로 나눌까라는 생각이 들게 되겠는데 제가 말할 수 있는 부분은 가독성때문이라고
말하고 싶습니다. 실제 디비 개발을 하다 보면 where 절을 정말 빈번히 사용하게 됩니다.
즉 where 절의 구문이 너무 많아 지기 때문에 가독성은 당연히 떨어지게 되어있습니다. 
이 가독성을 조금이라도 높이기 위해선 where 에 들어가지 않고 다른 형태로 빼낼 수 있는 것은 최대한 빼내는 것이후의 
가독성을 위해서 필요하다고 생각하는 부분입니다. */

------------------------------------
--자주 사용하는 함수--------------------------------------------------------------------------------------------

create table 성적(
   idx bigint primary key identity(1,1),
   Name varchar(100),
   국어 decimal(18,0),
   영어 decimal(18,0),
   수학 decimal(18,0)
   )

 insert into 성적 (Name,국어,영어,수학) values('홍길동',80,78,89);
 insert into 성적 (Name,국어,영어,수학) values('명월',65,65,21);
 insert into 성적 (Name,국어,영어,수학) values('호동이',98,67,97);
 insert into 성적 (Name,국어,영어,수학) values('메뚜기',65,48,37);
 insert into 성적 (Name,국어,영어,수학) values('기린',91,64,78);
 insert into 성적 (Name,국어,영어,수학) values('배신자',19,54,76);
 insert into 성적 (Name,국어,영어,수학) values('도둑놈',98,65,78)
 insert into 성적 (Name,국어,영어,수학) values('스파르타',64,18,59);
 insert into 성적 (Name,국어,영어,수학) values('멍지',98,79,98);
 insert into 성적 (Name,국어,영어,수학) values('야기',88,67,49);

 delete 성적 where idx='11'
 
 

 select * from  성적
 select count(*) from 성적 --레코드개수
 select sum(국어) as 국어점수합계,sum(영어),sum(수학) from 성적 --합계
 
 -- 집계합수들은 전부 group by와 같이 엮어서 사용하는 경우가 많습니다.
 -- convert = 형변환


 select convert(int,(국어/10))*10 ,count(*) ,sum(국어)
 from 성적 group by convert(int,(국어/10)) having convert(int,(국어/10))>=7 
--//위에 int 형에 / 10을 했는데 실수형으로 자동으로 변한 되어 제가 다시 int 형으로 convert 한 것이 보입니다.
-- 이처럼 프로그래밍 언어와 성질이 약간 약간 다르니 주의하시기 바랍니다.)


/*
 AVG() - 평균을 구하는 합수
 MIN() - 최소값을 구하는 함수
 MAX() - 최대값을 구하는 함수
 STDEV() - 표준 편차를 구하는 함수
*/

select avg(국어),min(국어),max(국어),STDEV(국어) from 성적



--//insert, delete, update---------------------------------------------------------------------------

 insert into Test_table(idx,name,학교,학년) values(11,'고릴라','중앙','3')  --1
 insert into Test_table values(12,'땡보','고려','1')  --2
 select * from Test_table

create table Test_table2(
 idx bigint,
 Name varchar(10),
 학교 varchar(10),
 학년 char(1)
)

select * from Test_table2

insert into Test_table2 select idx,Name,학교,학년 from Test_table --3 

-- update 테이블 이름 set 컬럼명 = 데이터값 where 조건

update Test_table2     --idx가 11인 행의 학교를 강북으로바꾼다
set 학교 ='강북'
where idx=11


--Delete 테이블명 where 조건문
delete Test_table2 where idx='12' --행삭제 

select * from Test_table2


--------------------------------------------------------

-----DDL ,  create.alter,drop
/* DDL 언어는 꼭 Table 에서만 사용되는 말이 이닙니다.
   Procedure, Index등의 구조를 뜻하는 모든 것은 DDL이라고 합니다.
   그러므로 Create Procedure, Create Index 로서 구문을 사용합니다만,
   지금은 순서없이 Procedure, Index를 하면 오히려 헤갈리니 Table
   구조부터 완벽히익히고 진행하도록 하겠습니다.*/

create table Test_table2(
 idx bigint,
 학교 varchar(10),
 지역 varchar(10)
)

--alter table 테이블명 add 컬럼명 데이타형       alter =테이블수정 
--컬럼은 컬럼 이름은 수정하지 못하고 데이터형이나 나중에 배울 제약 등을 변경할 수 있습니다.

 select * from Test_table2

 alter table Test_table2 add 국가 varchar(10) --컬럼추가 
 
 alter table Test_table2
 alter column 국가 varchar(100)       --데이터형변경


 alter table Test_table2
 drop column 국가                     --컬럼날리기

 drop table Test_table2               --테이블 날리기

 ------------------------------------------------------------------
--join
 select * from Test_table
 select * from 성적
 
 select * from [dbo].[Test_table]
 select * from [dbo].[성적]

 --「홍길동은 노원학교에 1학년, 성적은 국.영.수입니다.」

 /* 그러기 위해서는 두 테이블의 공통컬럼(키)을 결정하는데 
 저는 인덱스(idx)를 키로 설정, 즉 학교, 학년 정보 테이블의 
 idx 1은 성적 테이블의 idx 1과 같은 정보라는 설정을 하는 것입니다.*/


 --SELECT <열목록> FROM <테이블 1> INNER JOIN <테이블 2> ON <검색될 조건> WHERE <검색조건>

 SELECT
    a.Name,             -- 학교, 학년 테이블의 Name 컬럼
    a.학교,               -- 학교, 학년 테이블의 학교 컬럼
    a.학년,               -- 학교, 학년 테이블의 학년 컬럼
    b.국어,               -- 성적 테이블의 국어 컬럼
    b.영어,               -- 성적 테이블의 영어 컬럼
    b.수학                -- 성적 테이블의 수학 컬럼
FROM
    Test_table a        -- 학교, 학년 테이블 a로 치환
    INNER JOIN          -- 조인
    성적 b                -- 성적 테이블을 b로 치환
ON a.idx = b.idx  

Create table 용돈(
	idx bigint identity(1,1),
	Name varchar(20),
	돈 decimal(18,0)
)
select * from 용돈

insert into 용돈 values('홍길동',1000);
insert into 용돈 values('명월',2000);

 SELECT
    a.Name,             -- 학교, 학년 테이블의 Name 컬럼
    a.학교,               -- 학교, 학년 테이블의 학교 컬럼
    a.학년,               -- 학교, 학년 테이블의 학년 컬럼
    b.국어,               -- 성적 테이블의 국어 컬럼
    b.영어,               -- 성적 테이블의 영어 컬럼
    b.수학,               -- 성적 테이블의 수학 컬럼
    c.돈                 -- 용돈 테이블의 돈
FROM
    Test_table a        -- 학교, 학년 테이블 a로 치환
    INNER JOIN          -- 조인
    성적 b                -- 성적 테이블을 b로 치환
    ON a.idx = b.idx    -- 키 조인
    INNER JOIN
    용돈 c                -- 용돈 테이블을 c로 치환
    ON a.idx = c.idx   

--데이터가 없어도 나타내라
SELECT
    a.Name,             -- 학교, 학년 테이블의 Name 컬럼
    a.학교,               -- 학교, 학년 테이블의 학교 컬럼
    a.학년,               -- 학교, 학년 테이블의 학년 컬럼
    b.국어,               -- 성적 테이블의 국어 컬럼
    b.영어,               -- 성적 테이블의 영어 컬럼
    b.수학,               -- 성적 테이블의 수학 컬럼
    c.돈                 -- 용돈 테이블의 돈
FROM
    Test_table a        -- 학교, 학년 테이블 a로 치환
    INNER JOIN          -- 조인
    성적 b                -- 성적 테이블을 b로 치환
    ON a.idx = b.idx    -- 키 조인
    LEFT OUTER JOIN
    용돈 c                -- 용돈 테이블을 c로 치환
    ON a.idx = c.idx    -- 키 조인


--노원학교의 1학년으로 재학 중이고
--용돈을 받지 않고도 
--수학점수가 80점인 학생을 영어성적순으로 나타내라는 의미입니다.

SELECT
    a.Name,             -- 학교, 학년 테이블의 Name 컬럼
    a.학교,               -- 학교, 학년 테이블의 학교 컬럼
    a.학년,               -- 학교, 학년 테이블의 학년 컬럼
    b.국어,               -- 성적 테이블의 국어 컬럼
    b.영어,               -- 성적 테이블의 영어 컬럼
    b.수학,               -- 성적 테이블의 수학 컬럼
    isnull(c.돈,0) as 돈  -- 용돈 테이블의 돈
FROM
    Test_table a          -- 학교, 학년 테이블 a로 치환
    INNER JOIN            -- 조인
    성적 b                -- 성적 테이블을 b로 치환
    ON a.idx = b.idx      -- 키 조인
    LEFT OUTER JOIN
    용돈 c                -- 용돈 테이블을 c로 치환
    ON a.idx = c.idx      -- 키 조인
WHERE
    a.학교 = '노원'
AND
    a.학년 = '1'
AND
    b.수학 > 80
AND
    c.돈 is null
ORDER BY
    영어 DESC

---------------------------

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


 
-----------------------쿼리---------------------------------------------------------------------------------------------------------------------------------------------------- 

select * from ebook
select * from ebookset
select * from myshelf

----------
select user_No,set_No from myshelf 

------------


select set_name as 세트제목, set_img as 세트이미지, set_RegDate as 등록날짜, set_author as 작가명, set_MakeCom as 출판사, set_genre as 장르, set_amount as 총권수 from ebookset
select set_name as 세트제목, set_img as 세트이미지, set_RegDate as 등록날짜, set_author as 작가명, set_MakeCom as 출판사, set_genre as 장르, set_amount as 총권수 from ebookset where set_No=1 or set_No=2

---------------------------세트전자책 데이터뽑기

select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y'  --회원번호 1인사람의 세트가진것 출력 

--1번회원
select b.set_name as 세트제목, b.set_img as 세트이미지, b.set_RegDate as 등록날짜, b.set_author as 작가명, b.set_MakeCom as 출판사, b.set_genre as 장르, b.set_amount as 총권수 from 
(
select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
) a INNER JOIN ebookset b ON a.set_No = b.set_No

--2번회원
select b.set_name as 세트제목, b.set_img as 세트이미지, b.set_RegDate as 등록날짜, b.set_author as 작가명, b.set_MakeCom as 출판사, b.set_genre as 장르, b.set_amount as 총권수 from 
(
select DISTINCT(set_No) from myshelf where user_No =2 and is_set= 'Y' 
) a INNER JOIN ebookset b ON a.set_No = b.set_No


-------------------------세트아닌전자책 데이터 뽑기
--회원1
select ebook_no from myshelf where user_No='1' and is_set='N'

select b.ebook_name as 책제목, b.ebook_img as 이미지, b.ebook_RegDate as 등록날짜, b.ebook_author as 작가명, b.ebook_MakeCom as 출판사, b.ebook_genre as 장르 from    -- '0' as 총권수 ??
(
select ebook_no from myshelf where user_No='1' and is_set='N'
) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no


------------------------------------합치기-------------------------------------------   쿼리의 대상 목록에는 동일한 개수의 식이 있어야 합니다.
select * from
(
	select b.set_name as 제목, b.set_img as 이미지, b.set_RegDate as 등록날짜, b.set_author as 작가명, b.set_MakeCom as 출판사, b.set_genre as 장르, b.set_amount as 총권수, 'set' as 성인용,
	0 as 평점 , 'set' as 판매여부, 0 as 가격 from 
	(
	select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
	) a INNER JOIN ebookset b ON a.set_No = b.set_No

	union all 

	select b.ebook_name as 제목, b.ebook_img as 이미지, b.ebook_RegDate as 등록날짜, b.ebook_author as 작가명, b.ebook_MakeCom as 출판사, b.ebook_genre as 장르, 0 as 총권수, b.ebook_isadult as 성인용, b.ebook_grade as 평점 ,
	       b.ebook_issell as 판매여부, b.ebook_price as 가격 from  
	(
	select ebook_no from myshelf where user_No='1' and is_set='N'
	) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no

) as tablesum

--------------------------------------------------------------

select * from ebook where ebook_setNo=1 and ebook_issell='Y'


-------------정렬
 --ROW_NUMBER() OVER (ORDER BY ebookWriter ASC) AS RowNum

select 제목,이미지, 등록날짜, 작가명, 출판사, 장르 ,총권수, ROW_NUMBER() OVER (ORDER BY 등록날짜 DESC) AS RowNum 
from
(

	select b.set_name as 제목, b.set_img as 이미지, b.set_RegDate as 등록날짜, b.set_author as 작가명, b.set_MakeCom as 출판사, b.set_genre as 장르, b.set_amount as 총권수 from 
	(
	select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
	) a INNER JOIN ebookset b ON a.set_No = b.set_No

	union all 

	select b.ebook_name, b.ebook_img , b.ebook_RegDate as 등록날짜, b.ebook_author as 작가명, b.ebook_MakeCom as 출판사, b.ebook_genre as 장르, '0' as 총권수 from  
	(
	select ebook_no from myshelf where user_No='1' and is_set='N'
	) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no

) as sort


--페이징 
select * from
	(

		select 제목,이미지, 등록날짜, 작가명, 출판사, 장르 ,총권수, ROW_NUMBER() OVER (ORDER BY 작가명 ASC) AS RowNum from
		(

			select b.set_name as 제목, b.set_img as 이미지, b.set_RegDate as 등록날짜, b.set_author as 작가명, b.set_MakeCom as 출판사, b.set_genre as 장르, b.set_amount as 총권수 from 
			(
			select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
			) a INNER JOIN ebookset b ON a.set_No = b.set_No

			union all 

			select b.ebook_name, b.ebook_img , b.ebook_RegDate as 등록날짜, b.ebook_author as 작가명, b.ebook_MakeCom as 출판사, b.ebook_genre as 장르, '0' as 총권수 from  
			(
			select ebook_no from myshelf where user_No='1' and is_set='N'
			) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no
		) as sort 

	) as pageing WHERE RowNum BETWEEN 1 AND 3 
	

--1 . 검색  : 작가 or 작가명 , 검색결과로 페이징
select * from
	(

		select 제목,이미지, 등록날짜, 작가명, 출판사, 장르 ,총권수, ROW_NUMBER() OVER (ORDER BY 등록날짜 DESC) AS RowNum from
		(

			select b.set_name as 제목, b.set_img as 이미지, b.set_RegDate as 등록날짜, b.set_author as 작가명, b.set_MakeCom as 출판사, b.set_genre as 장르, b.set_amount as 총권수 from 
			(
			select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
			) a INNER JOIN ebookset b ON a.set_No = b.set_No where b.set_name like '%나루토%' or b.set_author like '%이문열%'
			
			union all 

			select b.ebook_name, b.ebook_img , b.ebook_RegDate as 등록날짜, b.ebook_author as 작가명, b.ebook_MakeCom as 출판사, b.ebook_genre as 장르, '0' as 총권수 from  
			(
			select ebook_no from myshelf where user_No='1' and is_set='N'
			) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no where b.ebook_name like '%나루토%'  or b.ebook_author like '%이문열%'
		) as sort 
	) as search WHERE RowNum BETWEEN 1 AND 3 


--------------------------------


--2.정렬 : 6가지 정렬방식 - 구매순 ,작가명, 작품명 (ASC,DESC)
select * from																
	(																					--등록날짜,작가명,제목 ASC , DESC
		select 제목,이미지, 등록날짜, 작가명, 출판사, 장르 ,총권수, ROW_NUMBER() OVER (ORDER BY 제목 ASC) AS RowNum from
		(

			select b.set_name as 제목, b.set_img as 이미지, b.set_RegDate as 등록날짜, b.set_author as 작가명, b.set_MakeCom as 출판사, b.set_genre as 장르, b.set_amount as 총권수 from 
			(
			select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
			) a INNER JOIN ebookset b ON a.set_No = b.set_No

			union all 

			select b.ebook_name, b.ebook_img , b.ebook_RegDate as 등록날짜, b.ebook_author as 작가명, b.ebook_MakeCom as 출판사, b.ebook_genre as 장르, '0' as 총권수 from  
			(
			select ebook_no from myshelf where user_No='1' and is_set='N'
			) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no
		) as sort 
	) as sort

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--3. non클러스티드 인덱스 걸기
select * from ebook
select * from ebookset
select * from myshelf

create nonclustered index ebook_index
on ebook(ebook_setNo);

create nonclustered index myshelf_index
on myshelf(ebook_no,set_no);


--확인
EXEC SP_HELPINDEX ebook
EXEC SP_HELPINDEX myshelf

--삭제	
DROP INDEX ebook.ebook_index
DROP INDEX myshelf.myshelf_index
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--4.변수를 통한 제어
 --변수1 : 검색어 
 --변수2 : 정렬순서            

 
 DECLARE @search varchar(20)
 DECLARE @sort varchar(20)
 DECLARE @sort2 varchar(10)
 
 SET @search='%%'
 SET @sort='작가명'
 SET @sort2=DESC
   

 select * from
	(

		select 제목,이미지, 등록날짜, 작가명, 출판사, 장르 ,총권수, ROW_NUMBER() OVER (ORDER BY @sort + @sort2) AS RowNum from
		(

			select b.set_name as 제목, b.set_img as 이미지, b.set_RegDate as 등록날짜, b.set_author as 작가명, b.set_MakeCom as 출판사, b.set_genre as 장르, b.set_amount as 총권수 from 
			(
			select DISTINCT(set_No) from myshelf where user_No =1 and is_set= 'Y' 
			) a INNER JOIN ebookset b ON a.set_No = b.set_No where b.set_name like @search or b.set_author like @search or b.set_MakeCom like @search or b.set_genre like @search 
			
			union all 

			select b.ebook_name, b.ebook_img , b.ebook_RegDate as 등록날짜, b.ebook_author as 작가명, b.ebook_MakeCom as 출판사, b.ebook_genre as 장르, '0' as 총권수 from  
			(
			select ebook_no from myshelf where user_No='1' and is_set='N'
			) a INNER JOIN ebook b ON a.ebook_no = b.ebook_no where b.ebook_name like @search or  b.ebook_author like @search or  b.ebook_MakeCom like @search or b.ebook_genre like @search
		) as sort 
	) as search WHERE RowNum BETWEEN 1 AND 3 


------------------------------------------------------------------

--4.변수를 통한 제어   ---수정	
 --변수1 : 검색어 
 --변수2 : 정렬순서            


 DECLARE @search varchar(20)
 DECLARE @sort varchar(20)
 DECLARE @sort2 varchar(10)

 SET @search=''				-- 검색어입력
 SET @sort='ebook_author'	-- 제목,등록일,작가순
 SET @sort2='DESC'			-- 오름차순,내림차순
   
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

-------------

--세트가진 회원들의 세트구성목록다출력? 
select * from
(
select DISTINCT(set_No),is_set from myshelf where user_No =1 and is_set= 'Y' 
) a INNER JOIN 
(select * from ebook where ebook_issell='Y') b ON a.set_No = b.ebook_setNo



-------------------------------------------------------------------------

--인덱스를 만들 때 해당 테이블의 용도를 정확히 이해해야한다.

create table tb(

col1 int ,

col2 char(6)

)

insert into tb values(12,'홍길동');
insert into tb values(14,'안경태');
insert into tb values(28,'김치국');
insert into tb values(27,'오발탄');
insert into tb values(13,'박호순');
insert into tb values(22,'김감자');
insert into tb values(17,'한국인');
insert into tb values(15,'박사내');
insert into tb values(19,'정주고');
insert into tb values(21,'윤기나');
insert into tb values(18,'이리와');
insert into tb values(26,'박치기');
insert into tb values(16,'김새네');
insert into tb values(24,'오리발');
insert into tb values(23,'정말로');
insert into tb values(20,'김말자');
insert into tb values(25,'우기자');
insert into tb values(11,'김박사');

--테이블을 생성하고 데이터를 insert 하면 데이터는 데이터페이지에 논리적으로 기록이 된다. 하나의 데이터페이지의 크기는 8kb이며, row수의 필드 크기만큼 저장이 된다.
drop table tb

select * from tb 

create unique nonclustered index tb_ix_col1              --힙 + 넌클러스티드
on tb(col1);

select * from tb where col1 = 19

------------------------------------------

create unique clustered index tb_ix_col3   -- col1에 클러스터인덱스
on tb(col1);

create unique nonclustered index tb_ix_col4 --col2에 non클러스터인덱스
on tb(col2);

select * from tb where col2 = '오발탄'


-- tb의 Column_01은 항상 검색을 위해 필요하고, Column_02는 검색의 대상이 되지는 않지만, 값이 필요할 때가 있다.
-- 이 경우에는 아래와 같이 INCLUDE 구문을 통해 성능을 증가시킬 수 있다.
CREATE INDEX tb_ix_col2
ON tb(col1) INCLUDE (col2)

create unique clustered index tb_ix_col1
on tb(col1);

-- tb의 Column_01에 있는 인덱스 tb_ix_col1를 제거

DROP INDEX tb.tb_ix_col1
DROP INDEX tb.tb_ix_col2

select * from tb where col2 = '오발탄'

--tb인덱스확인 
EXEC SP_HELPINDEX tb

--* 데이터베이스의 모든 인덱스 확인
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
