class_name Circle extends GameObject

var radius

func _init(a, x=0, y=0, opts={radius=100}):
	super(a, x, y, opts)

# Called when the node enters the scene tree for the first time.
func _ready():
#	timer.set_autostart(true)
#	timer.set_wait_time(randf_range(2, 4))
#	timer.timeout.connect(_die)
#	add_child(timer)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func _draw():
	draw_circle(Vector2(0, 0), self.radius, Color.WHITE)

func _die():
	dead = true
