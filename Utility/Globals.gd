extends Node2D

var game_width:float
var game_height:float
var game_scale:float

var gw:float
var gh:float

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
