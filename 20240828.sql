/*
  group by 절
  - 특정한 컬럼이나 값을 기준으로 해당 레코드를 묶어서 자료를 관리할 때 사용.
  - 보통은 특정 컬럼을 기준으로 집계를 구하는데 많이 사용이 됨.
  - 그룹함수와 함꼐 사용을 하면 효과적으로 활용이 가능함.
*/

select distinct deptno
from emp
order by deptno;


select deptno
from emp
group by deptno;

-- emp 테이블에서 부서별로 해당 부서의 
-- 인원을 확인하고 싶은 경우
select deptno, count(*)
from emp
group by deptno
order by deptno;

-- emp 테이블에서 각 부서별로 부서 직원의
-- 급여 합계액을 구하여 화면에 보여주세요.
select deptno, sum(sal)
from emp
group by deptno
order by sum(sal) desc;


-- [문제] emp 테이블에서 부서별로 그룹을 지어서 부서의 급여 합계와
--  부서별 인원 수, 부서별 평균 급여, 부서별 최대 급여, 부서별 최소 급여를
--  구하여 화면에 보여주세요.
--  단, 급여 합계를 기준으로 내림차순으로 정렬하여 화면에 보여주세요.
select deptno, sum(sal), count(empno), avg(sal), max(sal), min(sal)
from emp
group by deptno
order by sum(sal) desc;

/*
  having 절
  - group by 절 다음에 나오는 조건절.
  - group by 절의 결과에 조건을 주어서 제한할 떄 사용함.
  - group by 절 다음에는 where(조건절)이 올 수 없음.
*/

-- products 테이블에서 카테고리 별로
-- 상품의 갯수를 화면에 보여주세요.
select category_fk, count(*)
from products
group by category_fk
having count(*) >= 2;


/*
  join ~ on 키워드
  - 테이블과 테이블을 연결하여 특정한 데이터를 얻고자 할 때 사용함.
  - 두 개 이상의 테이블에 정보가 나뉘어져 있을 때 사용함.
  - 중복은 발생하지 않지만, 원하는 정보를 얻기 위해서는 불편함이 발생함.
  - 특정 사원이 소속되 부서의 부서명을 알고 싶은 경우 emp 테이블과
    dept 체이블을 넘나드는 작업이 생기므로 상당히 불편함.
  - 그래서 이 두 개의 테이블을 결합하여 원하는 결과를 얻어내는
    조인이라는 가능이 생겨나게 되었음.
    
    조인의 종류
    1) euqal join
    2) self join
    3) outer join
*/

/*
  1) euqal join
     - 두 개 이상의 테이블이 조인될 때 공통적으로 존재하는 컬럼의 값이
       일치하는 행을 연결하여 결과를 얻는 방법.
     - 가장 많이 사용되는 조인 방법.
     - 단, 두 테이블이 조인을 하려면 일치되는 공통 컬럼이 존재해야 함.
*/

-- emp 테이블에서 사원의 사번, 이름, 담당업무, 부서번호,
-- 부서명, 부서위치를 화면에 보여주세요.
-- emp 테이블과 dept 테이블을 조인을 시키되 부서번호를 기준으로 조인해야 함.

select empno, ename, job, d.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno;

-- emp 테이블에서 사원명이 'SCOTT' 인 사원의 부서명을 알고 싶다면??
select empno, ename, d.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where ename = 'SCOTT';


-- [문제1] 부서명이 'RESEARCH' 인 사원의
-- 사번, 이름, 급여, 부서명, 근무위치를 화면에 보여주세요.
select empno, ename, sal, dname, loc
from emp e join dept d
on e.deptno = d.deptno
where dname = 'RESEARCH';


-- [문제2] emp 테이블에서 'NEW YORK'에 근무하는 사원의
-- 이름과 급여, 부서번호를 화면에 보여주세요.
select ename, sal, d.deptno
from emp e join dept d
on e.deptno = d.deptno
where loc = 'NEW YORK';


-- [문제3] emp 테이블에서 'ACCOUNTING' 부서 소속 사원의
-- 이름과 담당업무, 입사일 그리고 부서번호, 부서명을
-- 화면에 보여주세요.
select ename, job, hiredate, e.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where dname = 'ACCOUNTING';


