
-- 데이터베이스 링크 생성
-- 원격지의 oracle db에 접근하기 위한 설정임
-- 1번. tnsname 활용
CREATE DATABASE LINK ASUS_LINK
CONNECT TO kopo
IDENTIFIED BY kopo
Using 'tns설정명'

-- 2번. 직접호출방식 활용
CREATE DATABASE LINK ASUS_LINK
CONNECT TO kopo
IDENTIFIED BY kopo
Using '(
DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.0.18)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
  )')

-- 생성된 데이터베이스 링크 확인방법
SELECT * FROM ALL_DB_LINKS

-- 데이터베이스 링크 삭제방법
DROP DATABASE LINK ASUS_LINK;
