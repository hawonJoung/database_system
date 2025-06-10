/* 
 * 데이터베이스 시스템 Term Project
 * 제출자: [정하원]
 * 학번: [202233149]
 * 날짜: [2025-06-07]
 */

-- ----------------------------------------------------
-- 0. 외래 키 의존성 이해도 체크 (객관식 문제)
-- ----------------------------------------------------

-- 아래 객관식 문제를 풀어 외래 키 의존성과 순서의 이유를 이해했는지 확인하세요.
-- 각 문제의 정답을 주석으로 작성하세요.
-- 문제 1: 왜 regions 테이블을 가장 먼저 생성해야 하는가?
-- a) 외래 키로 다른 테이블을 참조하기 때문
-- b) 다른 테이블에서 regions를 참조하기 때문
-- c) regions가 가장 많은 데이터를 포함하기 때문
-- d) 순서와 상관없음
-- 답안: b 

# 정답 근거: 예를 들어, countries 테이블이 regions 테이블의 region_id를 외래 키로 참조하므로, regions 테이블이 먼저 생성 되어야함
# 오답 근거: 
# a): regions 테이블에는 다른 테이블의 외래 키로 참조되지 않음
# c): 테이블 생성 순서는 데이터 크기와 관련이 없음
# d):  외래 키 제약 조건으로 인해 테이블 생성 순서는 중요


-- 문제 2: employees와 departments 테이블 간 상호 참조 관계를 해결하기 위해 어떤 순서로 작업해야 하는가?
-- a) employees를 생성하고 바로 외래 키를 설정한 후 departments 생성
-- b) departments를 생성하고 바로 외래 키를 설정한 후 employees 생성
-- c) 두 테이블을 모두 생성한 후 외래 키를 설정
-- d) 상호 참조 관계는 설정할 수 없음
-- 답안: c

# 정답 근거: 상호 참조 문제는 alter table을 사용하여 각 테이블에 외래 키 제약 조건을 추가하여 해결할 수 있음 
# 오답 근거:
# a): employees 테이블 생성 시, departments 테이블이 존재하지 않아 department_id 외래 키를 즉시 설정할 수 없음 
# b): departments 테이블 생성 시, employees 테이블이 존재하지 않아 manager_id 외래 키를 즉시 설정할 수 없음
# d): 상호 참조 관계는 alter table 명령을 사용하여 설정할 수 있음

-- 문제 3: job_history 테이블을 employees, jobs, departments 테이블보다 나중에 생성해야 하는 이유는?
-- a) job_history가 이 세 테이블을 외래 키로 참조하기 때문
-- b) job_history가 가장 많은 데이터를 포함하기 때문
-- c) 순서와 상관없음
-- d) job_history가 외래 키를 참조하지 않기 때문
-- 답안: a

# 정답 근거: 참조하는 테이블들의 아이디 모두를 외래 키로 사용하기 때문에 참
# 오답 근거:
# b): 테이블 생성 순서는 데이터 크기와 관련이 없음
# c): 외래 키 제약 조건으로 인해 테이블 생성 순서는 중요
# d): job_history 테이블은 employees, jobs, departments 테이블을 외래 키로 참조함

-- 문제 4: 왜 employees 테이블을 외래 키 없이 먼저 생성해야 하는가?
-- a) 데이터가 많아서 먼저 생성해야 하기 때문
-- b) 자기 참조 관계(manager_id)와 상호 참조 관계(departments)가 있기 때문
-- c) 외래 키 설정이 필요 없기 때문
-- d) 순서와 상관없기 때문
-- 답안: b

# 정답 근거: 자기 참조와 상호 참조는 테이블 생성 후, alter table로 외래 키 추가해야 함
# 오답 근거:
# a): 테이블 생성 순서는 데이터 크기와 관련이 없음
# c): mployees 테이블은 다른 테이블과의 관계를 위해 외래 키 설정이 필요함
# d): 테이블 간의 관계에서 순서는 중요

