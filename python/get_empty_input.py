# empty input catch
def get_empty_input(prompt):
	while True:
		user_input = input(prompt)
		#check if empty
		if user_input.strip():
			return user_input
		else:
			print("You entered nothing, please try again.")
