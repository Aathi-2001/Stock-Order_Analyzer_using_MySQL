### *Stock-Order Analyzer (Inventory Management System) using MySQL*

---

#### *Summary*  
I developed a MySQL-based inventory management system titled *"Stock-Order Analyzer"*, designed to provide comprehensive insights into stock and order tracking. The system integrates multiple datasets, applies automated calculations, and uses advanced logical functions to manage inventory, track pending work orders, and generate detailed supplier reports. It is equipped with procedures for efficient data retrieval and export functionalities.

---

#### *Datasets*  
1. **Order Status**: Contains information about order IDs, stock counts, and work orders.  
2. **Date_wise_Supplier**: Includes supplier details and date-specific data for orders.  

---

#### *Modules*  

1. **Stock and Work Order Calculation**  
   - **Objective**: Calculate stock counts and work order counts based on the `Order_ID` field.  
   - **Logic**: Extract values from the `Order_Type` field to identify stock and work orders.  

2. **Work Order Pending Status**  
   - **Calculation**:  
     - `Work_order_pending_status = stock_count - work_order_count`.  
   - **Post-Calculation Actions**:  
     - Create a new field named `work_order_closed_or_not`.  
     - Apply conditions:  
       - If `Work_order_pending_status < 0`:  
         - Update `work_order_pending_status` to 0.  
         - Mark the order as **Order_Closed**.  
       - Otherwise, mark it as **No_Work_Order**.  
   - **Output Table**: Save results in a new table named `Order_pending_status`.  

3. **Supplier Report Creation**  
   - **Joining Tables**:  
     - Join `order_status` and `date_wise_supplier` tables to form a consolidated table named `order_supplier_report`.  
   - **Report Generation**:  
     - **Date-Wise Reports**: Include `Date_wise Quantity` and `Order_ID count`.  
     - **Supplier Name Splitting**: Split supplier names into `First_Name` and `Last_Name` using a comma delimiter (e.g., "Kumar N, Mr.Vinay" → `Last_Name: Kumar N`, `First_Name: Mr.Vinay`).  

4. **Final Outputs**  
   - **Reports and Tables**: Store all generated tables and reports using stored procedures for streamlined data retrieval.  
   - **Data Export**: Export all reports for documentation and future reference.  

---

#### *Expected Outputs*  
1. **Unified Order Status Table**: A table consolidating stock counts, work order statuses, and pending statuses.  
2. **Supplier Report**: Detailed insights into date-wise quantities, order counts, and supplier details with split names.  
3. **Work Order Analysis**: Status updates for closed or pending work orders based on logical conditions.  
4. **Exportable Reports**: All tables and reports stored and exported efficiently.  

---

#### *Key Features and Benefits*  
- Automates inventory management and order tracking through dynamic calculations and triggers.  
- Provides actionable insights for pending work orders and supplier performance.  
- Enhances data clarity with name splitting and joins for comprehensive reporting.  
- Facilitates efficient data retrieval and storage using MySQL procedures.  

---

#### *Tools and Techniques Used*  
- **MySQL**: For database design, table creation, joins, and queries.  
- **Stored Procedures**: For efficient handling and storage of reports.  
- **Advanced SQL Functions**: To implement logical conditions, name splitting, and data transformation.  
- **Export Functionalities**: To save and retrieve reports for documentation.  

This project demonstrates the effective use of MySQL for managing inventory systems and generating actionable insights to enhance decision-making and streamline operations. 
