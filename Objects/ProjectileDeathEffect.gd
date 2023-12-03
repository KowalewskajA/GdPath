class_name ProjectileDeathEffect extends GameObject

var w:int = 0
var timer_status:int  = 1
var color:Color = G.de_color

func _init(_area, x=0, y=0, opts={}):
	super(_area, x, y, opts)
	name = "ProjectileDeathEffect-" + str(G.get_id())

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	timer = Timer.new()
	timer.name = "Timer"
	timer.set_autostart(true)
	timer.set_wait_time(0.1)
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	queue_redraw()

func _draw():
	var cur_color:Color
	if timer_status == 1:
		cur_color = G.de_color
	else:
		cur_color = color
	draw_rect(Rect2(-w/2, -w/2, w, w), cur_color)

func _on_timer_timeout():
	if timer_status == 1:
		timer.set_wait_time(0.15)
		timer_status = 2
	if timer_status == 2:
		timer.stop()
		die()
