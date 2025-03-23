USE [bank loan db]
GO


select * from bank_loan_data

select count(id) as total_loan_applications from bank_loan_data

select count(id) as mtd_total_loan_applications from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

select count(id) as mtd_total_loan_applications from bank_loan_data
where
month(issue_date) = (select month(max(issue_date)) from bank_loan_data) and
year(issue_date) = (select year(max(issue_date)) from bank_loan_data)

select distinct issue_date from bank_loan_data
order by issue_date desc

select count(id) as pmtd_total_loan_applications from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021

select count(id) as pmtd_total_loan_applications from bank_loan_data
where
      month(issue_date) = 
	  (select case
      when month(max(issue_date)) = 1 then 12
	  else month(max(issue_date)) - 1
	  end
	  from bank_loan_data)
	  and
	  year(issue_date) =
	  (select case
	  when month(max(issue_date)) = 1 then year(max(issue_date)) - 1
	  else year(max(issue_date))
	  end
	  from bank_loan_data)

select * from bank_loan_data

select sum(loan_amount) as total_funded_amount from bank_loan_data

select sum(loan_amount) as mtd_total_funded_amount from bank_loan_data
where month(issue_date) = (select month(max(issue_date)) from bank_loan_data)
and year(issue_date) = (select year(max(issue_date)) from bank_loan_data)

select sum(loan_amount) as pmtd_total_funded_amount from bank_loan_data
where month(issue_date) = 
      (select case
	  when month(max(issue_date)) = 1 then 12
	  else month(max(issue_date)) - 1
	  end
	  from bank_loan_data)
	  and
	  year(issue_date) = 
	  (select case
	  when month(max(issue_date)) = 1 then year(max(issue_date)) - 1
	  else year(max(issue_date))
	  end
	  from bank_loan_data)

select sum(total_payment) as total_recieved_amount from bank_loan_data

select sum(total_payment) as mtd_total_received_amount from bank_loan_data
 where month(issue_date) = (select month(max(issue_date)) from bank_loan_data)
 and year(issue_date) = (select year(max(issue_date)) from bank_loan_data)

select sum(total_payment) as pmtd_total_received_amount from bank_loan_data
where month(issue_date) = 
      (select case
	  when month(max(issue_date)) = 1 then 12
	  else month(max(issue_date)) - 1
	  end
	  from bank_loan_data)
	  and
	  year(issue_date) = 
	  (select case
	  when month(max(issue_date)) = 1 then year(max(issue_date)) - 1
	  else year(max(issue_date))
	  end
	  from bank_loan_data)



select round(avg(int_rate)*100,2) as avg_interest_rate from bank_loan_data

select round(avg(int_rate)*100,2) as mtd_avg_interest_rate from bank_loan_data
 where month(issue_date) = (select month(max(issue_date)) from bank_loan_data)
 and year(issue_date) = (select year(max(issue_date)) from bank_loan_data)


select round(avg(int_rate)*100,2) as avg_interest_rate from bank_loan_data
where month(issue_date) = 
      (select case
	  when month(max(issue_date)) = 1 then 12
	  else month(max(issue_date)) - 1
	  end
	  from bank_loan_data)
	  and
	  year(issue_date) = 
	  (select case
	  when month(max(issue_date)) = 1 then year(max(issue_date)) - 1
	  else year(max(issue_date))
	  end
	  from bank_loan_data)

select round(avg(dti)*100,2) as avg_dti from bank_loan_data

select round(avg(dti)*100,2) as mtd_avg_dti from bank_loan_data
where month(issue_date) = (select month(max(issue_date)) from bank_loan_data)
and year(issue_date) = (select year(max(issue_date)) from bank_loan_data)

select round(avg(dti)*100,2) as pmtd_avg_dti from bank_loan_data
where month(issue_date) = 
      (select case
	  when month(max(issue_date)) = 1 then 12
	  else month(max(issue_date)) - 1
	  end
	  from bank_loan_data)
	  and
	  year(issue_date) = 
	  (select case
	  when month(max(issue_date)) = 1 then year(max(issue_date)) - 1
	  else year(max(issue_date))
	  end
	  from bank_loan_data)

select distinct loan_status from bank_loan_data

select (count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end))*100.0
/ count(id)
as good_loan_percentage
from bank_loan_data

select count(id) as good_loan_applications from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'


select sum(loan_amount) as good_loan_funded_amount from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'

select sum(total_payment) as good_loan_recieved_amount from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'


select (count(case when loan_status = 'Charged Off' then id end))*100.0
/count(id)
as bad_loan_percentage
from bank_loan_data

select count(id) as bad_loan_applications from bank_loan_data
where loan_status = 'Charged Off'

select sum(loan_amount) as bad_loan_funded_amount from bank_loan_data
where loan_status = 'Charged Off'

select sum(total_payment) as bad_loan_received_amount from bank_loan_data
where loan_status = 'Charged Off'

select
    loan_status,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount,
	avg(int_rate) as avg_interest_rate,
	avg(dti) as avg_dti
from bank_loan_data
group by loan_status

select loan_status,
       sum(loan_amount) as mtd_total_funded_amount,
	   sum(total_payment) as mtd_total_received_amount

	   from bank_loan_data
	   where month(issue_date) = (select month(max(issue_date)) from bank_loan_data)
	   and year(issue_date) = (select year(max(issue_date)) from bank_loan_data)

	   group by loan_status

select * from bank_loan_data

select 
    DATENAME(month,issue_date) as month_name,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
	from bank_loan_data
	group by datename(month,issue_date), month(issue_date)
	order by month(issue_date)

select 
    address_state,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
	from bank_loan_data
	group by address_state
	order by address_state

select 
    term,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
	from bank_loan_data
	group by term
	order by term

select * from bank_loan_data

select 
    emp_length,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
	from bank_loan_data
	group by emp_length
	order by emp_length

select 
    purpose,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
	from bank_loan_data
	group by purpose
	order by purpose

select 
    home_ownership,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_received_amount
	from bank_loan_data
	group by home_ownership
	order by home_ownership

select * from bank_loan_data







