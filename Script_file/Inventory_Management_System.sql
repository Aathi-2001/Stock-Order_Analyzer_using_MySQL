Create database Order_Stock_Analysis;
use Order_Stock_Analysis;
select * from order_status;

-- calculate the Stock count & work order count based on order_id 

create table order_type_count
(select *, 
SUM(Case when order_type = 'STOCK' THEN 1 ELSE 0 END) OVER (PARTITION BY order_id) as Stock_Count,
SUM(Case when order_type = 'Work_order' THEN 1 ELSE 0 END) OVER (PARTITION BY order_id) as Work_Order_Count
from order_status); 

-- Calculate Work_order_pending Status :

Alter table order_type_count add Work_order_pending int;
update order_type_count set Work_order_pending = (Stock_Count - Work_Order_Count);
select * from order_type_count;

-- close the work_order
-- (I) creat a new field "work_order_closed_or_not"
-- (II) Work_order_pending status < 0 Then update order_closed other wise Order_pending

Create table Order_pending_status 
(Select *,
case 
when Work_order_pending < 0 then 'Order_pending'
else 'Order_closed'
END AS work_order_closed_or_not
FROM order_type_count);
select * from Order_pending_status;
-- --------------------------------------------
-- We need to create a second table while using  join (table name : order_supplier_report) 
 
Create table order_supplier_report
(select d.*, o.Trans, o.Negative, o.Order_Type, o.Assembly_Supplier, o.Ref, o.Order_id, o.`Description` 
from date_wise_report d 
JOIN
order_status o on d.sale_id = o.sale_id);
Select * from order_supplier_report;

-- Date wise total quantity sold and orders taken:  

select sale_date, sum(qty) as qty_sold, count(order_id) as Total_orders
from Order_supplier_report
group by sale_date;

-- You can split the supplier_name while using comma delimiter:

Select *, substring_index(Buyer_name,",",-1) as First_name, substring_index(Buyer_name,",",1) as Last_name
from Order_supplier_report;

-- Finally, store all the reports as a procedure:

DELIMITER //
Create Procedure Stock_Analysis_Report()
BEGIN
-- Ouput 1:
select * from Order_pending_status;
-- Output 2:
select * from order_supplier_report;
-- Output 3:
select sale_date, sum(qty) as qty_sold, count(order_id) as Total_orders
from Order_supplier_report
group by sale_date;
-- Output 4:
Select *, substring_index(Buyer_name,",",-1) as First_name, substring_index(Buyer_name,",",1) as Last_name
from order_supplier_report;
END //
DELIMITER ;
call Stock_Analysis_Report();
