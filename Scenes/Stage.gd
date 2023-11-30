class_name Stage extends Node2D

var timer: Timer
var current_scene
var area:Area
var camera:ExtendedCamera
var player:Player

func _init():
	name = "Stage"

# Called when the node enters the scene tree for the first time.
func _ready():
	area = Area.new()
	area.name = "Area"
	add_child(area)
	camera = ExtendedCamera.new()
	add_child(camera)
	camera.set("position", Vector2(G.gw/2, G.gh/2))
#	camera.shake(4, 60, 2)
	player = area.add_gameobject(Player, G.gw/2, G.gh/2, {w=12, h=12})
	
	var left = InputEventKey.new()
	left.physical_keycode = KEY_LEFT
	InputMap.add_action("left")
	InputMap.action_add_event("left", left)
	
	var right = InputEventKey.new()
	right.physical_keycode = KEY_RIGHT
	InputMap.add_action("right")
	InputMap.action_add_event("right", right)
	
	var f3 = InputEventKey.new()
	f3.physical_keycode = KEY_F3
	InputMap.add_action("destroy")
	InputMap.action_add_event("destroy", f3)
	
	var f4 = InputEventKey.new()
	f4.physical_keycode = KEY_F4
	InputMap.add_action("shake")
	InputMap.action_add_event("shake", f4)
	
	var del = InputEventKey.new()
	del.physical_keycode = KEY_DELETE
	InputMap.add_action("shutdown")
	InputMap.action_add_event("shutdown", del)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("destroy") and is_instance_valid(player):
		player.set("dead", true)
	if Input.is_action_just_pressed("shake"):
		camera.shake(2, 60, 2)
	if Input.is_action_just_pressed("shutdown"):
		get_tree().quit()
	queue_redraw()
	pass

func _draw():
	pass