--[문제4] emp 테이블에서 담당업무가 'SALESMAN' 인 사원의
-- 이름과 담당업무, 부서번호, 부서명, 근무위치를 화면에 보여주세요.
select ename, job, e.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno
where job = 'SALESMAN';


/*
  2) self join
  - 테이블과 테이블을 조인을 해야 데이터를 얻어 낼 수 있는데 말 그대로
    자기 지신과 조인을 맺는 것을 말함.
  - from 다음에 테이블 이름을 나란히 두 번 기술을 할 수 없음.
    따라서 테이블이 존재하는 것처럼 하기 위해서 반드시 별칭을 주어야 함.
*/

-- emp 테이블에서 각 사원별 관리자의 이름을 화면에 출력해 보자.
-- 출력 예) CLARK의 관리자 이름은 KING 입니다.
select e1.ename || ' 의 관리자 이름은 ' || e2.ename || ' 입니다.'
from emp e1 join emp e2
on e1.mgr = e2.empno;


/*
  3) outer join
  - 2개 이상의 테이블이 조인이 되는 경우 어느 한 쪽 테이블에는
    데이터가 있지만 다른쪽 테이블에는 데이터가 존재하지 않는 경우
    해당 데이터가 출력이 되지 않는 문제가 발생함. 해당 문제점을
    해결하기 위해서 생긴 기법.
  - 정보가 부족한 테이블의 컬럼 뒤에 '(+)' 기호를 붙여서 사용을 함.
*/

select ename, d.deptno, dname
from emp e join dept d
on e.deptno(+) = d.deptno;

select e1.ename, e1.job, e1.mgr
from emp e1 join emp e2
on e1.mgr = e2.empno(+);

/*
  view
  - 가상의 테이블임.
  - view는 실제적으로 데이터를 저장하고 있지 않음.
  - view를 만들면 실제 데이터베이스에 접근을 하여 데이터를 가져옴.
  - view는 주로 데이터를 조회(select) 할 때 사용이 됨.
  - view를 사용하는 이유
    1) 보안 관리를 위해서 사용.
       ==> 보안 등급에 맞춰서 컬럼의 범위를 정하여 조회가 가능하도록 할 수 있음.
    2) 사용자의 편의성을 제공함.
    
    형식) create view 뷰이름
          as
          쿼리문;
*/

-- 인사부 view는 컬럼에 sal(급여), comm(보너스)은 제외
create view emp_insa
as
select empno, ename, job, mgr, hiredate, deptno
from emp;

select * from emp_insa;

-- 영업부 view는 컬럼에 sal(급여)은 제외
create view emp_sales
as
select empno, ename, job, mgr, hiredate, comm, deptno
from emp;

select * from emp_sales;

-- 회계부 view는 모든 컬럼 작용
create view emp_account
as
select *
from emp;

select * from emp_account;


-- 2) 사용자의 편의성을 제공함.
create view emp_salary
as
select empno, ename, (sal*12 + nvl2(comm, comm, 0)) "연봉"
from emp;

select * from emp_salary;


/*
  트랜잭션(transaction)?
  - 데이터 처리의 한 단위.
  - 오라클에서 발생하는 여러 개의 sql 명령문들을 하나의 논리적인
    작업 단위로 차리하는 것을 말함.
  - all or nothing
  - 명령이 정상적으로 처리가 되면 종료를 하고, 여러 개의 명령어 중에서
    하나의 명령이라도 잘못이 되면 전체를 취소하는 작업을 말함.
    
  - 트랜잭션을 사용하는 이유 : 데이터의 일관성을 유지하고 데이터의 
                            안정성을 보장하기 위함.
  
  - commit : 모든 작업을 정상적으로 처리하겠다고 확정하는 명령어.
             트랜잭션(insert, update, delete) 되는 작업의 내용을
             DB에 반영.

  - rollback : 작업 중에 문제가 발생했을 때 트랜잭션 처리 과정에서
               변경 사항을 취소하여 이전 상태로 되돌리는 명령어.
*/

-- 1. dept 테이블을 복사하여 dept_02 라는 테이블을 만들어 보자.
create table dept_02
as
select * from dept;



-- 2. dept_02 테이블에서 40번 부서를 삭제 후 commit을 해 보자.
delete from dept_02
where deptno = 40;

commit;

-- 3. dept_02 테이블의 전체 데이터를 삭제해 보자.
delete from dept_02;

