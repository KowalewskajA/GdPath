class_name CircleScene extends Node2D

var timer: Timer
var current_scene
var circles = Array()
var circle

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		circle = Circle.new(self, randi_range(0, 800), randi_range(0, 600), {radius = randi_range(10, 50)})
		circles.append(circle)
		add_child(circle)
	timer = Timer.new()
	timer.set_autostart(true)
	timer.set_wait_time(0.5)
	timer.timeout.connect(_destroy_circle)
	add_child(timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for index in circles.size():
		if is_instance_valid(circles[index-1]) == true:
			circle = circles[index-1]
			if circle.dead == true:
				#print("Dead found, circles.size()=" + str(circles.size()))
				circles.pop_at(index-1)
				remove_child(circle)
				circle.queue_free()

func _destroy_circle():
	circle = circles.pick_random()
	if is_instance_valid(circle) == true:
		circle.set("dead", true)
	if circles.size() == 0:
		timer.stop()
