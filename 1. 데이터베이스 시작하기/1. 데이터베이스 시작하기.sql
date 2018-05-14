---------------------------------
-- 1. 테이블 스페이스 (* DBA 사용자 정보로 로그인) 예: SYSTEM OR SYS
---------------------------------
-- 테이블 스페이스 생성
CREATE TABLESPACE       TS_USER01
   DATAFILE 'C:\ORACLE\DATA\TS_USER_01.dbf' SIZE 1024M
   AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED
   SEGMENT SPACE MANAGEMENT AUTO;
   
-- 테이블 스페이스 삭제
DROP TABLESPACE       TS_USER01
   INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
---------------------------------
-- 2. 사용자
---------------------------------   
-- 사용자 생성
CREATE USER HAITEAM
                  IDENTIFIED BY        HAITEAM
                  DEFAULT TABLESPACE   TS_USER01
                  TEMPORARY TABLESPACE TEMP;

-- 사용자 기본정보 변경 변경
ALTER USER HAITEAM
   IDENTIFIED BY HAITEAM2;
   -- ACCOUNT LOCK/UNLOCK
   
-- 사용자 테이블 스페이스 변경
ALTER USER HAITEAM
    DEFAULT TABLESPACE USERS;
    
---------------------------------
-- 3. 사용자 권한
---------------------------------  
-- 사용자 권한 생성 (접속/리소스 및 테이블 생성)
GRANT CONNECT, RESOURCE, DBA TO HAITEAM;

-- 사용자 권한 회수 (접속/리소스 및 테이블 생성)
REVOKE DBA FROM HAITEAM;


SELECT * FROM 
(SELECT 
        CONCAT(REGIONID,CONCAT('_',PRODUCT)) AS KEY
        ,REGIONID
        , PRODUCT
        , YEARWEEK
        , CASE WHEN QTY > 700000
                THEN 700000
                ELSE QTY END AS QTY
        FROM KOPO_CHANNEL_SEASONALITY_NEW
        WHERE 1=1
        AND PRODUCT IN ('PRODUCT1','PRODUCT2')
        AND SUBSTR(YEARWEEK,5,6) != '53')A
LEFT JOIN        
(SELECT B.KEY
    , AVG(QTY)
    , SUM(QTY)
    , COUNT(QTY)
FROM (
    SELECT 
        CONCAT(REGIONID,CONCAT('_',PRODUCT)) AS KEY
        ,REGIONID
        , PRODUCT
        , YEARWEEK
        , CASE WHEN QTY > 700000
                THEN 700000
                ELSE QTY END AS QTY
        FROM KOPO_CHANNEL_SEASONALITY_NEW
        WHERE 1=1
        AND PRODUCT IN ('PRODUCT1','PRODUCT2')
        AND SUBSTR(YEARWEEK,5,6) != '53'
)B
GROUP BY KEY)B
ON A.KEY = B.KEY
WHERE 1=1
AND REGIONID = 'A43'
    
    GROUP BY REGIONID, PRODUCTGROUP

SELECT * FROM KOPO_CHANNEL_SEASONALITY_NEW

---------------------------------
-- 4. 샘플 테이블 생성 (* 생성한 사용자 정보로 로그인)
---------------------------------  
-- 사용자 정보로 접속 및
-- 샘플 테이블 생성
CREATE TABLE KOPO_PRODUCT_VOLUME
(
  REGIONID          VARCHAR2(20),
  PRODUCTGROUP      VARCHAR2(20),
  YEARWEEK          VARCHAR2(6),
  VOLUME            NUMBER
);

-- 테이블 목록 조회
SELECT * FROM TABS;