-- 4. 이 때 만약 30번 부서에 대해서만 삭제를 하려고 했는데
-- 잘못해서 전체가 삭제가 된 경우, 다시 복원 할 수 있다.
rollback;


select * from dept_02;


/*
  savepoint
  - 트랜잭션을 작게 분할하는 것을 말함.
  - 사용자가 트랜잭션 중간 단계에서 포인트를 지정하여
    트랜잭션 내의 특정 savepoint까지 rollback 할 수
    있게 하는 것을 말함.
*/

-- 1. dept 테이블을 복사하여 dept_03 이라는 테이블을 만들어 보자.
create table dept_03
as
select * from dept;

-- 2. dept_03 테이블에서 40번 부서를 삭제한 후 commit 을 해 보자.
delete from dept_03
where deptno = 40;

-- 3. dept_03 테이블에서 30번 부서를 삭제해 보자.
delete from dept_03
where deptno = 30;

-- 4. 이 때 savepoint sp1 을 설정해 보자.
savepoint sp1;

-- 5. dept_03 테이블에서 20번 부서를 삭제해 보자.
delete from dept_03
where deptno = 20;

-- 6. 이 때 savepoint sp2 을 설정해 보자.
savepoint sp2;

-- 7. dept_03 테이블에서 10번 부서를 삭제해 보자.
delete from dept_03
where deptno = 10;

-- 8. 부서번호가 20번인 부서를 삭제하기 전으로
-- 되돌라 가고 싶은 경우
rollback to sp1;


/*
  서브쿼리
  - 하나의 쿼리문 안에 또 다른 쿼리문이 포함되어 있는 쿼리문을 말함.
  - 여러번 쿼리를 실행해야지만 얻을 수 있는 결과를 하나의 중첩된
    쿼리 문장으로 결과를 얻을 수 있께 함.
  
  주의사항
    - 안쪽에 있는 쿼리문은 괄호로 묶어서 사용하는 것이 관례임.
    - 안쪽에 있는 쿼리문은 order by 절은 사용할 수 없음.
    
  실행방법 
    - 우선은 안쪽에 있는 쿼리문을 실행후에 그 결과값을 가지고
      바깥쪽 쿼리문을 실행을 하면 됨.
*/

-- emp 테이블에서 이름이 'SCOTT' 인 사원의 급여보다 더 많은 급여를
-- 받는 사원의 사번, 이름. 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where sal > (select sal from emp where ename = 'SCOTT');  -- SCOTT의 급여 : 3000


-- 서브쿼리 문제
-- [문제1] emp 테이블에서 평균급여보다 더 적게 받는 사원의
-- 사번, 이름, 담당업무, 급여, 부서번호를 화면에 보여주세요.
select empno, ename, job, sal, deptno
from emp
where sal < (select avg(sal) from emp);   -- 평균 급여 : 약 2073


-- [문제2] emp 테이블에서 사번이 7521인 사원과 담당업무가 같고,
-- 사번이 7934인 사원의 급여보다 더 많이 받는 사원의 사번, 이름, 
-- 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where job = (select job from emp where empno = 7521)  -- 담당업무 : SALESMAN
and
sal > (select sal from emp where empno = 7934);  -- 7934 사원의 급여 1300 

-- [문제3] emp 테이블에서 담당업무가 'MANAGER' 인 사원의 최소급여보다
-- 적으면서, 담당업무가 'CLERK'은 아닌 사원의 사번, 이름, 담당업무,
-- 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where sal < (select min(sal) from emp where job = 'MANAGER')   -- MANAGER 최소 급여 : 2450
and job != 'CLERK';

-- [문제4] 부서위치가 'DALLAS' 인 사원의 사번, 이름, 부서번호, 
-- 담당업무를 화면에 보여주세요.
select empno, ename, deptno, job
from emp
where deptno = (select deptno from dept where loc = 'DALLAS');    -- DALLAS 부서번호 : 20번 부서


-- [문제5] member 테이블에 있는 고객의 정보 중 마일리지가 가장 높은
-- 고객의 모든 정보를 화면에 보여주세요.
select *
from member
where mileage = (select max(mileage) from member);   -- 최대 마일리지 : 10,000


-- [문제6] emp 테이블에서 'SMITH' 인 사원보다 더 많은 급여를
-- 받는 사원의 이름과, 급여를 화면에 보여주세요.
select ename, sal
from emp
where sal > (select sal from emp where ename = 'SMITH');   -- SMITH 사원 급여 : 800


