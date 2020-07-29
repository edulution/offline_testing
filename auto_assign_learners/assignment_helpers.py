from kolibri.core.auth.models import FacilityUser, Classroom, LearnerGroup, Membership


def get_all_users():
	"""Function to get all of the users on the device that are not admins or coaches
		Args:
			None
		Returns:
			A django rawquery object of FacilityUsers
	"""
	# use raw SQL to get all the users that are not admin/coach
	all_users_query = """"select * from kolibriauth_facilityuser 
		where id not in 
		(select user_id from kolibriauth_role where kind in ('admin','coach'))"""
	all_users = FacilityUser.objects.raw(all_users_query)

	# return the list
	return all_users


def is_admin(user):
	"""Tells us whether a user is an admin or coach
		Args:
			user (FacilityUser): A reference to the FacilityUser object to interrogate
		Returns:
			Boolean: True if the user is an admin or coach. False if not
	"""
	# Get a list of all of the role objects of kind admin or coach
	admin_roles = Role.objects.filter(kind__in=["admin","coach"])

	# Get the user_ids associated with the roles
	admin_role_ids = [role.user_id for role in admin_roles]

	# check if the user passed in appears in the list above
	# return the boolean result
	return user.id in admin_role_ids


def get_user_info(username, facility):
	# Get a reference to the user that has logged in
	user_logged_in = FacilityUser.objects.get(username = username, facility_id = facility)

	# Get a reference to the facility the user belongs to
	facility_for_user = Facility.objects.get(id = facility)
	
	print ("User logged in is: {}. Is admin/coach?: {}".format(user_logged_in, is_admin(user_logged_in)))

	if is_admin(user_logged_in):
		return None
	else:
		print('user is not admin')
		return user_logged_in, facility_for_user


def enroll_into_class(user, classroomname, facilityname):
	""" 
	Enroll a user into a specified classroom in a facility
		Args:
			user (FacilityUser): The FacilityUser to be enrolled
			classroomname (String): The name of the Classroom
			facilityname (String): The name of the Facility

		Returns:
			None
	"""
	facility_for_user = Facility.objects.get(id = user.facility_id)

	class_for_user = Classroom.objects.all().get(name = classroomname, parent_id = facility_for_user.id)


	if Membership.objects.filter(user = user).exists():
		print ("Found memberships for user: {}".format(user))
		Membership.objects.filter(user = user).delete()
		print ("Deleted memberships for user: {}".format(user))


		print("Creating membership in class: {} for user: {}".format(class_for_user, user))
		Membership.objects.create(user=user, collection=class_for_user)

	else:
		print('No memberships found for user')
