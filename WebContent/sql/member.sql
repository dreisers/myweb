 CREATE TABLE member (
    id       VARCHAR(10)  NOT NULL, -- 아이디, 중복 안됨, 레코드를 구분하는 컬럼 
    passwd   VARCHAR(10)  NOT NULL, -- 패스워드
    mname    VARCHAR(20)  NOT NULL, -- 성명
    tel      VARCHAR(14)  NULL,     -- 전화번호
    email    VARCHAR(50)  NOT NULL  UNIQUE, -- 전자우편 주소, 중복 안됨
    zipcode  VARCHAR(7)   NULL,     -- 우편번호, 101-101
    address1 VARCHAR(255) NULL,     -- 주소 1
    address2 VARCHAR(255) NULL,     -- 주소 2(나머지주소)
    job      VARCHAR(20)  NOT NULL, -- 직업
    mlevel   CHAR(2)      NOT NULL, -- 회원 등급, A1, B1, C1, D1, E1, F1
    mdate    DATE         NOT NULL, -- 가입일    
    PRIMARY KEY (id)
);

-- 회원가입
INSERT INTO MEMBER (id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
values('', '1q2w3e4r!', '솔데스크', '123-1234', 'soldesk3@naver.com', '12345', ' 서울시 종로구 관철동', '코아빌딩5층'
		, 'A01', 'C1', sysdate);
		
-- 회원목록
	SELECT * FROM member ORDER BY id;
	
-- 아이디 중복확인
SELECT count(id)
FROM MEMBER
WHERE id = 'soldesk';

-- 이메일 중복확인
SELECT count(email) AS cnt
FROM MEMBER
WHERE email= 'soldesk@naver.com';


--회원가입 
INSERT INTO MEMBER(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
VALUES(test1, 12341234, test1, 02-1222-2222, , test1@test1.com, 233-322, 경기, 광명, D1, sydate);

--로그인 성공 여부 -> 회원등급을 가져온다
SELECT mlevel
FROM member
WHERE id=? AND passwd=?
AND mlevel IN ('A1', 'B1', 'C1', 'D1')

SELECT count(*) AS cnt
FROM MEMBER;

SELECT id, passwd, mname, tel, email, mdate, mlevel
FROM MEMBER
ORDER BY id ASC;


UPDATE MEMBER
SET mlevel=?
WHERE id = ?

DELETE FROM MEMBER
WHERE id=?

--회원정보수정
UPDATE MEMBER
SET passwd=? ,mname=?, tel=?, email=?, zipcode=?, address1=?, address2=?, job=?
WHERE id=? AND passwd=?;

--탈퇴
UPDATE MEMBER
SET mlevel=? 
WHERE id=? AND passwd=?

SELECT id, passwd, mname, email, tel, zipcode, address1, address2, job
FROM "MEMBER"
WHERE id=?

UPDATE MEMBER
SET passwd=?
WHERE id=? AND email=?

--아이디 찾기
SELECT id
FROM MEMBER
WHERE mname='k' AND tel='010-5699-3222' AND email='kb@na.com';

UPDATE MEMBER
SET passwd=?
WHERE mname=? AND tel=? AND email=?