-- [문제7] emp 테이블에서 10번 부서 급여의 평균 급여보다 적은 급여를 받는
-- 사원들의 이름, 급여, 부서번호를 화면에 보여주세요.
select ename, sal, deptno
from emp
where sal < (select avg(sal) from emp where deptno = 10);  -- 10번 부서 평균 급여 : 약 2916


-- [문제8] emp 테이블에서 'BLAKE'와 같은 부서에 있는 사원들의
-- 이름과 입사일자, 부서번호를 화면에 보여주되, 'BLAKE' 는 제외하고
-- 화면에 보여주세요.
select ename, hiredate, deptno
from emp
where deptno = (select deptno from emp where ename = 'BLAKE')   -- BLAKE 사원 부서번호 : 30번 부서 
and ename != 'BLAKE';

-- [문제9] emp 테이블에서 평균급여보다 더 많이 받는 사원들의 사번,
-- 이름, 급여를 화면에 보여주되, 급여가 높은데서 낮은 순으로 화면에 
-- 보여주세요.
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)   -- EMP 테이블 직원 평균 급여 : 2073
order by sal desc;

-- [문제10] emp 테이블에서 이름에 'T'를 포함하고 있는 사원들과 같은 부서에
-- 근무하고 있는 사원의 사번과 이름, 부서번호를 화면에 보여주세요.
select empno, ename, deptno
from emp
where deptno in (select distinct deptno from emp where ename like '%T%');


-- [문제11] 'SALES' 부서에서 근무하고 있는 사원들의 부서번호,
-- 이름, 담당업무를 화면에 보여주세요.
select deptno, ename, job
from emp
where deptno = (select deptno from dept where dname = 'SALES');  -- SALES 부서명에 해당하는 부서번호 : 30


-- [문제12] emp 테이블에서 'KING'에게 보고하는 모든 사원의
-- 이름과 급여, 관리자를 화면에 보여주세요.
select ename, sal, mgr
from emp
where mgr = (select empno from emp where ename = 'KING');  -- KING 사원의 사번 7839


-- [문제13] emp 테이블에서 자신의 급여가 평균급여보다 많고, 이름에
-- 'S' 자가 들어가는 사원과 동일한 부서에서 근무하는 모든 사원의 
-- 사번, 이름, 급여, 부서번호를 화면에 보여주세요.
select empno, ename, sal, deptno
from emp
where sal > (select avg(sal) from emp)   -- EMP 테이블 직원 평균 급여 : 2073
and
deptno in (select distinct deptno from emp where ename like '%S%');


-- [문제14] emp 테이블에서 보너스를 받는 사원과 부서번호, 급여가 같은
-- 사원의 이름, 급여, 부서번호를 화면에 보여주세요.
select ename, sal, deptno
from emp
where deptno in (select deptno from emp where comm > 0)
and
sal in (select sal from emp where comm > 0);


-- [문제15] products 테이블에서 상품의 판매가격이 판매가격의
-- 평균보다 큰 상품의 전체 내용을 화면에 보여주세요.
select *
from products
where output_price > (select avg(output_price) from products);  -- 평균 판매 가격 : 1,253,800원


-- [문제16] products 테이블에 있는 판매 가격에서 평균 가격 이상의
-- 상품 목록을 구하되, 평균을 구할 때 가격이 가장 큰 금액인 상품을
-- 제외하고 평균을 구하여 화면에 보여주세요.
select *
from products
where output_price >= (select avg(output_price) from products
where output_price <>
(select max(output_price) from products));


-- [문제17] products 테이블에서 상품명의 이름에 '에어컨' 이라는
-- 단어가 포함된 카테고리에 속하는 상품목록을 화면에 보여주세요.
select *
from products
where category_fk in(select distinct category_fk from products where products_name like '%에어컨%');

-- [문제18] member 테이블에 있는 고객 정보 중 마일리지가 가장 높은 
-- 금액을 가지는 고객에게 보너스 마일리지 5000점을 더 주어 고객명,
-- 마일리지, 마일리지+5000 점을 화면에 보여주세요.
select memname, mileage, mileage + 5000 "추가된 마일리지"
from member
where mileage = (select max(mileage) from member);    -- 최대 마일리지 : 10,000

