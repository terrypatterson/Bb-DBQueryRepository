select course_id as "Course ID",
	   course_name as "Course Name",
	   crs_creation as "Course Creation Date",
	   user_id as "Instructor User ID",
	   first_instructor as "Instructor / Owner",
	   email as "Email",
	   crs_enroll as "Instructor's Enrollment Date",
	   crs_avail as "Is Course Available",
	   data_src as "Associated Data Source Key",
	   seqnum
from (select row_number() over (partition by cu.crsmain_pk1 order by cu.enrollment_date) as seqnum,
		       cm.course_id as course_id,
			   cm.course_name as course_name,
			   cm.dtcreated as crs_creation,
			   u.user_id as user_id,
			   string_agg(distinct u.firstname||' '||u.lastname, ', ') as first_instructor,
			   u.email as email,
			   cu.enrollment_date as crs_enroll,
			   cm.available_ind as crs_avail,
			   ds.batch_uid as data_src 
		from course_main cm
			join course_users cu
			 on cm.pk1 = cu.crsmain_pk1
			join users u
			 on cu.users_pk1 = u.pk1
			join data_source ds
			 on cm.data_src_pk1 = ds.pk1
		where u.row_status = '0'
		    and cu.role = 'P'
		    and cu.row_status = '0'
		    and cu.available_ind = 'Y'
		    and cm.course_id not like '%XLM%'
		    and cm.data_src_pk1 in ('364','351','377','410','435','461','2')
		group by cm.course_id,
			   cm.course_name,
			   cm.dtcreated,
			   u.user_id,
			   u.email,
			   cu.enrollment_date,
			   cm.available_ind,
			   ds.batch_uid,
			   cu.crsmain_pk1) AS course_owner
where seqnum = '1'
order by course_id, crs_enroll