-- 문제 5: jobs 테이블이 다른 테이블을 참조하지 않음에도 불구하고 employees와 job_history 전에 생성되는 이유는?
-- a) jobs 테이블이 가장 간단하기 때문
-- b) employees와 job_history가 jobs.job_id를 참조하기 때문
-- c) 데이터 크기가 작기 때문
-- d) 순서와 상관없기 때문
-- 답안: b

# 정답 근거: employees와 job_history가 jobs.job_id를 참조하려면 jobs 테이블이 먼저 생성되어야 함
# 오답 근거:
# a): 테이블 생성 순서는 테이블의 복잡성과 관련이 없음
# c): 테이블 생성 순서는 데이터 크기와 관련이 없음
# d): 외래 키 관계는 테이블 생성 순서에 영향을 줌

-- ----------------------------------------------------
-- 1. 데이터베이스 구축 (DDL 작성)
-- 테이블 생성 순서는 외래 키 의존성을 고려해야 합니다.
-- ----------------------------------------------------

-- 1.1 regions 테이블 생성
CREATE TABLE regions (
    region_id INT UNSIGNED NOT NULL PRIMARY KEY,
    region_name VARCHAR(25)
);
# 제공된 데이터셋 활용해 작성함
# ctrl + b 로 정렬함 
# 지역 테이블을 생성해 
# 아이디를 정수형, 0과 양수, 널값 불가, 기본 키로 설정하고, 지역 이름을 최대 25자 문자열 설정함

-- 1.2 countries 테이블 생성
CREATE TABLE countries (
    country_id CHAR(2) NOT NULL PRIMARY KEY,
    country_name VARCHAR(40),
    region_id INT UNSIGNED NOT NULL
);
# 국가 테이블를 생성해 
# 아이디를 2글자 고정 문자열로 설정, 널값 불가, 기본 키로 설정함
# 국가명은 최대 40자 문자열 설정하고, 지역 아이디 정수형, 0과 양수, 널값 차단함 
# 국가 아이디는 정수형, 0과 양수, 널값 불가함
# 외래키 제약 조건 관련 테이블은 전부 태이블 생성 순서와 상호 참조 문제로 인해 테이블 생성 후 alter table로 유연하게 추가할 예정

-- 1.3 locations 테이블 생성
CREATE TABLE locations (
    location_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    street_address VARCHAR(40),
    postal_code VARCHAR(12),
    city VARCHAR(30) NOT NULL,
    state_province VARCHAR(25),
    country_id CHAR(2) NOT NULL
);
# 위치 테이블을 생성해
# 아이디를 정수형, 0과 양수, 널값 불가, 자동 증가, 기본 키로 설정함
# 도로명 주소를 최대 40자 문자열 설정함
# 우편번호를 최대 12자 문자열 설정함
# 도시를 최대 30자 문자열, 널값 불가로 설정함
# 주/도를 최대 25자 문자열 설정함
# 국가 아이디는 2글자 고정 문자열, 널값 불가로 설정함
# auto_increment은 행이 삽입될 때 1부터 자동으로 순서가 부여됨

-- 1.4 departments 테이블 생성
CREATE TABLE departments (
    department_id INT UNSIGNED NOT NULL PRIMARY KEY,
    department_name VARCHAR(30) NOT NULL,
    manager_id INT UNSIGNED,
    location_id INT UNSIGNED
);
# 부서 테이블을 생성해
# 부서 아이디를 정수형, 0과 양수, 널값 불가, 기본 키로 설정함
# 부서명을 최대 30자 문자열, 널값 불가로 설정함
# 관리자 아이디를 정수형, 0과 양수로 설정함
# 위치 아이디를 정수형, 0과 양수로 설정함

