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

var obj_counter:int = 0

var camera:ExtendedCamera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	game_height = ProjectSettings.get_setting("display/window/size/viewport_height")
	game_scale = ProjectSettings.get_setting("display/window/stretch/scale")
	
	gw = game_width / game_scale
	gh = game_height / game_scale
	
	camera = ExtendedCamera.new()
	add_child(camera)
	camera.set("position", Vector2(G.gw/2, G.gh/2))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta:float) -> void:
	pass

func get_id() -> int:
	obj_counter += 1
	return obj_counter

func slow(amount:float, duration:float) -> void:
	Engine.time_scale = amount
	var tween:Tween = create_tween()#'slow', duration, _G, {slow_amount = 1}, 'in-out-cubic')
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(Engine, "time_scale", 1, duration)
