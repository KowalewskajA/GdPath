class_name Area extends Node2D

var timer: Timer
var game_objects = Array()

func _init():
	name = "Area"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for index:int in range(game_objects.size(), 0, -1):
		if is_instance_valid(game_objects[index-1]) == true:
			var game_object = game_objects[index-1]
			if game_object.get("dead") == true:
				game_objects.pop_at(index-1)
				remove_child(game_object)
				game_object.queue_free()

func list_gameobject_types():
	var dict = {}
	for index:int in range(game_objects.size(), 0, -1):
		if is_instance_valid(game_objects[index-1]) == true:
			var game_object = game_objects[index-1]
			var i = game_object.get("name").find("-")
			var name = game_object.get("name").left(i)
			if name in dict:
				dict[name] += 1
			else:
				dict[name] = 1
	return dict

func add_gameobject(game_object_type, x=0, y=0, opts={}):
	var game_object = game_object_type.new(self, x, y, opts)
	game_objects.append(game_object)
	add_child(game_object)
	return game_object

func get_gameobjects(f:Callable):
	var found_objects = Array()
	for object in game_objects:
		if f.call(object) == true:
			found_objects.append(object)
	return found_objects

#61. Create a queryCircleArea function inside the Area class that works as follows:
#-- Get all objects of class 'Enemy' and 'Projectile' in a circle of 50 radius around point 100, 100
#objects = area:queryCircleArea(100, 100, 50, {'Enemy', 'Projectile'})
#It receives an x, y position, a radius and a list of strings containing names of target classes. 
#Then it returns all objects belonging to those classes inside the circle of radius radius centered
#in position x, y.
func query_circle_area(x:int, y:int, radius:int, types:Array):
	var origin = Vector2(x, y)
	var found_objects = Array()
	for object in game_objects:
		if origin.distance_to(object.position) <= radius:
			for object_type in types:
				if object_type == object.get_script():
					found_objects.append(object)
	return found_objects

#62. Create a getClosestGameObject function inside the Area class that works follows:
#-- Get the closest object of class 'Enemy' in a circle of 50 radius around point 100, 100
#closest_object = area:getClosestObject(100, 100, 50, {'Enemy'})
#It receives the same arguments as the queryCircleArea function but returns only one object 
#(the closest one) instead.
func get_closest_gameobject(x:int, y:int, radius:int, types:Array):
	var origin = Vector2(x, y)
	var candidate = null
	var candidate_distance = radius +1
	for object in game_objects:
		var current_distance = origin.distance_to(object.position)
		if current_distance <= radius:
			for object_type in types:
				if object_type == object.get_script():
					if current_distance < candidate_distance:
						candidate = object
						candidate_distance = current_distance
	return candidate

func destroy_random_gameobject(f:Callable):
	var found_objects = get_gameobjects(f)
	found_objects[randi_range(0, found_objects.size()-1)].set("dead", true)