-- 1.5 jobs 테이블 생성
CREATE TABLE jobs (
    job_id VARCHAR(10) NOT NULL PRIMARY KEY,
    job_title VARCHAR(35) NOT NULL,
    min_salary DECIMAL(8 , 0 ) UNSIGNED,
    max_salary DECIMAL(8 , 0 ) UNSIGNED
);
# 직업 테이블을 생성해
# 직업 아이디를 최대 10자 문자열, 널값 불가, 기본 키로 설정함
# 직업명을 최대 35자 문자열, 널값 불가로 설정함
# 최소 급여를 숫자형(8자리, 소수점 없음), 0과 양수로 설정함
# 최대 급여를 숫자형(8자리, 소수점 없음), 0과 양수로 설정함

-- 1.6 employees 테이블 생성
CREATE TABLE employees (
    employee_id INT UNSIGNED NOT NULL PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(25) NOT NULL,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    salary DECIMAL(8 , 2 ) NOT NULL,
    commission_pct DECIMAL(2 , 2 ),
    manager_id INT UNSIGNED,
    department_id INT UNSIGNED
);
# 사원 테이블을 생성해
# 사원 아이디를 정수형, 0과 양수, 널값 불가, 기본 키로 설정함
# 이름을 최대 20자 문자열로 설정함
# 성을 최대 25자 문자열, 널값 불가로 설정함
# 이메일을 최대 25자 문자열, 널값 불가로 설정함
# 전화번호를 최대 20자 문자열로 설정함
# 입사일을 날짜 형식, 널값 불가로 설정함
# 직업 아이디를 최대 10자 문자열, 널값 불가로 설정함
# 급여를 숫자형(8자리, 소수점 2자리), 널값 불가로 설정함
# 커미션 비율을 숫자형(2자리, 소수점 2자리)으로 설정함
# 관리자 아이디를 정수형, 0과 양수로 설정함
# 부서 아이디를 정수형, 0과 양수로 설정함

-- 1.7 job_history 테이블 생성
CREATE TABLE job_history (
    employee_id INT UNSIGNED NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    department_id INT UNSIGNED NOT NULL
);
# 직무 이력을 생성해
# 사원 아이디를 정수형, 0과 양수, 널값 불가로 설정함
# 시작일을 날짜 형식, 널값 불가로 설정함
# 종료일을 날짜 형식, 널값 불가로 설정함
# 직업 아이디를 최대 10자 문자열, 널값 불가로 설정함
# 부서 아이디를 정수형, 0과 양수, 널값 불가로 설정함

-- 1.8 job_grades 테이블 생성
CREATE TABLE job_grades (
    grade_level CHAR(1) NOT NULL PRIMARY KEY,
    lowest_sal INT NOT NULL,
    highest_sal INT NOT NULL
);
# 급여 등급을 생성헤
# 등급을 1글자 고정 문자열, 널값 불가, 기본 키로 설정함
# 최소 급여를 정수형, 널값 불가로 설정함
# 최대 급여를 정수형, 널값 불가로 설정함

-- 1.9 job_history 테이블 UNIQUE 제약조건 추가
alter table job_history 
add unique index uc_job_history (employee_id, start_date);
# 직무 이력 테이블에 사원 아이디와 시작일 조합에 대해 UNIQUE 제약 조건 추가
# unique 제약조건 추가 이유는 한 사원이 특정 날짜에 여러 직무를 시작하는 것을 막기 위함임

-- --------------------------------------------------------
-- 2. 외래 키 제약조건 설정
-- 상호 참조 관계(employees, departments)는 순서에 주의하세요.
-- --------------------------------------------------------

-- 2.1 countries 테이블 외래 키 설정
alter table countries 
add constraint fk_countries_region_id foreign key (region_id) references regions (region_id);
# 국가 테이블의 지역 아이디를 지역 테이블의 지역 아이디를 참조하는 외래 키로 설정

