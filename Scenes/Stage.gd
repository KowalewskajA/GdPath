class_name Stage extends Node2D

var timer: Timer
var area:Area
var player:Player

var controls:Dictionary = {
	"speed_up": [KEY_UP, KEY_W],
	"speed_down": [KEY_DOWN, KEY_S],
	"left": [KEY_LEFT, KEY_A],
	"right": [KEY_RIGHT, KEY_D],
	"destroy": [KEY_F3],
	"shake": [KEY_F4],
	"shutdown": [KEY_DELETE],
}

func _init() -> void:
	name = "Stage"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_inputs()
	area = Area.new()
	area.name = "Area"
	add_child(area)
	player = area.add_gameobject(Player, int(G.gw/2), int(G.gh/2), {w=12, h=12})

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta:float) -> void:
	#print(area.list_gameobject_types())
	#print(G.obj_counter)
	if Input.is_action_just_pressed("destroy") and is_instance_valid(player):
		player.die()
	if Input.is_action_just_pressed("shake"):
		G.camera.shake(2, 60, 2)
	if Input.is_action_just_pressed("shutdown"):
		get_tree().quit()
	queue_redraw()
	pass

func _draw() -> void:
	pass

func add_inputs() -> void:
	var ev:InputEventKey
	for action:String in controls:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
			for key:Variant in controls[action]:
				ev = InputEventKey.new()
				ev.keycode = key
				InputMap.action_add_event(action, ev)
