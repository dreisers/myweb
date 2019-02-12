create table tb_bbs(
  bbsno    number(5)       not null -- 일련번호 -99999~99999
 ,wname    varchar2(20)    not null -- 작성자
 ,subject  varchar2(100)   not null -- 글제목
 ,content  varchar2(2000)  not null -- 글내용
 ,passwd   varchar2(10)    not null -- 글비밀번호
 ,readcnt  number(5)       default 0 not null -- 글조회수
 ,regdt    date            default  sysdate -- 글작성일
 ,grpno    number(5)       not null  -- 글 그룹번호
 ,indent   number(5)       default 0 -- 들여쓰기
 ,ansnum   number(5)       default 0 -- 글순서
 ,ip       varchar2(15)    not null -- 글 IP
 ,primary key(bbsno)                --bbsno 기본키 
);


-- 새글쓰기
bbsno : max(bbsno)+1
wname, subject, content, passwd : 사용자입력
default 값 : readcnt, regdt, indent, ansnum
grpno : max(bbsno)+1
ip : request내부객체에서 사용자 PC의 IP정보를 가져옴

-- 행추가 테스트
insert into tb_bbs(bbsno, wname, subject, content, passwd, grpno, ip)
values(
(select nvl(max(bbsno),0)+1 from tb_bbs)
,'손흥민'
,'오필승코리아'
,'무궁화 꽃이 피었습니다'
,'1234'
,(select nvl(max(bbsno),0)+1 from tb_bbs)
,'127.0.0.1'
);


select * from tb_bbs order by grpno desc, ansnum asc;


select bbsno, wname, subject, readcnt, indent, regdt
from tb_bbs
order by grpno desc, ansnum asc;

-- 상세보기
select bbsno, wname, subject, content, readcnt, grpno, ip, regdt
from tb_bbs
where bbsno = ?

-- 조회수 증가
update tb_bbs
set readcnt = readcnt + 1
where bbsno = ?;

-- 답변쓰기
select grpno, indent, ansnum
from tb_bbs
where bbsno=?

update tb_bbs
set ansnum = ansnum+1
where grpno=1 and ansnum>=3;

insert into tb_bbs(bbsno, wname, subject, content, passwd, ip, grpno, indent, ansnum)
values(); 

select * from tb_bbs;

-- 수정

-- 1) bbsUpdate.jsp 비밀번호 입력폼 작성
 
-- 2) bbsUpdateForm.jsp 비밀번호와 글번호 일치하는 DB가져오기
	select wname, subject, content, passwd
	from tb_bbs
	where passwd = ? and bbsno = ?
	
-- 3) 2)의 정보를 수정폼에 출력

-- 4) bbsUpdateProc.jsp
-- 사용자가 다시 입력한 내용을 DB에서 수정하기
	Update tb_bbs
	set wname=?, subject=?, content=?, passwd=?, ip=?
	where bbsno=?
	수정이 완료되면 목록으로 이동
	
-- 검색
select *
from tb_bbs
where subject like '%무궁화%';


-- 페이징
-- rownum(줄번호) 활용

1) 
select bbsno, subject, grpno, ansnum
from tb_bbs
order by grpno desc, ansnum asc;

2) 
select bbsno, subject, grpno, ansnum, rownum
from tb_bbs
order by grpno desc, ansnum asc;

3)
select AA.bbsno, AA.subject, AA.grpno, AA.ansnum, rownum
from (select bbsno, subject, grpno, ansnum
from tb_bbs
order by grpno desc, ansnum asc) AA

4)
select bbsno, subject, grpno, ansnum, rownum
from (select bbsno, subject, grpno, ansnum
from tb_bbs
order by grpno desc, ansnum asc); 	

5) 줄번호 1~3 1페이지
select bbsno, subject, grpno, ansnum, rownum
from (select bbsno, subject, grpno, ansnum
from tb_bbs
order by grpno desc, ansnum asc)
where rownum>=1 and rownum<=3;

6) 줄번호 4~6 2페이지 -> 결과 X
select bbsno, subject, grpno, ansnum, rownum
from (select bbsno, subject, grpno, ansnum
from tb_bbs
order by grpno desc, ansnum asc)
where rownum>=4 and rownum<=6;

7) 줄번호 4~6 2페이지
select bbsno, subject, grpno, ansnum, rnum
from (select bbsno, subject, grpno, ansnum, rownum as rnum
from (select bbsno, subject, grpno, ansnum
from tb_bbs
order by grpno desc, ansnum asc) AA) BB
where rnum>=4 and rnum<=6;

8) 
select bbsno, subject, grpno, ansnum, rnum
from (select bbsno, subject, grpno, ansnum, rownum as rnum
from (select bbsno, subject, grpno, ansnum
from tb_bbs
order by grpno desc, ansnum asc)
)
where rnum>=4 and rnum<=6;

9) 페이징 + 검색 
제목 '솔데스크' 검색해서 2페이지 출력
select bbsno, subject, grpno, ansnum, rnum
from (select bbsno, subject, grpno, ansnum, rownum as rnum
from (select bbsno, subject, grpno, ansnum
from tb_bbs
where subject like '%솔데스크%'
order by grpno desc, ansnum asc)
)
where rnum>=4 and rnum<=6;



select grpno, indent, ansnum
from tb_bbs
where bbsno=?

update tb_bbs
set ansnum = ansnum+1
where grpno=1 and ansnum>=3;

insert into tb_bbs(bbsno, wname, subject, content, passwd, ip, grpno, indent, ansnum)
values(); 

select *
from tb_bbs
where indent=?

select count(*)  
from tb_bbs
where grpno=? and indent>?


--댓글 갯수 구하기
select subject, grpno ,indent, ansnum
from tb_bbs
order by grpno desc;

-- grpno가 동일한 레코드를 
-- 그룹화 하고 갯수를 구하시오
select grpno, count(grpno)-1 as cnt
from tb_bbs
group by grpno;

-- 3)의 논리적테이블에 셀프조인해서 최초 부모글 제목 가져오
SELECT BB.bbsno, BB.subject, AA.grpno, AA.cnt
FROM(select grpno, count(grpno)-1 as cnt
FROM tb_bbs  
GROUP BY grpno)AA
JOIN tb_bbs BB
ON AA.grpno = BB.grpno
WHERE BB.indent =0
ORDER BY grpno DESC;

