print ("My first Python code")
print ("Hmmmm, this is too easy")
print()

a="2"
b="3"
print (a + b)
print()

a=4
b=7
print (b - a)
print()

# Casting a variable
a="5"
b=7
print ("""A was designated as a string so, Errored here on 'print (a + b)'
	Traceback (most recent call last):
  File \"/home/msifland/scripts/python/first_script.py\", line 19, in <module>
    print (a + b)
           ~~^~~
TypeError: can only concatenate str (not \"int\") to str\")""")

print ("Not error here on 'print (int(a) + b)'")
print(int(a) + b)
print()

def my_function():
	print ("my")
	print ("functions")

def my_function2(a, b):
	print (a * b)

my_function()
print()
my_function2(4, 5)


#global vars have to be defined outside of functions
def my_function3():
	a = 10
my_function3()
print (a) #this will print a varialbe from above the function, or error out if it hasnt' been define earlier

a=10
def my_function4():
	print (a)

my_function4()
print()
print()

# empty input catch
def get_empty_input(prompt):
	while True:
		user_input = input(prompt)
		#check if empty
		if user_input.strip():
			return user_input
		else:
			print("You entered nothing, please try again.")

print()
def hello_name():
	name = get_empty_input("What is your name? ")
	print("Hello " + name + ", nice to virtually meet you!")

hello_name()
print()

def if_stat():
	num_str = get_empty_input("Enter a number: ")
	num_int = int(num_str)
	#or num = int(input("Enter a number: "))
	if num_int >= 5: print("greater than or equal to 5")
	elif num_int < 5:
		print("less than 5")
	elif num_str == "":
		print("You entered nothing")
	else:
		print()

if_stat() 
