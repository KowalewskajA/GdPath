class_name Rectangle extends GameObject

var width
var height
var color
var points
var uvs

func _init(a, x=0, y=0, opts={width=100, height=100, color=Color.WHITE}):
	super(a, x, y, opts)
	points = PackedVector2Array([
		Vector2(0, 0),
		Vector2(width, 0),
		Vector2(width, height),
		Vector2(0, height)
	])
	uvs = PackedVector2Array([
		Vector2(0, 0),
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(0, 1),
	])

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func _draw():
	draw_colored_polygon(points, color, uvs)

func _die():
	dead = true
