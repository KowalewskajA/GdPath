class_name ExplosionParticle extends GameObject

var color:Color = G.de_color
var line_width:int = 2
var r:float = randf_range(0, 2*PI)
var s:int = randi_range(2, 3)
var v:int = randi_range(75, 150)
var d:float = randf_range(0.3, 0.5)

func _init(_area:Area, x:int=0, y:int=0, opts:={}) -> void:
	super(_area, x, y, opts)
	name = "ExplosionParticle-" + str(G.get_id())

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween=create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()
	tween.tween_property(self, "s", 0, d)
	tween.tween_property(self, "v", 0, d)
	tween.tween_property(self, "line_width", 0, d)
	tween.finished.connect(func() -> void: dead = true)

func _process(delta:float) -> void:
	position = Vector2(position.x + v * delta * cos(r), position.y + v * delta * sin(r))
	queue_redraw()

func _draw() -> void:
	draw_set_transform(Vector2.ZERO, r)
	draw_line(Vector2(-s, 0), Vector2(s, 0), color, line_width)
	#cool death effect but not what we want
	#draw_unfilled_circle(
		#Vector2(s*randi_range(-3,3), s*randi_range(-3,3)), 
		#v/25, 
		#color
	#)
