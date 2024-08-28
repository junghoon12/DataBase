/*
where 조건절
- 모든 데이터를 조회하는 것이 아니라 사용자가 원하는 데이터만
  조회하고 싶은 경우에 사용함.
- where 조건절은 자료를 필터링할 때 사용함.
- where 조건절은 from 테이블명 뒤에 기술을 하면 됨.

형식) select 컬럼명1, 컬럼명2, 컬럼명3.....
     from 테이블명
     where 조건식;
     
- 조건식에 들어가는 내용
  1) = : 조건이 같은지 여부 확인.
  2) < : 조건이 작은지 여부 확인.
  3) <= : 조건이 작거나 같은지 여부 확인.
  4) >= : 조건이 크거나 같은지 여부 확인.
  5) > : 조건이 큰지 여부 확인.
  6) != : 조건이 같지 않은지 여부 확인.
  7) <> : 조건이 같지 않은지 여부 확인.
  8) between A and B : A와 B 사이에 있는지 여부 확인.
  9) in(list) : list 값 중에 어느 하나와 일치하는지 여부 확인.
  10) not between A and B : A와 B 사이에 있지 않는지 여부 확인.
      ==> A와 B는 포함되지 않음.
  11) not in(list) : list 값과 일치하지 않는지 여부 확인.
*/

-- emp 테이블에서 담당업무가 'MANAGER'인 직원의 
-- 모든 정보를 화면에 보여주세요.
select *
from emp
where job = 'MANAGER';

-- emp 테이블에서 담당업무가 'SALESMAN' 인 직원의 
-- 모든 정보를 화면에 보여주세요.
select *
from emp
where job = 'SALESMAN';


-- [문제1] emp테이블에서 empno, ename, job, deptno 컬럼을
--        화면에 보여주세요.
select empno, ename, job, deptno
from emp; 


-- [문제2] emp 테이블에서 이름, 입사일, 급여를 화면에 보여주세요.
select ename, hiredate, sal
from emp;


-- [문제3] emp 테이블에서 사번, 이름, 담당업무, 보너스를 화면에 보여주세요.
select empno, ename, job, comm
from emp;


-- [문제4] emp 테이블에서 사번, 이름, 급여, 보너스, 급여 + 보너스 결과를
--        화면에 보여주세요.
select empno, ename, sal, comm, sal + comm
from emp;

-- null 값을 가지는 컬럼은 다른 컬럼과 연산을 하게 되면
-- 모두 null 값으로 처리가 되는 문제가 발생.

-- nvl() 함수 : null 값을 특정한 값으로 변경시켜 주는 함수.
-- 형식1) nvl(null 값이 들어 있는 컬럼명, 변경할 값)
select empno, ename, sal, comm, sal + nvl(comm, 0) as "급여 + 보너스"
from emp; 

-- 형식2) nvl2(컬럼명, expr1, expr2)
select empno, ename, sal, comm, sal + nvl2(comm, comm, 0) as "급여 + 보너스"
from emp;


-- [문제5] emp 테이블에서 담당업무가 'CLERK' 인 사원의
-- 사번, 이름, 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where job = 'CLERK';


-- [문제6] emp 테이블에서 1982년 1월 1일 이후에 입사한
-- 사원의 사번, 이름, 담당업무, 급여, 입사일자를 화면에 보여주세요.
select empno, ename, job, sal, hiredate
from emp
where hiredate >= '82/01/01';


-- [문제7] emp 테이블에서 급여가 1300 ~ 1500 사이인 사원의
-- 이름과 담당업무, 급여, 부서번호를 화면에 보여주세요.
select ename, job, sal, deptno
from emp
-- where sal >= 1300 and sal <= 1500;
where sal between 1300 and 1500;


-- [문제8] emp 테이블에서 사번이 7902, 7788, 7566 인 사원의
-- 사번, 이름, 담당업무를 화면에 보여주세요.
select empno, ename, job
from emp
-- where empno = 7902 or empno = 7788 or empno = 7566;
where empno in(7902, 7788, 7566);


