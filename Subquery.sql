-- Single Row SubQuery:
SELECT * from employees where department_id in 
(SELECT department_id from departments where department_name= 'Human Resources');

-- Multiple Row SubQuery:
SELECT * from employees where department_id in 
(SELECT department_id from departments where department_name in ('Human Resources','Finance'));

-- Correlated Subquery:
SELECT * from employees where salary>(SELECT avg(salary) from employees); -- But other depts having low salary is not considered . So,
SELECT * from employees em where salary>(SELECT avg(salary) from employees ei where ei.department_id = em.department_id );

-- Subquery with EXISTS or NOT EXISTS: -- Just results out like it exists or not and works only with correlated Subquery
SELECT * from departments d where exists (SELECT department_id from employees e WHERE d.department_id=e.department_id);
SELECT * from departments d where not exists (SELECT department_id from employees e WHERE d.department_id=e.department_id);

-- Subquery with Aggregate
select department_id,avg(salary) from employees
group by department_id
having avg(salary) > (select avg(salary) from employees where department_id=70);

-- Subquries with joins
SELECT * from employees where department_id in 
(SELECT department_id from departments where department_name= 'Human Resources');

SELECT e.*,d.department_name from employees e
inner join departments d on e.department_id=d.department_id
where e.department_id in 
(SELECT department_id from departments where department_name= 'Human Resources');

-- Nested SubQuery:
SELECT * from employees where department_id in 
(SELECT department_id from departments where location_id in (SELECT location_id,city from locations where city='Singapore'));

