class_name HP_Bar extends Node2D

var rect_bg: Rect2
var rect_fg: Rect2
var width: int
var tween: Tween
var tween_finished: bool = true
var rng:= RandomNumberGenerator.new()

#23. For this exercise you should create an HP bar. Whenever the user presses 
#the d key the _HP bar should simulate damage taken. There are two layers to 
#this HP bar, and whenever damage is taken the top layer moves faster while 
#the background one lags behind for a while.

func _init(r1=Rect2(300, 275, 200, 50)):
	rect_bg = r1
	rect_fg = r1
	width = r1.size.x

# Called when the node enters the scene tree for the first time.
func _ready():
	tween=create_tween()
	tween.finished.connect(_on_tween_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	#print("HP_Bar: " + str(rect_bg.size.x/width*100) + "%")
	if Input.is_physical_key_pressed(KEY_D) and rect_fg.size.x > 0 and tween_finished:
		create_animation()

func _draw():
	draw_rect(rect_bg, Color8(127, 15, 15))
	draw_rect(rect_fg, Color8(255, 63, 63))

func create_animation():
	var dmg = max(randfn(25.0, 8.0), 0)
	tween=create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	if rect_bg.size.x - dmg * width/100 < 0:
		tween.tween_property(self, "rect_fg:size:x", 0, 0.25)
		tween.tween_property(self, "rect_bg:size:x", 0, 0.40)
		tween.tween_property(self, "rect_fg:size:x", width, 0.0).set_delay(1)
		tween.parallel().tween_property(self, "rect_bg:size:x", width, 0.0).set_delay(1)
	else:
		tween.tween_property(self, "rect_fg:size:x", rect_bg.size.x - dmg * width/100, 0.25)
		tween.tween_property(self, "rect_bg:size:x", rect_fg.size.x - dmg * width/100, 0.25)

func _on_tween_finished():
	tween_finished = true