--[문제9] emp 테이블에서 보너스가 300이거나 500이거나
-- 1400인 사원의 모든 정보를 화면에 보여주세요.
select *
from emp
-- where comm = 300 or comm = 500 or comm = 1400;
where comm in(300, 500, 1400);


-- [문제10] emp 테이블에서 급여가 1100 이상이고, 담당업무가
-- 'MANAGER' 인 사원의 사번, 이름, 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where sal >= 1100 and job = 'MANAGER';


/*
  like 키워드 : 패턴 비교 연산자. 검색을 하는 키워드.
  
  1) where ename like '%S%'
     ==> ename 컬럼에 S자를 포함하는 사원의 이름을 검색.
      
  2) where ename like 'S%'
     ==> ename 컬럼에 S자로 시작하는 사원의 이름을 검색.
     
  3) where ename like '%S'
     ==> ename 컬럼에 S자로 끝나는 사원의 이름을 검색.
     
  4) where ename like '_S%'
     ==> ename 컬럼에 두번째 S자를 포함하는 사원의 이름을 검색.
*/


-- emp 테이블에서 사원명에 'A' 라는 글자를 포함하는 사원의
-- 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '%A%';


-- [문제1] emp 테이블에서 사원명에 'M' 이라는 글자를 포함하는
-- 사원의 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '%M%';

-- [문제2] emp 테이블에서 사원명의 두번째 글자에 'I' 이라는 
-- 글자를 포함하는 사원의 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '_I%';


-- [문제3] emp 테이블에서 사원명에 이름이 'S' 라는 글자로 끝나는
-- 사원의 사번과 이름, 담당업무, 부서번호를 화면에 보여주세요.
select empno, ename, job, deptno
from emp
where ename like '%S%';

-- [문제4] emp 테이블에서 사원명에 세번째 글자가 'R' 이라는 
-- 글자를 포함하는 사원의 이름과 담당업무, 급여를 화면에 보여주세요.
select ename, job, sal
from emp
where ename like '__R%';

-- [문제5] emp 테이블에서 사원명에 두번째 글자가 'O' 라는 
-- 글자를 포함하는 사원의 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '_O%';


-- [문제6] emp 테이블에서 입사년도가 82년도인 사원의 
-- 사번, 이름, 담당업무, 입사일자를 화면에 보여주세요.
select empno, ename, job, hiredate
from emp
where hiredate like '82%';



-- member 라는 테이블을 만들어 보자.

create table member(
    memno number primary key,          -- 회원 번호
    memid varchar2(20) not null,       -- 회원 아이디
    memname varchar2(30) not null,     -- 회원 이름
    mempwd varchar2(20) not null,      -- 회원 비밀번호
    age number,                        -- 회원 나이
    mileage number,                    -- 회원 마일리지
    job varchar2(30),                  -- 회원 직업
    addr varchar2(500),                -- 회원 주소
    regdate date not null              -- 회원 가입일
);


-- member 테이블에 회원의 정보를 저장해 보자.
insert into member
    values(1, 'id1', '홍길동', '1111', 25, 0, '학생',
            '부산시 동래구', '2013-08-08');

insert into member
    values(2, 'kimkd', '김길동', '2222', 30, 1500, '회사원',
            '서울시 강남구', '2013-09-15');

insert into member
    values(3, 'id3', '공성현', '3333', 33, 10000, '회사원',
            '부산시 중구', '2013-09-09');
            
insert into member
    values(4, 'kimyh', '김영희', '4444', 18, 3000, '학생',
            '경상남도 마산시', '2014-05-23');
            
insert into member
    values(5, 'id5', '박말자', '5555', 45, 5000, '주부',
            '경기도 남양주시', '2013-12-01');

insert into member
    values(6, 'id6', '김철수', '6666', 55, 0, '교수',
            '제주도 서귀포시', '2013-01-10');

insert into member
    values(7, 'hong', '홍길동', '7777', 14, 0, '학생',
            '경상북도 경주시', '2013-12-25');

