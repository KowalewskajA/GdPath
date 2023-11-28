class_name Stage extends Node2D

var timer: Timer
var current_scene
var area:Area
var growing:bool = true

#48. Create a Stage room that has an Area in it. Then create a Circle object that inherits
#from GameObject and add an instance of that object to the Stage room at a random position
#every 2 seconds. The Circle instance should kill itself after a random amount of time 
#between 2 and 4 seconds.

# Called when the node enters the scene tree for the first time.
func _ready():
	area = Area.new()
	add_child(area)
	timer = Timer.new()
	timer.set_autostart(true)
	
#	59. Create a class named Rectangle that draws a rectangle with some width and height
#	at the position it was created. Create 10 instances of this class at random positions 
#	of the screen and with random widths and heights. When the d key is pressed a random instance
#	should be deleted from the environment. When the number of instances left reaches 0, another 
#	10 new instances should be created at random positions of the screen and with random widths and heights.
	_create_rectangles(10)
	
#	60. Create a class named Circle that draws a circle with some radius at the position it 
#	was created. Create 10 instances of this class at random positions of the screen with random
#	radius, and also with an interval of 0.25 seconds between the creation of each instance. 
#	After all instances are created (so after 2.5 seconds) start deleting once random instance
#	every [0.5, 1] second. After all instances are deleted, repeat the entire process of recreation
#	of the 10 instances and their eventual deletion. This process should repeat forever.
	
#	timer.set_wait_time(0.25)
#	timer.timeout.connect(_control_circles)
	add_child(timer)

	var key = InputEventKey.new()
	key.physical_keycode = KEY_D
	InputMap.add_action("destroy")
	InputMap.action_add_event("destroy", key)

#	area.add_gameobject(
#		Rectangle, 0, 1, 
#		{width = 800, height = 1, color=Color.RED}
#	)
#	area.add_gameobject(
#		Rectangle, 0, 100, 
#		{width = 800, height = 1, color=Color.REBECCA_PURPLE}
#	)
#	area.add_gameobject(
#		Rectangle, 0, 200, 
#		{width = 800, height = 1, color=Color.BLUE}
#	)
#	area.add_gameobject(
#		Rectangle, 350, 250, 
#		{width = 100, height = 100, color=Color.CADET_BLUE}
#	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var number_rectangles = area.get_gameobjects(_get_rectangles).size()
	if Input.is_action_just_pressed("destroy") and number_rectangles > 0:
		_destroy_rectangle()
	if number_rectangles == 0:
		_create_rectangles(10)
#	print("Window: " + str(get_viewport().get_visible_rect().size))
#	print("#R: " + str(number_rectangles))
#	var i = 1
#	for r in area.get_gameobjects(_get_rectangles):
#		print("#" + str(i) + ": x=" + str(r.position.x) + " y=" + str(r.position.y) + " w=" + str(r.width) + " h=" + str(r.height))
#		i +=1
#	print(str(area.query_circle_area(400, 300, 200, [Rectangle]).size()))
#	print(str(area.get_closest_gameobject(400, 300, 200, [Rectangle])))
	pass

func _get_rectangles(obj):
	if obj is Rectangle:
		return true
	else:
		return false

func _create_rectangle():
	area.add_gameobject(
		Rectangle, randi_range(0, 800), randi_range(0, 600), 
		{width = 50, height = 50, color=Color.WHITE}
	)

func _create_rectangles(number:int):
	for i in range(number):
		_create_rectangle()

func _destroy_rectangle():
	area.destroy_random_gameobject(_get_rectangles)

func _get_circles(obj):
	if obj is Circle:
		return true
	else:
		return false

func _control_circles():
	var number_circles = area.get_gameobjects(_get_circles).size()
	
	if  number_circles == 10 and growing:
		growing = !growing
	if number_circles == 0 and !growing:
		growing = !growing
		timer.set_wait_time(0.25)
		
	if growing:
		_create_circle()
	else:
		_destroy_circle()
		timer.set_wait_time(randf_range(0.5, 1))

func _create_circle():
	area.add_gameobject(Circle, randi_range(0, 800), randi_range(0, 600), {radius = randi_range(50, 100)})

func _destroy_circle():
	area.destroy_random_gameobject(_get_circles)