-- 2.2 locations 테이블 외래 키 설정
alter table locations 
add constraint fk_locations_country_id foreign key (country_id) references countries (country_id);
# 위치 테이블의 국가 아이디를 국가 테이블의 국가 아이디를 참조하는 외래 키로 설정

-- 2.3 departments 테이블 외래 키 설정
alter table departments 
add constraint fk_departments_location_id foreign key (location_id) references locations (location_id);
# 부서 테이블의 위치 아이디를 위치 테이블의 위치 아이디를 참조하는 외래 키로 설정

-- 2.4 employees 테이블 외래 키 설정 (job_id)
alter table employees 
add constraint fk_employees_job_id foreign key (job_id) references jobs (job_id);
# 사원 테이블의 직업 아이디를 직업 테이블의 직업 아이디를 참조하는 외래 키로 설정

-- 2.5 employees 테이블 외래 키 설정 (department_id)
-- 주석: departments 테이블 생성 후 설정 가능 (상호 참조 관계 고려)
alter table employees 
add constraint fk_employees_department_id foreign key (department_id) references departments (department_id);
# 사원 테이블의 부서 아이디를 부서 테이블의 부서 아이디를 참조하는 외래 키로 설정
# 부서 테이블과의 상호 참조 관계를 해결하기 위해 alter table로 나중에 설정함

-- 2.6 employees 테이블 외래 키 설정 (manager_id)
-- 주석: 자기 참조 관계
alter table employees 
add constraint fk_employees_manager_id foreign key (manager_id) references employees (employee_id);
# 사원 테이블의 관리자 아이디를 사원 테이블의 사원 아이디를 참조하는 외래 키로 설정 (자기 참조)

-- 2.7 departments 테이블 추가 외래 키 설정 (manager_id)
-- 주석: employees 테이블과의 상호 참조 관계 해결
alter table departments 
add constraint fk_departments_manager_id foreign key (manager_id) references employees (employee_id);
# 부서 테이블의 관리자 아이디를 사원 테이블의 사원 아이디를 참조하는 외래 키로 설정
# 사원 테이블과의 상호 참조 관계를 해결하기 위해 alter table로 나중에 설정함

-- 2.8 job_history 테이블 외래 키 설정 (employee_id)
alter table job_history 
add constraint fk_job_history_employee_id foreign key (employee_id) references employees (employee_id);
# 직무 이력 테이블의 사원 아이디를 직원 테이블의 사원 아이디를 참조하는 외래 키로 설정

-- 2.9 job_history 테이블 외래 키 설정 (job_id)
alter table job_history 
add constraint fk_job_history_job_id foreign key (job_id) references jobs (job_id);
# 직무 이력 테이블의 직업 아이디를 직업 테이블의 직업 아이디를 참조하는 외래 키로 설정

-- 2.10 job_history 테이블 외래 키 설정 (department_id)
alter table job_history 
add constraint fk_job_history_department_id foreign key (department_id) references departments (department_id);
# 직무 이력 테이블의 부서 아이디를 부서 테이블의 부서 아이디를 참조하는 외래 키로 설정

-- ----------------------------------------------------
-- 3. SQL 질의 문제 해결
-- ----------------------------------------------------

-- 문제 1: [쉬움] 급여가 높은 상위 5명 사원 조회
-- employees 테이블에서 salary가 가장 높은 상위 5명 사원의 first_name, last_name, salary를 조회하시오.
-- (급여 순으로 내림차순 정렬)

-- 답안: 
SELECT 
    first_name, last_name, salary
FROM
    employees
ORDER BY salary DESC
LIMIT 5;
# (문제 해결 과정)
# 사원 테이블에서 이름, 성, 급여를 조회하고, 급여를 내림차순 정렬하여 상위 5명의 사원만 출력하였습니다.

-- 문제 2: [쉬움] Sales 부서 사원 조회
-- employees 테이블과 departments 테이블을 JOIN하여 'Sales' 부서(department_name)에 근무하는 
-- 모든 사원의 employee_id, first_name, last_name, job_id를 조회하시오.

