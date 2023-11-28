class_name GameObject extends Node2D

var area:Node2D
var timer:Timer
var tween:Tween
var dead:bool

func _init(a, x=0, y=0, opts={}):
	area = a
	position = Vector2(x, y)
	timer = Timer.new()
	dead = false
	if opts.size() > 0:
		for key in opts:
			self.set(key, opts[key])

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	pass
