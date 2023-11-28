class_name Stage extends Node2D

var timer: Timer
var current_scene
var area:Area

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
	timer.set_wait_time(2)
	timer.timeout.connect(_create_circle)
	add_child(timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var found = area.get_gameobjects(
		func(obj): 
			if obj is Circle:
				return true
			else:
				return false
	)
	print(found.size())

func _create_circle():
	area.add_gameobject(Circle, randi_range(0, 800), randi_range(0, 600), {radius = randi_range(50, 100)})
	#area.add_gameobject(ChangingCircle, randi_range(0, 800), randi_range(0, 600), {radius = randi_range(50, 100)})
