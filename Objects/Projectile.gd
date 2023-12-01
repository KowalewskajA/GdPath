class_name Projectile extends GameObject

var s:float = 2.5
var v:int = 100
var r:float = 0
var body: CharacterBody2D
var shape: CircleShape2D

func _init(area, x=0, y=0, opts={}):
	super(area, x, y, opts)
	name = "Projectile-" + str(G.get_id())

# Called when the node enters the scene tree for the first time.
func _ready():
	body = CharacterBody2D.new()
	body.set_position(get_position())
	body.set_name("body")
	var shape_owner_id = body.create_shape_owner(self)
	shape = CircleShape2D.new()
	shape.set_radius(s)
	body.shape_owner_add_shape(shape_owner_id, shape)
	add_child(body)
#	89. Change the initial projectile speed to 100 and make it accelerate 
#	up to 400 over 0.5 seconds after its creation.
	tween=create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "v", 400, 0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = Vector2(position.x + v * delta * cos(r), position.y + v * delta * sin(r))
	body.position = position
	var gp = global_position
	if gp.x < -s or gp.x > G.gw + s or gp.y < -s or gp.y > G.gh + s:
		die()
	queue_redraw()

func _draw():
	draw_unfilled_circle(Vector2.ZERO, s, G.de_color)
