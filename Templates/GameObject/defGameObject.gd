# meta-name: default script GameOject
# meta-description: This is the dafult script for every gameobject that is extending GameObject
# meta-default: true
class_name DEF extends _BASE_

# every variable that should be set-able at creation via opts Dictionary has to be set here

func _init(_area, x=0, y=0, opts={}):
	super(_area, x, y, opts)
	name = "DEF-" + str(G.get_id())

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	queue_redraw()

# Your draw code goes here
func _draw() -> void:
	pass
