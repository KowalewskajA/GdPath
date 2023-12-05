class_name Game extends Node2D

var timer: Timer
var current_scene:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#current_scene = CircleScene.new()
	current_scene = Stage.new()
	add_child(current_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta:float) -> void:
#	print_orphan_nodes()
#	print_tree_pretty()
	pass

func _draw() -> void:
	pass
