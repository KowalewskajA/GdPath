extends Node2D

var game_width:float
var game_height:float
var game_scale:float

var gw:float
var gh:float

var de_color:Color = Color8(222, 222, 222)
var bg_color:Color = Color8(16, 16, 16)
var am_color:Color = Color8(123, 200, 164)
var bo_color:Color = Color8(76, 195, 217)
var hp_color:Color = Color8(241, 103, 69)
var sp_color:Color = Color8(255, 198, 93)

var obj_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	game_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	game_height = ProjectSettings.get_setting("display/window/size/viewport_height")
	game_scale = ProjectSettings.get_setting("display/window/stretch/scale")
	
	gw = game_width / game_scale
	gh = game_height / game_scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_id():
	obj_counter += 1
	return obj_counter
