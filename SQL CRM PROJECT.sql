
--------- Opportunity Visuals -----------
-- Expected Amount
create view Expected_amount As
select sum(`Expected Amount`) as Total_Expected_Amount  from opportunity_table;
select *from expected_amount;

-- Total_Open _Activity--
create view Total_Open_Activity as
select count(`Has Open Activity`) as Total_Open_Activity from opportunity_table where `Has Open Activity`= "True";
select*from Total_Open_Activity;

-- Conversion rate---
create view Conversion_Rate as
select(select count(Stage) from opportunity_table where stage="Closed Won")/ count(`Opportunity ID`)*100 as Conversion_Rate from opportunity_table;
select*from conversion_rate;

--- Loss rate --
create view Loss_Rate as
select(select count(Stage) from opportunity_table where stage="Closed Lost")/ count(`Opportunity ID`)*100 as Loss_Rate from opportunity_table;
select * from Loss_Rate;

-- Expected Vs Forecast --
create View Expexted_vs_Forecasted as
SELECT YEAR(`Created Date`) AS year,
(SELECT SUM(`Expected Amount`) 
FROM opportunity_table 
WHERE `Forecast Q Commit` = "True") AS total_forecast_commit,
SUM(`Expected Amount`) AS yearly_expected_amount
FROM opportunity_table
GROUP BY YEAR(`Created Date`);

-- Expected Amount by Opportunity Type
create view Expected_Amount_by_Opportunity_Type as select Stage, sum(`Expected Amount`) Expected_Amount from Opportunity_table group by stage ;
select*from Expected_Amount_by_Opportunity_Type;

-- Opportunities by industries --
create view Opportunities_by_Industriesselect as 
select Industry,count(`Opportunity Id`)as count from opportunity_table group by Industry;

-- Closed Won vs total Closed --
create view Closed_Won_vs_total_Closed as
 SELECT COUNT(CASE WHEN Stage = "Closed Won" THEN 1 END) AS Total_Closed_Won_Count,
COUNT(CASE WHEN Stage IN ("Closed Won", "Closed Lost") THEN 1 END) AS Total_Closed_Count
FROM opportunity_table;

-- Closed Won Vs Total Opportunities
create view Closed_Won_Vs_Total_Opportunities as
 select count(case when stage ="Closed Won" then 1 end) as Total_Closed_Won_Count, count(`Opportunity ID`) as Total_Opportunities from opportunity_table;


--- Lead Visuals ----
-- Total Leads--
select* from lead_1;
create view Total_Leads as 
select count(`lead Id`) as Total_Leads from lead_1;

-- Expected amount from converted ledas ---
Create view Expected_amount_from_converted_leads as
SELECT SUM(o.`Expected Amount`) AS TotalExpectedAmount
FROM opportunity_table o
JOIN lead_1 l 
ON o.`Opportunity ID` = l.`Converted Opportunity ID`;

select*from lead_1;
-- lead Conversion Rate
create view Lead_Conversion_Rate as 
select count(case when `# Converted Accounts`=1 then 1 end) / count(`Lead ID`) *100 as Lead_Conversion_Rate from lead_1;
select*from lead_conversion_rate;


-- Converted_accounts
create view Converted_Accounts as 
select count(case when `# Converted Accounts`=1 then 1 end) as Converted_Accounts from lead_1;
select*from Converted_Accounts;

--- Converted Opportunity --
create view Converted_Opportunities as 
select count(case when `# Converted Opportunities`= 1 then 1 end) as Converted_Opportunities from lead_1;

select*from Converted_Opportunities;

select*from lead_1;
--- Lead By Source--
create view Lead_By_source as 
select `Lead Source`, count(`Lead ID`) as Lead_Count from lead_1 group by `Lead Source`;

select*from lead_by_source;

-- Lead By Industry --
create view Lead_By_Industry as 
select Industry, count(`Lead ID`) as Lead_Count from lead_1 group by Industry;
select*from Lead_By_Industry;

---- Lead By Stage -----
create view Lead_By_Stage as 
select Status as stage, count(`Lead ID`) as Lead_Count from lead_1 group by Status;

select*from Lead_By_Stage;











