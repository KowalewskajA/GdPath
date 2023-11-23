class_name CircleScene extends Node2D

var timer: Timer
var rng = RandomNumberGenerator.new()
var current_scene
var circles = Array()
var circle

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		circle = Circle.new(rng.randi_range(0, 800), rng.randi_range(0, 600), rng.randi_range(10, 50))
		circles.append(circle)
		add_child(circle)	
	timer = Timer.new()
	timer.set_autostart(true)
	timer.set_wait_time(0.5)
	timer.timeout.connect(_destroy_circle)
	add_child(timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _destroy_circle():
	circle = circles.pop_front()
	remove_child(circle)
	circle.queue_free()
	if circles.size() == 0:
		timer.stop()
