select didss.pk1 as "Data Integration PK1",
       di.name as "Data Integration",
       didss.completed_count as "Records Processed",
       didss.first_entry_dt as "Date and Time Start Time",
       DATE_PART('hour', last_entry_dt - first_entry_dt) * 60 + DATE_PART('minute', last_entry_dt - first_entry_dt) as "Runtime in Minutes",
       didss.completed_count / (DATE_PART('hour', last_entry_dt - first_entry_dt) * 60 + DATE_PART('minute', last_entry_dt - first_entry_dt)) as "Processing Rate"
from data_intgr_data_set_status didss
	join data_intgr di
	 on didss.data_intgr_pk1 = di.pk1
where --didss.last_entry_dt < '2021-05-31' (In case you want to examine specific dates)
  --and didss.last_entry_dt > '2021-01-05' (In case you want to examine specific dates)
  --and 
  DATE_PART('hour', last_entry_dt - first_entry_dt) * 60 + DATE_PART('minute', last_entry_dt - first_entry_dt) != '0' and
  di.name in ('Integration_Name_Here','')
  order by didss.first_entry_dt desc;
