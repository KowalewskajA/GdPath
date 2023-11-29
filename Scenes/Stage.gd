class_name Stage extends Node2D

var timer: Timer
var current_scene
var area:Area
var camera:ExtendedCamera

# Called when the node enters the scene tree for the first time.
func _ready():
	area = Area.new()
	add_child(area)
	camera = ExtendedCamera.new()
	add_child(camera)
	camera.set("position", Vector2(G.gw/2, G.gh/2))
	camera.shake(4, 60, 2)
	timer = Timer.new()
	timer.set_autostart(true)
	add_child(timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	queue_redraw()
	pass

func _draw():
	# 480 270
	draw_unfilled_circle(Vector2(G.gw/2, G.gh/2), G.gw/6, Color.WHITE)

func draw_unfilled_circle(center, radius, color):
	var nb_points = 64
	var points_arc = PackedVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(0 + i * 360 / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
