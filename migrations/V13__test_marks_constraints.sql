/*Add constraints for test marks*/
ALTER TABLE public.test_marks ADD CONSTRAINT fk_course_test
FOREIGN KEY (module,course) REFERENCES public.course (module, course) MATCH SIMPLE
ON UPDATE NO ACTION 
ON DELETE NO ACTION;