insert into member
    values(8, 'id8', '김상현', '8888', 31, 0, '무직',
            '서울시 마포구', '2013-04-22');

insert into member
    values(9, 'id9', '이지연', '9999', 25, 0, '학생',
            '강원도 강릉시', '2013-10-10');

insert into member
    values(10, 'id10', '홍길동', '1010', 52, 10000, '무직',
            '서울시 강북구', '2013-09-15');


-- 카테고리 테이블을 만들어 보자.
create table category(
    cnum number unique,                        -- 카테고리 번호
    category_code varchar2(8),                 -- 카테고리 코드
    category_name varchar2(30) not null,       -- 카테고리 이름
    primary key(category_code)
);


-- 카테고리 테이블에 데이터를 저장해 보자.
insert into category values(1, '00010000', '전자제품');
insert into category values(2, '00010001', 'TV');
insert into category values(3, '00010002', '컴퓨터');
insert into category values(4, '00010003', '노트북');
insert into category values(5, '00010004', '에어컨');
insert into category values(6, '00020000', '의류제품');
insert into category values(7, '00020001', '남방');
insert into category values(8, '00020002', '속옷');
insert into category values(9, '00020003', '바지');
insert into category values(10, '00030000', '도서');
insert into category values(11, '00030001', '컴퓨터도서');
insert into category values(12, '00030002', '소설');


-- 상품 정보 테이블을 만들어 보자.
create table products(
    pnum number(11) primary key,                   -- 제품 번호
    category_fk varchar2(8) not null,              -- 카테고리 코드
    products_name varchar2(50) not null,           -- 제품명
    ep_code_fk varchar2(5) not null,               -- 제품 코드
    input_price number(10) default 0 not null,     -- 제품 입고 가격
    output_price number(10) default 0 not null,    -- 제품 출고 가격
    trans_cost number(5) default 0 not null,       -- 제품 배송비
    mileage number(6) default 0 not null,          -- 제품 마일리지
    company varchar2(30),                          -- 제품 제조사
    constraint category_ref foreign key(category_fk) 
        references category(category_code)
);

-- 제품 데이터를 저장해 보자.
insert into products
   values(1, '00010001', 'S 벽걸이 TV', '00001', 5000000, 8000000, 0, 100000, '삼성');
insert into products
   values(2, '00010001', 'L TV', '00002', 1000000, 1500000, 0, 50000, 'LG');
insert into products
   values(3, '00010004', 'S 에어컨', '00001', 1000000, 1100000, 5000, 100000, '삼성');
insert into products
   values(4, '00010000', 'C 밥솥', '00003', 200000, 220000, 5500, 0, '쿠쿠');
insert into products
   values(5, '00010004', 'L 에어컨', '00003', 1200000, 1300000, 0, 0, 'LG');
insert into products
   values(6, '00020001', '남성난방', '00002', 100000, 150000, 2500, 0, '');
insert into products
   values(7, '00020001', '여성난방', '00002', 120000, 200000, 0, 0, '');
insert into products
   values(8, '00020002', '사각팬티', '00002', 10000, 20000, 0, 0, '보디가드');
insert into products
   values(9, '00020003', '멜빵바지', '00002', 15000, 18000, 0, 0, '');
insert into products
   values(10, '00030001', '무따기 시리즈', '00001', 25000, 30000, 2000, 0, '길벗');
   
commit;



/*
  order by 절
  
  - 자료를 정렬하여 나타낼 때 사용하는 명령어.
  - order by 절을 사용 시에는 select 구문의 
    맨 마지막에 와야 함.
  - asc 키워드 : 오름차순 정렬
  - desc 키워드 : 내림처순 정렬
  - 오름차순인 경우에는 asc를 생략해도 됨.
*/

-- member 테이블에서 이름을 기준으로 오름차순으로 정렬하여
-- 모든 정보를 화면에 보여주세요.
-- 단, 이름이 같은 경우에는 나이를 기준으로 내림차순 정렬하세요.
select *
from member
order by memname, age desc;


-- [문제1] emp 테이블에서 부서번호를 기준으로 오름차순 정렬을 하고,
-- 부서번호가 같은 경우 급여를 기준으로 내림차순으로 정렬을 하여
-- 화면에 보여주세요.
-- 단, 급여가 같은 경우 사원번호를 기준으로 오름차순 정렬
select *
from emp
order by deptno, sal desc, empno;

--[문제2] products 테이블에서 판매가격을 기준으로 내림차순으로
-- 정렬을 하여 모든 정보를 화면에 보여주세요.
select *
from products
order by output_price desc;


-- [문제3] products 테이블에서 배송비를 기준으로 내림차순으로
-- 정렬하세요. 단, 배송비가 같은 경우 마일리지를 기준으로
-- 내림차순으로 정렬하여 모든 정보를 화면에 보여주세요.
select *
from products
order by trans_cost desc, mileage desc;

-- [문제4] emp 테이블에서 입사일자가 오래된 사원부터 최근에 
-- 입사한 사원을 기준으로 정렬하되, 사원명, 입사일자를
-- 화면에 보여주세요.
select ename, hiredate
from emp
order by hiredate;


-- [문제5] emp 테이블에서 급여를 기준으로 내림차순으로 정렬을
-- 하여 모든 정보를 화면에 보여주세요.
select *
from emp
order by sal desc;


-- [문제6] emp 테이블에서 급여가 1100 이상인 사원들의 정보를
-- 보여주되, 입사일자가 빠른 순으로 정렬하여 화면에 보여주세요.
select *
from emp
where sal >= 1100
order by hiredate;

-- [문제7] emp 테이블에서 부서번호를 기준으로 오름차순 정렬하여
-- 나타내고, 부서번호가 같은 경우 담당업무를 기준으로 오름차순하여
-- 정렬하세요. 만약 담당업무가 같다고 하면, 급여가 많은데서 적은
-- 순으로 정렬하여 모든 정보를 화면에 보여주세요.
select *
from emp
order by deptno, job, sal desc;

-- 부서번호를 화면에 표시하되 중복을 제거하고 보여주는 방법.
-- distinct 키워드 : 중복을 제거하는 키워드.
select distinct deptno 
from emp;

select distinct job
from emp;

/*
  dual 테이블
  - 오라클에서 자체적으로 제공해 주는 테이블.
  - 간단하게 함수를 이용해서 계산, 결과값을 얻고자 할 때
    사용하는 테이블.
  - 결과값은 하나만 나옴
  - 사용 용도 : 특정 테이블을 생성할 필요가 업시 함수 또는
               계산을 하고자 할 때 사용.
*/

-- 오라클에서 제공해 주는 함수.
-- 1) 날짜와 관련된 함수들
--   * sysdate : 현재 시스템의 날짜를 알려 주는 키워드.
   select sysdate from dual;
   
--   * add_months(현재 날짜, 숫자(개월수)) : 현재 날짜에서 개월 수를 더해 주는 함수.
   select add_months(sysdate, 3) from dual;
   
--   * next_day(현재 날짜, '요일') : 다가올 날짜(요일)를 구해 주는 함수.
   select next_day(sysdate, '화요일') from dual;
   
--   * to_char(날짜, '날짜형식') : 형식에 맞게 문자열로 날짜를 출력해 주는 함수.
   select to_char(sysdate, 'yyyy/mm/dd') from dual;

   select to_char(sysdate, 'mm/dd/yy') from dual;
   
   select to_char(sysdate, 'yyyy-mm-dd') from dual;
   
--   * months_between('마지막 날짜', 현재 날짜) : 두 날짜 사이의 개월수를 출력해 주는 함수.
   select months_between('24/12/31', sysdate) from dual;
   
--   * last_day() : 현재 날짜의 마지막 일을 알려주는 함수.
   select last_day(sysdate) from dual;
   
-- 2) 문자와 관련된 함수들.
--   * concat('문자1', '문자2') : 두 개의 문자열을 연결(결합)해 주는 함수.
   select concat('안녕', '하세요?') from dual;

--   * || 연산자 : 문자열을 연결하는 연산자.
   select '방가' || '방가' from dual;
   
   select ename || '의 담당업무는 ' || job || ' 입니다.'
   from emp;
   
   select memname || '의 직업은 ' || job || ' 입니다.'
   from member;
   
--  * upper() : 소문자를 대문자로 만들어 주는 함수.
   select upper('happy day') from dual;
   
--  * lower() : 대문자를 소문자로 바꾸어 주는 함수.
    select lower(upper('happy day')) from dual;
    
--  * substr('문자열', x, y) : 문자열을 x부터 y의 길이만큼 추출해 주는 함수.
    select substr('ABCDEFG', 3, 2) from dual;  -- CD
    
--     x 값이 음수인 경우에는 오른쪽에서부터 시작됨.
    select substr('ABCDEFG', -3, 2) from dual;
    
--  * lpad('문자열', '전체자릿수', '늘어난 자릿수에 들어갈 문자')
    select lpad('happyday', 15, '*') from dual;
    
--  * rpad('문자열', '전체자릿수', '늘어난 자릿수에 들어갈 문자')
    select rpad('happyday', 15, '*') from dual;
    
--  * ltrim('문자열', '하나의 문자') : 왼쪽에 있는 문자를 지워주는 함수.
    select ltrim('ABCDEFGA', 'A') from dual;
    
--  * rtrim('문자열', '하나의 문자') : 오른쪽에 있는 문자를 지워주는 함수.
    select rtrim('ABCDEFGA', 'A') from dual;
    
--  * replace('원본 문자열', '교체할 문자열', '변경될 문잘열') : 문자열을 교체해 주는 함수.
    select replace('java program', 'java', 'python') from dual;
    

-- [문제1] emp 테이블에서 결과가 아래와 같이 나오도록
-- 화면에 보여주세요.
-- 결과) 'SCOTT의 담당업무는 ANALYST 입니다.'
-- 단, concat() 함수를 이용하세요.
select concat(concat(ename, '의 담당업무는 '), concat(job, ' 입니다')) from emp;


-- [문제2] emp 테이블에서 결과가 아래와 같이 나오도록
-- 화면에 보여주세요.
-- 결과) 'SCOTT의 연봉은 36000입니다.'
-- 단, concat() 함수를 이용하세요.
select concat(concat(ename, ' 의 연봉은 '), concat(sal*12, ' 입니다.')) from emp;


-- [문제3] member 테이블에서 결과가 아래와 같이 나오도록
-- 화면에 보여주세요.
-- 결과) '홍길동 회원의 직업은 학생입니다.'
-- 단, concat() 함수를 이용하세요.
select concat(concat(memname, ' 의 직업은 '), concat(job, ' 입니다.')) from member;


-- [문제4] emp 테이블에서 사번, 이름, 담당업무를 화면에
-- 보여주세요. 단, 담당업무는 소문자로 변경하여 보여주세요.
select empno, ename, lower(job)
from emp;


-- [문제5] 여러분의 주민등록 번호 중에서 생년월일을 추출하여
-- 화면에 보여주세요.
select substr('881201-1234567', 1, 6)
from dual;


-- [문제6] emp 테이블에서 담당업무에 'A' 라는 글자를
-- '$'로 바꾸어 화면에 보여주세요.
select replace(job, 'A', '$')
from emp;


-- [문제7] member 테이블에서 직업이 '학생' 인 정보를
-- '대학생'으로 바꾸어 화면에 보여주세요.
select replace(job, '학생', '대학생')
from member;


--[문제8] member 테이블에서 주소에 '서울시' 로 된 정보를
-- '서울특별시'로 바꾸어 화면에 보여주세요.
select replace(addr, '서울시', '서울특별시')
from member;


    
-- 3) 숫자와 관련된 함수들.
 
--  * abs(정수) : 절대값을 구해 주는 함수.
    select abs(23) from dual;
    select abs(-23) from dual;
    
