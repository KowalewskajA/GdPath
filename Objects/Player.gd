class_name Player extends GameObject

var w:int
var h:int
var r:float = -PI/2
var rv:float = 1.66*PI
var v:float = 0
var max_v:float = 100
var a: float = 100
var body:CharacterBody2D

func _init(area, x=0, y=0, opts={}):
	super(area, x, y, opts)
	name = "Player-" + str(G.get_id())

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
	timer = Timer.new()
	timer.name = "ShootTimer"
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
	position = Vector2(position.x + v * delta * cos(r), position.y + v * delta * sin(r))
	body.position = position
	var gp = global_position
	if gp.x < -w or gp.x > G.gw + w or gp.y < -h or gp.y > G.gh + h:
		if !dead:
			die()
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
	draw_line(Vector2.ZERO, Vector2(2 * w * cos(r), 2 * w * sin(r)), G.de_color)
	draw_line(Vector2.ZERO, Vector2(2 * w * cos(rotation), 2 * w * sin(rotation)), G.hp_color)
	draw_unfilled_circle(Vector2.ZERO, w, G.de_color)

func die():
	super()

func shoot():
	var d = 1.2 * w
	area.add_gameobject(
		ShootEffect, 
		position.x + d * cos(r), 
		position.y + d * sin(r), 
		{player = self, d = d}
	)
	area.add_gameobject(
		Projectile, 
		position.x + 1.5 * d * cos(r), 
		position.y + 1.5 * d * sin(r), 
		{r = r}
	)
#	86. From the player's shoot function, change the size/radius 
#	of the created projectiles to 5 and their velocity to 150.
#	area.add_gameobject(
#		Projectile, 
#		position.x + 1.5 * d * cos(r), 
#		position.y + 1.5 * d * sin(r), 
#		{r = r, s = 5, v = 150}
#	)
#	87. Change the shoot function to spawn 3 projectiles instead of 1,
#	while 2 of those projectiles are spawned with angles pointing to 
#	the player's angle +-30 degrees.
#	area.add_gameobject(
#		Projectile, 
#		position.x + 1.5 * d * cos(r+PI/6), 
#		position.y + 1.5 * d * sin(r+PI/6), 
#		{r = r+PI/6}
#	)
#	area.add_gameobject(
#		Projectile, 
#		position.x + 1.5 * d * cos(r-PI/6), 
#		position.y + 1.5 * d * sin(r-PI/6), 
#		{r = r-PI/6}
#	)
#	88. Change the shoot function to spawn 3 projectiles instead of 1, 
#	with the spawning position of each side projectile being offset from 
#	the center one by 8 pixels.
#	area.add_gameobject(
#		Projectile, 
#		position.x + 1.5 * d * cos(r) + 8 * cos(r + PI/2), 
#		position.y + 1.5 * d * sin(r) + 8 * sin(r + PI/2), 
#		{r = r}
#	)
#	area.add_gameobject(
#		Projectile, 
#		position.x + 1.5 * d * cos(r) - 8 * cos(r + PI/2), 
#		position.y + 1.5 * d * sin(r) - 8 * sin(r + PI/2), 
#		{r = r}
#	)
	pass
