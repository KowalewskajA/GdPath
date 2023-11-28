class_name ChangingCircle extends GameObject

var radius

func _init(a, x=0, y=0, opts={radius=100}):
	super(a, x, y, opts)

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "radius", 2*radius, 2)
	tween.tween_property(self, "radius", radius, 2)
	tween.set_loops()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func _draw():
	draw_circle(Vector2(0, 0), self.radius, Color.WHITE)

func create_animation(type: String):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	if type == "e":
		tween.tween_property(self, "radius", self.radius + 25, 2)
	if type == "s":
		tween.tween_property(self, "radius", self.radius - 25, 2)