-- 답안:
SELECT 
    e.employee_id, e.first_name, e.last_name, e.job_id
FROM
    employees e
        JOIN
    departments d ON e.department_id = d.department_id
WHERE
    d.department_name = 'Sales';
# (문제 해결 과정)
# Sales 부서에 근무하는 사원의 아이디, 이름, 성, 직업 아이디를 조회하기 위해 사원 테이블과 부서 테이블을 조인했습니다.

-- 문제 3: [중간] 부서별 사원 수와 평균 급여 계산
-- 각 부서(department_name)별 사원 수와 평균 급여(salary)를 계산하여 조회하시오.
-- 결과는 부서명을 알파벳 순으로 정렬하고, 사원이 없는 부서는 제외하시오.

-- 답안:
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM
    departments d
        JOIN
    employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY d.department_name;
# (문제 해결 과정)
# 해당 문제부터 EER 다이어그램을 활용하여 조인 조건을 확인했습니다.
# ROUND() 함수를 사용해 소수점 둘째 자리까지 반올림하였습니다.
# 최종적으로, 부서와 사원 테이블을 조인하여 부서별 사원 수의 합계, 평균 급여를 계산/조회하고, 
# 부서 이름을 기준으로 오름차순 정렬하여 출력하였습니다.
 
-- 문제 4: [중간] 2000년 이후 입사 & 부서 평균보다 높은 급여 사원 조회
-- 2000년 이후(2000년 포함) 입사한 사원 중에서, 급여(salary)가 해당 부서의 평균 급여보다 높은 
-- 사원의 employee_id, first_name, last_name, department_id, salary를 조회하시오. (서브쿼리 활용)

-- 답안:
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id,
    e.salary
FROM
    employees e
WHERE
    e.salary > (SELECT 
            AVG(e1.salary)
        FROM
            employees e1
        WHERE
            e1.department_id = e.department_id)
        AND YEAR(e.hire_date) >= 2000;
# (문제 해결 과정)
# 먼저, 서브쿼리를 통해 집계함수를 작성해야겠다고 판단하였고,
# 메인 쿼리와 서브쿼리에서 사용하는 테이블이 같으므로, 상관 부속 질의를 사용하였습니다.
# 또한 날짜 함수를 활용해 서브쿼리에 입사년도 조건을 추가하였습니다.
# 최종적으로, 사원 테이블에서 2000년 이후 입사한 사원 중,
# 부서별로 평균 급여보다 높은 사원의 아이디, 이름, 성, 부서 아이디, 급여를 조회하였습니다.

-- 문제 5: [어려움] 사원의 현재 급여와 이전 직무 제목 조회
-- 각 사원(employee_id, first_name, last_name)의 현재 급여(salary)와 직무 이력(job_history)에 
-- 기록된 이전 직무의 제목(job_title)을 함께 조회하시오. 이전 직무가 없는 사원도 결과에 포함하며, 
-- 이 경우 이전 직무 제목은 NULL로 표시하시오. (JOIN과 LEFT JOIN 활용)

-- 답안:
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    (SELECT 
            j.job_title
        FROM
            job_history jh
                LEFT JOIN
            jobs j ON jh.job_id = j.job_id
        WHERE
            jh.employee_id = e.employee_id
        ORDER BY jh.end_date DESC
        LIMIT 1) AS previous_job_title
FROM
    employees e;    
