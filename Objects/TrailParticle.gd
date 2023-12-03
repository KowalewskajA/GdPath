class_name TrailParticle extends GameObject

# every variable that should be set-able at creation via opts Dictionary has to be set here
var r:int = randi_range(4, 6)
var d:float = randf_range(0.3, 0.5)
var color:Color = G.de_color

func _init(_area, x=0, y=0, opts={}):
	super(_area, x, y, opts)
	name = "TrailParticle" + str(G.get_id())

# Called when the node enters the scene tree for the first time.
func _ready():
	tween=create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "r", 0, d)
	tween.finished.connect(func(): dead = true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	queue_redraw()

# Your draw code goes here
func _draw():
	draw_circle(Vector2.ZERO, r, color)

