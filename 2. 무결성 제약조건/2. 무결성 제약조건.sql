--------------------
-- 도메인 무결성 예제
--------------------
create table kopo_product_volume(
regionid varchar2(20),
productgroup varchar2(20),
yearweek varchar2(8),
volume number not null,
constraint pk_kopo_product_volume primary key(regionid,productgroup, yearweek))

insert into kopo_product_volume
values('regionid','productgroup',null,'volume')

 -------------------
 -- 개체 무결성 예제
 -------------------
insert into kopo_product_volume
values ('A01','ST0002','201503',20)

insert into kopo_product_volume
values ('A01','ST0002','201504',20)

insert into kopo_product_volume
values ('A01','ST0002','201503',20)

UPDATE KOPO_PRODUCT_VOLUME
SET YEARWEEK = '201503'
WHERE 1=1
AND YEARWEEK = '201504'
AND PRODUCTGROUP = 'ST0002'

 
 -------------------
 -- 참조키 무결성 예제
 -------------------
 -- 부모테이블 생성
 CREATE TABLE KOPO_EVENT_INFO_FOREIGN(
     EVENTID VARCHAR2(20),
     EVENTPERIOD VARCHAR2(20),
     PROMOTION_RATIO NUMBER,
 constraint pk_kopo_event_info_foreign primary key(EVENTID))

-- 자식테이블 생성
 CREATE TABLE KOPO_PRODUCT_VOLUME_FOREIGN(
     REGIONID VARCHAR2(20),
     PRODUCTGROUP VARCHAR2(20),
     YEARWEEK VARCHAR2(8),
     VOLUME NUMBER NOT NULL,
     EVENTID VARCHAR2(20),
 constraint pk_kopo_product_volume_foreign primary key(REGIONID, PRODUCTGROUP, YEARWEEK),
 constraint fk_kopo_product_volume_foreign foreign key(eventid) references KOPO_EVENT_INFO_FOREIGN(EVENTID) )
