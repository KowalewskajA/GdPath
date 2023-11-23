class_name Circle extends Node2D

@export var radius:float
@export var creation_time:Dictionary
var tween

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

func _init(x=0, y=0, r=100):
	position = Vector2(x, y)
	radius = r
	creation_time = Time.get_time_dict_from_system()

# Called when the node enters the scene tree for the first time.
func _ready():
#	24. Taking the previous example of the expanding and shrinking circle,
#	it expands once and then shrinks once. How would you change that code
#	so that it expands and shrinks continually forever?
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "radius", 2*radius, 2)
	tween.tween_property(self, "radius", radius, 2)
	tween.set_loops()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	26. Bind 
#		the e key to expand the circle when pressed and 
#		the s to shrink the circle when pressed. 
#	Each new key press should cancel any expansion/shrinking that is still happening.
#	if Input.is_physical_key_pressed(KEY_E):
#		create_animation("e")
#	if Input.is_physical_key_pressed(KEY_S):
#		create_animation("s")
	queue_redraw()

func _draw():
	draw_circle(Vector2(0, 0), radius, Color.WHITE)

func create_animation(type: String):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	if type == "e":
		tween.tween_property(self, "radius", radius + 25, 2)
	if type == "s":
		tween.tween_property(self, "radius", radius - 25, 2)
