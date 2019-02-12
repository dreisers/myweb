-bbs2.sql
--테이블 생성
create table board(
  num          number         NOT NULL,
  writer       varchar2(20)   NOT NULL,
  email        varchar2(30),
  subject      varchar2(50)   NOT NULL,
  content      varchar2(2000) NOT NULL,
  passwd       varchar2(10)   NOT NULL,
  reg_date     date           NOT NULL,
  readcount    number         default 0,
  ref          number         NOT NULL,  -- 그룹번호
  re_step      number         NOT NULL,  -- 글순서
  re_level     number         NOT NULL,  -- 들여쓰기
  ip           varchar2(20)   NOT NULL,
  PRIMARY KEY(num)  
);

 INSERT INTO board(num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip) 
 VALUES ((select mvl(max(num),0)+1 from board ), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?;
 
DELETE FROM board
WHERE num=? AND passwd=?



