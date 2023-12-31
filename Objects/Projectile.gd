class_name Projectile extends GameObject

var s:float = 2.5
var v:int = 100
var r:float = 0
var color:Color = G.de_color
var body: CharacterBody2D
var shape: CircleShape2D

func _init(_area:Area, x:int=0, y:int=0, opts:Dictionary={}) -> void:
	super(_area, x, y, opts)
	name = "Projectile-" + str(G.get_id())

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body = CharacterBody2D.new()
	body.set_position(get_position())
	body.set_name("body")
	var shape_owner_id:int = body.create_shape_owner(self)
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
func _physics_process(delta:float) -> void:
	position = Vector2(position.x + v * delta * cos(r), position.y + v * delta * sin(r))
	body.position = position
	var gp:Vector2 = global_position
	if gp.x < 0 or gp.x > G.gw or gp.y < 0 or gp.y > G.gh:
		die()
	queue_redraw()

func _draw() -> void:
	draw_unfilled_circle(Vector2.ZERO, s, G.de_color)

func die() -> void:
	super()
	area.add_gameobject(
		ProjectileDeathEffect, 
		position.x, 
		position.y, 
		{color = color, w = 4 * s}
	)
