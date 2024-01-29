select cm.course_id, cm.course_name, cz.size_total
from course_main cm
	join course_size cz
	 on cm.pk1 = cz.crsmain_pk1
where cz.size_total > '1000000000'
and cm.course_id like '223F%'
order by cz.size_coursefiles DESC