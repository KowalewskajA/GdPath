class_name GameObject extends Node2D

var area:Node2D
var timer:Timer
var tween:Tween
var dead:bool

func _init(a, x=0, y=0, opts={}):
	area = a
	position = Vector2(x, y)
	timer
	dead = false
	if opts.size() > 0:
		for key in opts:
			self.set(key, opts[key])

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _draw():
	pass

func die():
	dead = true

func draw_unfilled_circle(center, radius, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()
	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(0 + i * 360.0 / nb_points - 90.0)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