# (문제 해결 과정)
# 조회해야 하는 컬럼을 살펴보았을 때, 이전 직무의 제목을 제외하고 전부 사원 테이블에서 출력 가능한 컬럼이므로
# 이전 직무의 제목만을 서브쿼리로 이용하는 방법을 고려했습니다.
# 먼저 큰 틀에서 메인 쿼리를 작성하고, 이후 SELECT 절 마지막에 서브쿼리를 작성했습니다.
# 서브쿼리를 작성할 때, 이전 직무의 제목은 사원별로 출력해야 하므로 GROUP BY 또는 상관 부속 질의를 연상했습니다.
# 그런데 사원별로 이전 직무의 제목을 집계함수로 사용하는 것이 적절하지 않다고 판단하여, 상관 부속 질의를 선택했습니다.
# 상관 부속 질의의 경우, 가장 최근 직무 이력은 ORDER BY와 LIMIT를 활용했습니다.
# 직무 이력 테이블과 직무 테이블을 LEFT JOIN하여, 이전 직무 이력이 없는 경우도 널값으로 결과에 포함시킵니다.
# 최종적으로 사원 테이블에서 각 사원의 사원 아이디, 이름, 성, 급여, 서브쿼리를 통해 얻은
# 가장 최근 직무 이력의 직무 제목을 함께 출력합니다. 만약 사원에게 직무 이력이 없다면, 이전 직무 제목은 널값으로 표시됩니다.

-- 문제 6: [중급] 근속 연수 및 보너스 계산
-- 각 사원의 근속 연수를 계산하고, 근속 연수에 따른 보너스를 계산하는 쿼리를 작성하시오.
-- 근속 연수는 현재 날짜와 입사일(hire_date) 기준으로 계산하며, 다음 보너스 비율을 적용하시오:
--   * 25년 이상: 급여의 25%
--   * 20년 이상: 급여의 20%
--   * 15년 이상: 급여의 15%
--   * 10년 이상: 급여의 10%
--   * 그 외: 급여의 5%
-- 결과는 근속 연수를 기준으로 내림차순 정렬하시오.
-- (YEAR, DATEDIFF, ROUND, CONCAT, CASE 함수 활용)

-- 답안:
SELECT 
    employee_id,
    CONCAT(first_name, ' ', last_name) AS employee_name,
    ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 0) AS years_of_service,
    ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 1) AS exact_years,
    salary,
    CASE
        WHEN ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 1) >= 25 THEN salary * 0.25
        WHEN ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 1) >= 20 THEN salary * 0.20
        WHEN ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 1) >= 15 THEN salary * 0.15
        WHEN ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 1) >= 10 THEN salary * 0.10
        ELSE salary * 0.05
    END AS service_bonus
FROM
    employees
ORDER BY years_of_service DESC;
# (문제 해결 과정)
# 쿼리 작성에 앞서, 근속 연수를 계산하는 방법을 고려하였습니다.
# 두 날짜 차이를 계산하는 DATEDIFF() 함수를 사용하여 현재 날짜를 보여주는 CURDATE() 함수를 계산에 포함하고,
# 따옴표 없이 문자열 열 값을 반환하는 hire_date 컬럼을 계산에 사용하였습니다. 
# 계산된 날짜 차이를 365일로 나누어 1년 단위로 조정하였습니다. 
# ROUND() 함수를 사용해 1의 자리까지 반올림하여 years_of_service를 나타내었고, 
# 소수점 첫째 자리까지 반올림하여 exact_years를 나타내었습니다.
# case 함수를 사용하여 보너스 비율을 산정하였습니다. 
# 조회해야 하는 이름과 성을 결합하는 CONCAT() 함수를 사용하여 이름과 성 사이에 공백을 추가해 구분하여 조회하도록 하였습니다.
# 최종적으로, 사원 테이블에서 사원 아이디, 사원 성명, 고용일, 근속 연수, 세부 연수, 급여를 조회하였고, 
# CASE 문을 사용하여 25년 이상 근무한 세부 연수에 대해 급여의 25%를 적용한 보너스를 적용하고, 나머지 기준을 차례차례 적용하였습니다.
# 출력 결과는 문제 조건에 따라 근속 연수 기준으로 내림차순 정렬하였습니다. 

