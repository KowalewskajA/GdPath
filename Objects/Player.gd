class_name Player extends GameObject

var w:int
var h:int
var r:float = -PI/2
var rv:float = 1.66*PI
var v:float = 0
var max_v:float = 2
var a: float = 1
var body:CharacterBody2D

func _init(area, x=0, y=0, opts={}):
	super(area, x, y, opts)

# Called when the node enters the scene tree for the first time.
func _ready():
	body = CharacterBody2D.new()
	body.set_position(get_position())
	body.set_name("body")
	var shape_owner_id = body.create_shape_owner(self)
	var shape = CircleShape2D.new()
	shape.set_radius(w)
	body.shape_owner_add_shape(shape_owner_id, shape)
	add_child(body)
	timer.set_autostart(true)
	timer.set_wait_time(0.24)
	timer.timeout.connect(shoot)
	add_child(timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("left"):
		r = r - rv * delta
	if Input.is_action_pressed("right"):
		r = r + rv * delta
	v = min(v + a * delta, max_v)
	position = Vector2(position.x + v * cos(r), position.y + v * sin(r))
	body.position = position
	queue_redraw()

func _draw():
	# 480 270
#	82. Using pushRotate, rotate the player around its center by 180 degrees.
#	draw_set_transform(Vector2.ZERO, PI)
#	83. Using pushRotate, rotate the line that points in the player's moving 
#	direction around its center by 90 degrees
#	draw_set_transform(Vector2(w * cos(r) + w * cos(r - PI/2), w * sin(r) + w * sin(r - PI/2)), PI/2)
#	84. Using pushRotate, rotate the line that points in the player's moving 
#	direction around the player's center by 90 degrees.
#	draw_set_transform(Vector2.ZERO, PI/2)
	draw_line(Vector2.ZERO, Vector2(2 * w * cos(r), 2 * w * sin(r)), Color.WHITE)
	draw_line(Vector2.ZERO, Vector2(2 * w * cos(rotation), 2 * w * sin(rotation)), Color.RED)

	draw_unfilled_circle(Vector2.ZERO, w, Color.WHITE)
	

func shoot():
	var d = 1.2 * w
	area.add_gameobject(
		ShootEffect, 
		position.x + d * cos(r), 
		position.y + d * sin(r), 
		{player = self, d = d}
	)
	pass
