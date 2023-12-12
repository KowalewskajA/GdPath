class_name Player extends GameObject

var w:int
var h:int
var r:float = -PI/2
var rv:float = 1.66*PI

var v:float = 0
var base_max_v:float = 100
var max_v:float = base_max_v
var a: float = 100

var body:CharacterBody2D

var shoot_timer:Timer
var tick_timer:Timer
var trail_timer:Timer

var trail_color:Color = G.sp_color
var boosting:bool = false

var ship:String = "Fighter"
var polygons:Dictionary = {}

func _init(_area:Area, x:int=0, y:int=0, opts:={}) -> void:
	super(_area, x, y, opts)
	name = "Player-" + str(G.get_id())
	if ship == "Fighter":
		polygons[0]= PackedVector2Array()
		polygons[0].append(Vector2(w, 0))
		polygons[0].append(Vector2(w/2, -w/2))
		polygons[0].append(Vector2(-w/2, -w/2))
		polygons[0].append(Vector2(-w, 0))
		polygons[0].append(Vector2(-w/2, w/2))
		polygons[0].append(Vector2(w/2, w/2))
		polygons[0].append(Vector2(w, 0))
		
		polygons[1]= PackedVector2Array()
		polygons[1].append(Vector2(w/2, -w/2))
		polygons[1].append(Vector2(0, -w))
		polygons[1].append(Vector2(-w -w/2, -w))
		polygons[1].append(Vector2(-3*w/4, -w/4))
		polygons[1].append(Vector2(-w/2, -w/2))
		polygons[1].append(Vector2(w/2, -w/2))
		
		polygons[2]= PackedVector2Array()
		polygons[2].append(Vector2(w/2, w/2))
		polygons[2].append(Vector2(0, w))
		polygons[2].append(Vector2(-w -w/2, w))
		polygons[2].append(Vector2(-3*w/4, w/4))
		polygons[2].append(Vector2(-w/2, w/2))
		polygons[2].append(Vector2(w/2, w/2))

	#for i in range(0, polygons.size()):
		#colors[i]= PackedColorArray()
		#for j in range(0, polygons[i].size()):
			#colors[i].append(G.de_color)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body = CharacterBody2D.new()
	body.set_position(get_position())
	body.set_name("body")
	var shape_owner_id:int = body.create_shape_owner(self)
	var shape:CircleShape2D = CircleShape2D.new()
	shape.set_radius(w)
	body.shape_owner_add_shape(shape_owner_id, shape)
	add_child(body)
	_create_timer(shoot_timer, "ShootTimer", 0.24, shoot)
	_create_timer(tick_timer, "TickTimer", 5.00, tick)
	_create_timer(trail_timer, "TrailTimer", 0.01, trail)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta:float) -> void:
	max_v = base_max_v
	trail_color = G.sp_color
	if Input.is_action_pressed("speed_up"):
		max_v = 1.5 * base_max_v
		trail_color = G.hp_color
	if Input.is_action_pressed("speed_down"):
		max_v = 0.5 * base_max_v
		trail_color = G.bo_color
	if Input.is_action_pressed("left"):
		r = r - rv * delta
	if Input.is_action_pressed("right"):
		r = r + rv * delta
	
	v = min(v + a * delta, max_v)
	position = Vector2(position.x + v * delta * cos(r), position.y + v * delta * sin(r))
	body.position = position
	
	var gp:Vector2 = global_position
	if gp.x < -w or gp.x > G.gw + w or gp.y < -h or gp.y > G.gh + h:
		if !dead:
			die()
	queue_redraw()

func _draw() -> void:
	# 480 270
#	82. Using pushRotate, rotate the player around its center by 180 degrees.
#	draw_set_transform(Vector2.ZERO, PI)
#	83. Using pushRotate, rotate the line that points in the player's moving 
#	direction around its center by 90 degrees
#	draw_set_transform(Vector2(w * cos(r) + w * cos(r - PI/2), w * sin(r) + w * sin(r - PI/2)), PI/2)
#	84. Using pushRotate, rotate the line that points in the player's moving 
#	direction around the player's center by 90 degrees.
#	draw_set_transform(Vector2.ZERO, PI/2)
	#draw_line(Vector2.ZERO, Vector2(2 * w * cos(r), 2 * w * sin(r)), G.de_color)
	#draw_line(Vector2.ZERO, Vector2(2 * w * cos(rotation), 2 * w * sin(rotation)), G.hp_color)
	draw_set_transform(Vector2.ZERO, r)
	for i in range(0, polygons.size()):
		var points = distort_points(polygons[i])
		draw_polyline(points, G.de_color)

func die() -> void:
	super()
	for i:int in range(randi_range(8, 12)):
		area.add_gameobject(ExplosionParticle, position.x, position.y)
	G.slow(0.15, 1)
	G.camera.shake(6, 60, 0.4)
	G.camera.flash(0.033) #2/60

func shoot() -> void:
	var d:float = 1.2 * w
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

func tick() -> void:
	area.add_gameobject(TickEffect, position.x, position.y, {parent = self})

func trail() -> void:
	area.add_gameobject(
		TrailParticle, 
		position.x - 0.9 * w * cos(r) + 0.2 * w * cos(r - PI/2), 
		position.y - 0.9 * w * sin(r) + 0.2 * w * sin(r - PI/2),
		{
			parent = self, 
			r = randi_range(2, 4), 
			d = randf_range(0.15, 0.25), 
			color = trail_color
		}
	)
	area.add_gameobject(
		TrailParticle, 
		position.x - 0.9 * w * cos(r) + 0.2 * w * cos(r + PI/2), 
		position.y - 0.9 * w * sin(r) + 0.2 * w * sin(r + PI/2),
		{
			parent = self, 
			r = randi_range(2, 4), 
			d = randf_range(0.15, 0.25), 
			color = trail_color
		}
	)

func _create_timer(variable:Variant, variable_name:String, time:float, function:Callable) -> void:
	variable = Timer.new()
	variable.name = variable_name
	variable.set_autostart(true)
	variable.set_wait_time(time)
	variable.timeout.connect(function)
	add_child(variable)
