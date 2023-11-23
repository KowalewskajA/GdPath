class_name Cross extends Node2D

var rect_1:Rect2
var rect_2:Rect2
var tween:Tween

#22. Using only the tween function, tween the w attribute of the first rectangle
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
	tween.tween_property(self, "rect_1:size:x", 0, 1.0)
	tween.tween_property(self, "rect_2:size:y", 0, 1.0)
	tween.tween_property(self, "rect_1:size:x", 50, 2.0)
	tween.parallel().tween_property(self, "rect_2:size:y", 50, 2.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func _draw():
	draw_rect(create_printable_rect(rect_1), Color.WHITE)
	draw_rect(create_printable_rect(rect_2), Color.WHITE)

func create_printable_rect(r:Rect2):
	return Rect2(
		r.position.x - r.size.x/2,
		r.position.y - r.size.y/2,
		r.size.x,
		r.size.y
	)