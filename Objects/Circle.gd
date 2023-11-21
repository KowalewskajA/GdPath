class_name Circle extends Node2D

@export var radius:float
@export var creation_time:Dictionary
var tween

func _init(x=0, y=0, r=100):
	position = Vector2(x, y)
	radius = r
	creation_time = Time.get_time_dict_from_system()

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = create_tween()
	tween.tween_callback(self._on_tween_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func _draw():
	draw_circle(Vector2(0, 0), radius, Color.WHITE)

func _on_tween_finished():
	if self.radius == 100:
		# print("to 50")
		tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(self, "radius", 50, 2)
		tween.finished.connect(_on_tween_finished)
	else:
		# print("to 100")
		tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(self, "radius", 100, 2)
		tween.finished.connect(_on_tween_finished)

#Create a Circle class that receives x, y and radius arguments in its constructor,
#has x, y, radius and creation_time attributes and has update and draw methods. 
#The x, y and radius attributes should be initialized to the values passed in 
#from the constructor and the creation_time attribute should be initialized to the
#relative time the instance was created (see love.timer). 
#
#The update method should receive a dt argument and the draw function should draw 
#a white filled circle centered at x, y with radius radius (see love.graphics). 
#An instance of this Circle class should be created at position 400, 300 with radius 50.
#It should also be updated and drawn to the screen. This is what the screen should look like:
