--------------------
-- 도메인 무결성 예제
--------------------
create table kopo_product_volume(
regionid varchar2(20),
productgroup varchar2(20),
yearweek varchar2(8),
volume number not null,
constraint pk_kopo_product_volume primary key(regionid,productgroup, yearweek));

insert into kopo_product_volume
values('regionid','productgroup',null,'volume');

 -------------------
 -- 개체 무결성 예제
 -------------------
insert into kopo_product_volume
values ('A01','ST0002','201503',20);

insert into kopo_product_volume
values ('A01','ST0002','201504',20);

--- kopo_product_volume.csv import 

insert into kopo_product_volume
values ('A01','ST0002','201503',20);

UPDATE KOPO_PRODUCT_VOLUME
SET YEARWEEK = '201503'
WHERE 1=1
AND YEARWEEK = '201504'
AND PRODUCTGROUP = 'ST0002';

 
 -------------------
 -- 참조키 무결성 예제
 -------------------
 -- 부모테이블 생성
 CREATE TABLE KOPO_EVENT_INFO_FOREIGN(
     EVENTID VARCHAR2(20),
     EVENTPERIOD VARCHAR2(20),
     PROMOTION_RATIO NUMBER,
 constraint pk_kopo_event_info_foreign primary key(EVENTID));

-- 자식테이블 생성
 CREATE TABLE KOPO_PRODUCT_VOLUME_FOREIGN(
     REGIONID VARCHAR2(20),
     PRODUCTGROUP VARCHAR2(20),
     YEARWEEK VARCHAR2(8),
     VOLUME NUMBER NOT NULL,
     EVENTID VARCHAR2(20),
 constraint pk_kopo_product_volume_foreign primary key(REGIONID, PRODUCTGROUP, YEARWEEK),
 constraint fk_kopo_product_volume_foreign foreign key(eventid) references KOPO_EVENT_INFO_FOREIGN(EVENTID) );
 
 -- 데이터 import (부모테이블 먼저)
 -- 자식테이블 import 시에는 constraint disable후 수행
 alter table kopo_product_volume_foreign enable constraint fk_kopo_product_volume_foreign;
 
 -- 참조 무결성 위배
 -- 1. 부모테이블에 event 정보 없는데 자식 테이블에 삽입 시도함
 insert into kopo_product_volume_foreign
 values ('A01','ST00002','201501',50,'EVTEST');
 
 -- 2. 자식에 정보가 있는데 부모테이블이 지우려고 시도함
DELETE FROM KOPO_EVENT_INFO_FOREIGN
WHERE EVENTID = 'EV00001';

-- 2번 케이스에 대해서 다른 option 사용가능
-- 키 정보만 삭제
ALTER TABLE KOPO_PRODUCT_VOLUME_FOREIGN
    DROP CONSTRAINT fk_kopo_product_volume_foreign;

-- 키 정보만 새로 생성
-- 옵션 제외 시 DEFAUT = RESTRICT
-- ON DELETE SET NULL : 부모테이블에서 정보 삭제 시 자식테이블 값 NULL 처리
-- ON DELETE CASCADE  : 부모테이블에서 정보 삭제 시 자식테이블 해당 행 자체를 삭제함
ALTER TABLE KOPO_PRODUCT_VOLUME_FOREIGN
    ADD CONSTRAINT  fk_kopo_product_volume_foreign  FOREIGN KEY(EVENTID)     
    REFERENCES KOPO_EVENT_INFO_FOREIGN (EVENTID) on delete cascade;




