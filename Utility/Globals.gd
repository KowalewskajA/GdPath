extends Node2D

var game_width:int
var game_height:int
var game_scale:int

var gw:int
var gh:int

# Called when the node enters the scene tree for the first time.
func _ready():
	game_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	game_height = ProjectSettings.get_setting("display/window/size/viewport_height")
	game_scale = ProjectSettings.get_setting("display/window/stretch/scale")
	
	gw = game_width / game_scale
	gh = game_height / game_scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