--  * sign(정수) : 양수(1), 음수(-1), 0(0)을 반환해 주는 함수.
    select sign(0) from dual;
    select sign(22), sign(0), sign(-22) from dual;
    
--  * round() : 반올림을 할 때 사용하는 함수.
--   형식) round(숫자[필수], 반올림 위치[선택])
--   ==> 음수 값을 지정하면 자연수(정수)쪽으로 한자리씩 위로 반올림을 해 줌.
    select round(0.1234567, 6) from dual; -- 0.123457
    
    select round(2.3423557, 4) from dual; -- 2.3424
    
    select round(1256.5678, -2) from dual; -- 1300
    
--  * trunc() : 소수점 이하 자릿수를 잘라내는 함수.
--   형식) trunc(숫자[필수], 버릴위치[선택])
    select trunc(1234.1234567, 0) from dual;  -- 1234
    
    select trunc(1234.1234567, 4) from dual;  -- 1234.1234
    
    select trunc(1234.1234567, -3) from dual; -- 1000
    
--  * ceil() : 무조건 올림을 해 주는 함수.
    select ceil(22.8) from dual;  -- 23
    
    select ceil(22.2) from dual;  -- 23
    
--  * power() : 제곱을 해 주는 함수.
    select power(4, 3) from dual;
    
--  * mod() : 나머지를 구해 주는 함수.
--   형식) mod(나눗셈될 숫자[필수], 나눌 숫자[필수])
    select mod(77, 4) from dual;
    
--  * sqrt() : 제곱근을 구해 주는 함수.
    select sqrt(3) from dual;
    
    select sqrt(16) from dual;


/*
  그룹함수
  ==> 여러 행 또는 테이블 전체에 대하여 함수가 적용되어
      하나의 결과값을 가져오는 함수.
      
  - avg() : 평균값을 구하는 함수.
  - count() : 행(레코드)의 갯수를 구하는 함수.
              null 값은 무식하고 행의 갯수를 구함.
  - max() : 최대값을 구하는 함수.
  - min() : 최소값을 구하는 함수.
  - sum() : 총 합을 구하는 함수.
*/

-- emp 테이블에서 담당업무를 가지고 있는 모든 사원의
-- 수를 구하여 화면에 보여주세요.
select count(mgr)
from emp;


-- [문제1] emp 테이블에서 관리자(mgr)의 수를
-- 구하여 화면에 보여주세요.
select count(distinct mgr)
from emp;

--[문제2] emp 테이블에서 보너스를 가진 사원의 수를
-- 구하여 화면에 보여주세요.
select count(comm)
from emp;


--[문제3] emp 테이블에서 모든 'SALESMAN' 의 급여 평균과
-- 급여 최고액, 급여 최저액, 급여 합계액을 구하여
-- 화면에 보여주세요.
select avg(sal), max(sal), min(sal), sum(sal)
from emp
where job = 'SALESMAN';


--[문제4] emp 테이블에서 등록되어 있는 사원의 총 수,
-- 보너스가 null 이 아닌 사원 수, 보너스의 평균, 등록되어
-- 있는 부서의 수를 구하여 화면에 보여주세요.
select count(empno), count(comm), avg(comm), count(distinct deptno)
from emp;


-- DML 중에서 update(수정) 내용 진행.
-- update문
-- 형식) update 테이블명 set 수정할 컬럼명1 = 변경할 값, 수정할 컬럼명2 = 변경할 값
--      where primary key로 지정된 컬럼명 = 수정할 데이터;

update student set addr = '서울시 강서구'
    where hakbun = 20240827;
    
update student set major = '경제학과', addr = '서울시 노원구', regdate = sysdate
where hakbun = 20240826;

-- delete 문 : 테이블에서 데이터를 삭제하는 명령문.
-- 형식) delete from 테이블명
--       where primary key로 지정된 컬럼명 = 삭제할 데이터;
delete from student
 where hakbun = 20240826;
 
commit;

rollback;