-- 문제 7: [중급-상급] 사원 위치 정보 뷰 생성 및 활용
-- 7-1: 먼저 아래와 같이 사원의 근무 위치 정보를 포함하는 뷰(employee_location_details)를 생성하시오.
-- 뷰는 employees, departments, locations, countries, regions, jobs 테이블을 JOIN하여 생성하시오.

-- CREATE VIEW는 새로운 뷰를 생성, 기존 VIEW가 존재하면 에러 발생
-- CREATE OR REPLACE VIEW는 뷰가 있으면 덮어쓰기, 없으면 새로 생성
CREATE OR REPLACE VIEW employee_location_details AS
    SELECT 
        e.employee_id,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        e.salary,
        j.job_title,
        d.department_name,
        l.city,
        country_name,
        r.region_name
    FROM
        employees e
            JOIN
        jobs j ON e.job_id = j.job_id
            JOIN
        departments d ON d.department_id = e.department_id
            JOIN
        locations l ON l.location_id = d.location_id
            JOIN
        countries c ON c.country_id = l.country_id
            JOIN
        regions r ON r.region_id = c.region_id;
# EER 다이어그램을 적극 활용하여 6개의 테이블의 참조 관계를 파악하여 조인하였습니다.
# 조인된 테이블들에서 employee_location_details 뷰를 덮어쓰기 또는 새로 생성하여,
# 사원 아이디, 사원 성명, 급여, 직무의 제목, 부서명, 도시, 국가명, 지역 이름을 조회하는 뷰를 작성하였습니다.


-- 7-2: [초급] 위에서 생성한 뷰를 사용하여 'Americas' 지역(region_name)에 근무하는 
-- 사원 수를 조회하시오.

-- 답안:
SELECT 
    region_name, COUNT(employee_id) AS employee_count
FROM
    employee_location_details
WHERE
    region_name = 'Americas';
# (문제 해결 과정)
# 뷰 테이블에서 region_name이 Americas인 지역 이름과, 그 지역에서 근무하는 사원 수의 합계를 조회했습니다.


-- 7-3: [중초급] 위에서 생성한 뷰를 사용하여 국가별, 부서별 평균 급여를 조회하시오.
-- 결과는 국가명을 기준으로 오름차순 정렬하고, 각 국가 내에서는 평균 급여를 기준으로 내림차순 정렬하시오.

-- 답안:
SELECT 
    country_name, department_name, AVG(salary) AS avg_salary
FROM
    employee_location_details
GROUP BY country_name , department_name
ORDER BY country_name ASC , AVG(salary) DESC;
# (문제 해결 과정)
# 뷰 테이블에서 국가별, 부서별 평균 급여를 조회하고, 국가명으로 오름차순 정렬 후 평균 급여로 내림차순 정렬했습니다.

-- 7-4: [중급] 위에서 생성한 뷰를 사용하여 각 지역(region_name)별로 가장 높은 급여를 받는 
-- 사원의 정보(이름, 직무, 부서, 급여)를 조회하시오.

-- 답안:
SELECT 
    region_name,
    employee_name,
    job_title,
    department_name,
    salary
FROM
    employee_location_details
WHERE
    (region_name , salary) IN (SELECT 
            region_name, MAX(salary)
        FROM
            employee_location_details
        GROUP BY region_name);
# (문제 해결 과정)
# 먼저, 지역별로 가장 높은 급여를 받은 사원을 조회하는 쿼리를 작성하여 1차적 정보를 확인하였습니다. 
# 이를 다중열 서브쿼리로 이용하는 방법을 고려하였고, 서브쿼리가 반환하는 열의 수와 데이터 타입이
# 메인 쿼리와 각각 동일하고 호환이 가능하다는 조건을 충족하는 것을 확인 후 진행하였습니다.   
# 최종적으로, 뷰 테이블에서 지역별 가장 높은 급여를 받는 사원의 이름, 직무, 부서명, 급여를 조회하였습니다.