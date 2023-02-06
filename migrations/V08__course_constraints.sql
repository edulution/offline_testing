/*Add constraints for course table*/
ALTER TABLE public.course
ADD CONSTRAINT uk_course_sort UNIQUE (module,course,sort_order) ;