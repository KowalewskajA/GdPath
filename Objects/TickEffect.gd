class_name TickEffect extends GameObject

var parent:Node2D
var w:int = 48
var h:int = 32
var offset:int = 0

func _init(_area, x=0, y=0, opts={}):
	super(_area, x, y, opts)
	name = "TickEffect-" + str(G.get_id())

# Called when the node enters the scene tree for the first time.
func _ready():
	tween=create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()
	tween.tween_property(self, "h", 0, 0.13)
	tween.tween_property(self, "offset", 30, 0.13)
	tween.finished.connect(func(): dead = true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_instance_valid(parent):
		position = parent.position
	queue_redraw()

func _draw():
	draw_rect(Rect2(-w/2, -h/2 - offset, w, h), G.de_color)
