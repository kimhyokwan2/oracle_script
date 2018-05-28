----------------------------------------------------------
----------------- 문자 함수 -------------------------------
----------------------------------------------------------
-- 1. 대/소문자 변경
SELECT
    LOWER(PRODUCT) AS CASE1,
    UPPER(PRODUCT) AS CASE2
FROM KOPO_CHANNEL_SEASONALITY_NEW

-- 2. 컬럼 값 합치기
SELECT
    CONCAT(REGIONID, CONCAT('_',PRODUCT)) AS KEYCOL,
    REGIONID||'_'||PRODUCT AS KEYCOL2
FROM KOPO_CHANNEL_SEASONALITY_NEW

-- 3. 컬럼 값 추출하기
SELECT
    PRODUCT,
    SUBSTR(PRODUCT,1,7)
FROM KOPO_CHANNEL_SEASONALITY_NEW

-- 4. 컬럼 값 채우기
SELECT
    LPAD(PRODUCT,10,'0')
FROM KOPO_CHANNEL_SEASONALITY_NEW

  -- KOPO_CUSTOMERDATA 테이블에서
  -- CUSTOMERCODE를 12자리로 조회하세요
  -- 단, 12자리가 안될 경우 앞에 *로 채우세요
  SELECT 
  LPAD(CUSTOMERCODE,12,'*')
  FROM KOPO_CUSTOMERDATA
  
-- 5. 컬럼 값 제거 (LTRIM, RTRIM, TRIM)
SELECT
    LTRIM(PRODUCT,'PRO'),
    RTRIM(PRODUCT,'56')
FROM KEOOPO_CHANNEL_SEASONALITY_NEW

-- 6. 변경하기 (REPLACE)
SELECT
    REGIONID,
    REPLACE(REGIONID, 'A', 'REGION')
FROM KOPO_CHANNEL_SEASONALITY_NEW

    -- KOPO_CUSTOMERDATA의 고객코드는 10자리이다
    -- 만약 10자리가 아니면 왼쪽에 0으로 채운다
    -- 이후 고객코드의 뒷 4자리는 암호화를 위해 * 처리를 하세요
    
    SELECT 
    REPLACE(LPAD(CUSTOMERCODE,10,0), 
            SUBSTR(LPAD(CUSTOMERCODE,10,0),-4) , '****')
    FROM KOPO_CUSTOMERDATA
    
----------------------------------------------------------
----------------- 숫자 함수 -------------------------------
----------------------------------------------------------   


SELECT
    ROUND(12.345,2)
    ,CEIL(12.345)
    ,FLOOR(12.345)
    ,MOD(12,10)
    ,POWER(3,2)
    FROM DUAL

-- MOD 연산은 나머지 연산으로
-- 특정 3주차마다 ACTION을 취할경우 활용
SELECT
        FIRST_NUMBER,
        SECOND_NUMBER,
        FIRST_NUMBER/SECOND_NUMBER AS AVG,
        ROUND(FIRST_NUMBER/SECOND_NUMBER) AS ROUND_EX,
        CEIL(FIRST_NUMBER/SECOND_NUMBER) AS CEIL_EX,
        FLOOR(FIRST_NUMBER/SECOND_NUMBER) AS FLOOR_EX,
        MOD(FIRST_NUMBER, SECOND_NUMBER) AS MOD_EX,
        POWER(FIRST_NUMBER, SECOND_NUMBER) AS POW_EX
        FROM NUMBER_EXAMPLE


----------------------------------------------------------
----------------- 날짜 함수 -------------------------------
----------------------------------------------------------   

SELECT
    SYSDATE,
    NEXT_DAY(SYSDATE,2),
    LAST_DAY(SYSDATE)
    FROM DUAL
    
SELECT TO_CHAR(SYSDATE-7, 'YYYYWW') FROM DUAL

SELECT TO_CHAR(SYSDATE, 'YYYYWW') FROM DUAL

SELECT TO_CHAR(SYSDATE-30, 'YYYYMMDD') FROM DUAL

SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL

SELECT TO_CHAR(SYSDATE-1, 'YYYYMMDD') FROM DUAL
  
SELECT TO_CHAR(SYSDATE, 'YYYY MON DD HH MI') FROM DUAL 

----------------------------------------------------------
----------------- 고급 숫자 다루기 -------------------------
----------------------------------------------------------   

    -- 문자컬럼 week 오름차순 정렬
    SELECT * FROM SORT_EXAMPLE
    ORDER BY LPAD(WEEK,2,0)

    -- 정확도 산출 1 - ABS(FCST-ACTUAL) / FCST
    SELECT 
        YEARWEEK
        ,ACTUAL
        ,FCST
        ,ROUND((1-ABS(FCST-ACTUAL)/FCST),4) * 100 AS ACCURACY
        FROM RMSE_MAE_EXAMPLE2

SELECT * FROM RMSE_MAE_EXAMPLE