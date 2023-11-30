class_name Game extends Node2D

var timer: Timer
var current_scene

# Called when the node enters the scene tree for the first time.
func _ready():	
	#current_scene = CircleScene.new()
	current_scene = Stage.new()
	add_child(current_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _draw():
	pass
