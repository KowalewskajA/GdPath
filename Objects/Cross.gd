class_name Cross extends Node2D

var rect_1:Rect2
var rect_2:Rect2
var tween:Tween

#Using only the tween function, tween the w attribute of the first rectangle
#over 1 second using the in-out-cubic tween mode. After that is done, tween 
#the h attribute of the second rectangle over 1 second using the in-out-cubic 
#tween mode. After that is done, tween both rectangles back to their original 
#attributes over 2 seconds using the in-out-cubic tween mode.

# Rect2 ( float x, float y, float width, float height )

func _init(r1=Rect2(400, 300, 50, 200), r2=Rect2(400, 300, 200, 50)):
	rect_1 = r1
	rect_2 = r2

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_method(change_width.bind("rect_1"), 50, 0, 1)
	tween.tween_method(change_height.bind("rect_2"),50, 0, 1).set_delay(1.0)
	tween.tween_method(change_width.bind("rect_1"), 0, 50, 1).set_delay(2.0)
	tween.tween_method(change_height.bind("rect_2"),0, 50, 1).set_delay(2.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func _draw():
	draw_rect(
		create_printable_rect(rect_1), Color.WHITE
	)
	draw_rect(
		create_printable_rect(rect_2), Color.WHITE
	)

func create_printable_rect(r:Rect2):
	return Rect2(
		r.position.x - r.size.x/2,
		r.position.y - r.size.y/2,
		r.size.x,
		r.size.y
	)

func change_width(val:int, r:String):
	if r == "rect_1":
		rect_1.size = Vector2(val, rect_1.size.y)
	else:
		rect_2.size = Vector2(val, rect_2.size.y)

func change_height(val:int, r:String):
	if r == "rect_1":
		rect_1.size = Vector2(rect_1.size.x, val)
	else:
		rect_2.size = Vector2(rect_2.size.x, val)
