class_name Area extends Node2D

var timer: Timer
var game_objects = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for index in game_objects.size():
		if is_instance_valid(game_objects[index-1]) == true:
			var game_object = game_objects[index-1]
			if game_object.get("dead") == true:
				game_objects.pop_at(index-1)
				remove_child(game_object)
				game_object.queue_free()

func add_gameobject(game_object_type, x=0, y=0, opts={}):
	var game_object = game_object_type.new(self, x, y, opts)
	game_objects.append(game_object)
	add_child(game_object)

func get_gameobjects(f:Callable):
	var found_objects = Array()
	for object in game_objects:
		if f.call(object) == true:
			found_objects.append(object)
	return found_objects
