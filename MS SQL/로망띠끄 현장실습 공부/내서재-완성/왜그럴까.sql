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


SET @search=''				-- 검색어입력
SET @sort='1'	-- 제목,등록일,작가순 (1 : 제목, 2 : 등록일, 3 : 작가순)
SET @sort2='1'			-- 오름차순,내림차순 (1 오름차순, 2 내림차순)


IF(@sort = '1')
	BEGIN
		IF(@sort2 = '1') -- 오름 차순
			BEGIN
				SELECT * FROM
				(
					SELECT ebook_name,ebook_img, ebook_RegDate,ebook_author,ebook_MakeCom,ebook_genre,amount,is_set,set_No ,ROW_NUMBER() OVER (ORDER BY ebook_name ASC) AS RowNum
					FROM
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
			END
		ELSE			 -- 내림 차순
			BEGIN
				SELECT * FROM
				(
					SELECT ebook_name,ebook_img, ebook_RegDate,ebook_author,ebook_MakeCom,ebook_genre,amount,is_set,set_No ,ROW_NUMBER() OVER (ORDER BY ebook_name DESC) AS RowNum
					FROM
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
			END
	END
ELSE IF (@sort = '2')
	BEGIN
		
		IF(@sort2 = '1') -- 오름 차순
			BEGIN
				SELECT * FROM
				(
					SELECT ebook_name,ebook_img, ebook_RegDate,ebook_author,ebook_MakeCom,ebook_genre,amount,is_set,set_No ,ROW_NUMBER() OVER (ORDER BY ebook_RegDate ASC) AS RowNum
					FROM
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
			END
		ELSE			 -- 내림 차순
			BEGIN
				SELECT * FROM
				(
					SELECT ebook_name,ebook_img, ebook_RegDate,ebook_author,ebook_MakeCom,ebook_genre,amount,is_set,set_No ,ROW_NUMBER() OVER (ORDER BY ebook_RegDate DESC) AS RowNum
					FROM
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
			END
	END
ELSE
	BEGIN
		
		IF(@sort2 = '1') -- 오름 차순
			BEGIN
				SELECT * FROM
				(
					SELECT ebook_name,ebook_img, ebook_RegDate,ebook_author,ebook_MakeCom,ebook_genre,amount,is_set,set_No ,ROW_NUMBER() OVER (ORDER BY ebook_author ASC) AS RowNum
					FROM
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
			END
		ELSE			 -- 내림 차순
			BEGIN
				SELECT * FROM
				(
					SELECT ebook_name,ebook_img, ebook_RegDate,ebook_author,ebook_MakeCom,ebook_genre,amount,is_set,set_No ,ROW_NUMBER() OVER (ORDER BY ebook_author DESC) AS RowNum
					FROM
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
			END
	END