class_name GameObject extends Node2D

var area:Node2D
var timer:Timer
var tween:Tween
var dead:bool
#var depth:int

func _init(a:Area, x:int=0, y:int=0, opts:Dictionary={}) -> void:
	area = a
	position = Vector2(x, y)
	dead = false
	if opts.size() > 0:
		for key:String in opts:
			self.set(key, opts[key])
	z_index = 0 # aka depth

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta:float) -> void:
	queue_redraw()

func _draw() -> void:
	pass

func die() -> void:
	dead = true

func distort_points(points:PackedVector2Array) -> PackedVector2Array:
	var d_points = PackedVector2Array()
	for i in range(0, points.size()):
		if i % 2 == 0:
			d_points.append(points[i] + Vector2(0, randi_range(-1, 1)))
		else:
			d_points.append(points[i] + Vector2(randi_range(-1, 1), 0))
	return d_points

func draw_unfilled_circle(center:Vector2, radius:float, color:Color) -> void:
	var nb_points:int = 32
	var points_arc:Array = PackedVector2Array()
	for i in range(nb_points + 1):
		var angle_point:float = deg_to_rad(0 + i * 360.0 / nb_points - 90.0)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
