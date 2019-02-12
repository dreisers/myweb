 CREATE TABLE tb_pds (
      pdsno       NUMBER         NOT NULL
      ,wname      VARCHAR2(100)  NOT NULL
      ,subject    VARCHAR2(250)  NOT NULL
      ,regdate    DATE           NOT NULL
      ,passwd     VARCHAR2(15)   NOT NULL
      ,readcnt    NUMBER         DEFAULT 0
      ,filename   VARCHAR2(250)  NOT NULL  --파일명
      ,filesize   NUMBER         DEFAULT 0 --파일크기
      ,PRIMARY KEY(pdsno)
    );

--행추가 : max(일련번호) + 1 
wname, subject, passwd : 사용자 입력
filename, filesize : 첨부파일 관련
regdate :sysdate

INSERT INTO tb_pds(pdsno, wname, subject, passwd, filename, filesize, regdate)
VALUES((SELECT nvl(max(pdsno),0)+1 FROM tb_pds),'오필승','무궁화 꽃이 피었습니다', '1234','sky.png', 0, SYSDATE);
 
--목록 
SELECT pdsno, passwd, subject, wname, regdate, filename, filesize
FROM tb_pds
ORDER BY regdate DESC;

-- 삭제 
DELETE FROM tb_pds
WHERE pdsno=? AND passwd=?

--수정
SELECT subject, wname, passwd, filename
FROM tb_pds
WHERE pdsno=3 AND passwd='123';


