extends Node2D

var circle
var hcircle
var cross
var timer
var timer_counter: int = 0
var sum: int
var rng = RandomNumberGenerator.new()
var pressed_since: int

var ls_x
var ls_y

# Called when the node enters the scene tree for the first time.
func _ready():
#	circle = Circle.new(200, 150, 50)
#	add_child(circle)
#	hcircle = HyperCircle.new(600, 450, 50, 10, 120)
#	add_child(hcircle)
	cross = Cross.new()
	add_child(cross)
	
#	21. Using only a for loop and one declaration of the after function inside
#	that loop, print 10 random numbers to the screen with an interval of 0.5 
#	seconds between each print.
#	timer = Timer.new()
#	timer.set_autostart(true)
#	timer.set_wait_time(0.5)
#	timer.timeout.connect(_on_timer_timeout)
#	add_child(timer)
	
#	15. Suppose we have the following code:		
#	Will anything happen when mouse1 is pressed?
#	What about when it is released? And held down?
#	AL:In Godot its more flexibel, you can check with
#		Input.is_action_pressed 		-> every Frame
#		Input.is_action_just_pressed	-> just once (pressed)
#		Input.is_action_just_released	-> just once (released)
	var mouse = InputEventMouseButton.new()
	mouse.button_index = MOUSE_BUTTON_LEFT
	InputMap.add_action("mouse1")
	InputMap.action_add_event("mouse1", mouse)
	
#	16. Bind the keypad + key to an action named add, then increment the value
#	of a variable named sum (which starts at 0) by 1 every 0.25 seconds when the
#	add action key is held down. Print the value of sum to the console every time
#	it is incremented.
	var key = InputEventKey.new()
	key.physical_keycode = KEY_KP_ADD
	InputMap.add_action("add")
	InputMap.action_add_event("add", key)
	
#	18. If you have a gamepad, bind its DPAD buttons(fup, fdown...) 
#	to actions up, left, right and down and then print the name of 
#	the action to the console once each button is pressed.
	var dpad_up = InputEventJoypadButton.new()
	dpad_up.button_index = JOY_BUTTON_DPAD_UP
	InputMap.add_action("dpad_up")
	InputMap.action_add_event("dpad_up", dpad_up)
	var dpad_down = InputEventJoypadButton.new()
	dpad_down.button_index = JOY_BUTTON_DPAD_DOWN
	InputMap.add_action("dpad_down")
	InputMap.action_add_event("dpad_down", dpad_down)
	
#	L1 and L2 are just JoypadButtons
	var l1 = InputEventJoypadButton.new()
	l1.button_index = JOY_BUTTON_LEFT_SHOULDER
	InputMap.add_action("l1")
	InputMap.action_add_event("l1", l1)
	var l2 = InputEventJoypadButton.new()
	l2.button_index = JOY_BUTTON_RIGHT_SHOULDER
	InputMap.add_action("l2")
	InputMap.action_add_event("l2", l2)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("add"):
		pressed_since = 0
	if Input.is_action_pressed("add"):
		if pressed_since == 0:
			pressed_since = Time.get_ticks_msec()
		elif (Time.get_ticks_msec() - pressed_since)/1000.0 > 0.25:
			pressed_since = Time.get_ticks_msec()
			add()
			print(Time.get_ticks_msec()/1000.0)
	if Input.is_action_just_pressed("dpad_up"):
		print("Dpad: up")
	if Input.is_action_just_pressed("dpad_down"):
		print("Dpad: down")
	if Input.is_action_just_pressed("mouse1"):
		mouse_click()
	if Input.is_action_just_pressed("l1"):
		print("l1: pressed")
	if Input.is_action_just_pressed("l2"):
		print("l2: pressed")
	
#	19. If you have a gamepad, bind one of its trigger buttons (l2, r2)
#	to an action named trigger. Trigger buttons return a value from 0 to 1 
#	instead of a boolean saying if its pressed or not. How would you get this value?
#	print("lt: " + str(Input.get_joy_axis(0, JOY_AXIS_TRIGGER_LEFT)))
#	print("rt: " + str(Input.get_joy_axis(0, JOY_AXIS_TRIGGER_RIGHT)))
#	print("---------------")

#	20. Repeat the same as the previous exercise but for the left and 
#	right stick's horizontal and vertical position.
#	print("ls_x: " + str(Input.get_joy_axis(0, JOY_AXIS_LEFT_X)))
#	print("ls_y: " + str(Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)))
#	print("---------------")

func _draw():
	pass

func _on_timer_timeout():
	if timer_counter == 9:
		timer.queue_free()
	print(rng.randi_range(1, 100))
	timer_counter += 1

func mouse_click():
	print(
		"x: " + str(rng.randi_range(0, 800)) +
		"y: " + str(rng.randi_range(0, 600))
	)

func add():
	sum += 1
	print("Sum: " + str(sum))
