extends Node2D

#const Circle = preload("res://Circle.gd")
#const HCircle = preload("res://HyperCircle.gd")
var circle
var hcircle

# Called when the node enters the scene tree for the first time.
func _ready():
	circle = Circle.new(200, 150, 50)
	add_child(circle)
	hcircle = HyperCircle.new(600, 450, 50, 10, 120)
	add_child(hcircle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	pass
