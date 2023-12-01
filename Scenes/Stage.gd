class_name Stage extends Node2D

var timer: Timer
var current_scene
var area:Area
var camera:ExtendedCamera
var player:Player

var controls = {
	"left": [KEY_LEFT, KEY_A],
	"right": [KEY_RIGHT, KEY_D],
	"destroy": [KEY_F3],
	"shake": [KEY_F4],
	"shutdown": [KEY_DELETE]
}

func _init():
	name = "Stage"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_inputs()
	area = Area.new()
	area.name = "Area"
	add_child(area)
	camera = ExtendedCamera.new()
	add_child(camera)
	camera.set("position", Vector2(G.gw/2, G.gh/2))
	player = area.add_gameobject(Player, G.gw/2, G.gh/2, {w=12, h=12})

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(area.list_gameobject_types())
	#print(G.obj_counter)
	if Input.is_action_just_pressed("destroy") and is_instance_valid(player):
		player.die()
	if Input.is_action_just_pressed("shake"):
		camera.shake(2, 60, 2)
	if Input.is_action_just_pressed("shutdown"):
		get_tree().quit()
	queue_redraw()
	pass

func _draw():
	pass

func add_inputs():
	var ev
	for action in controls:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
			for key in controls[action]:
				ev = InputEventKey.new()
				ev.keycode = key
				InputMap.action_add_event(action, ev)
