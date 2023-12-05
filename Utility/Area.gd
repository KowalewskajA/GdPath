class_name Area extends Node2D

var timer:Timer
var game_objects:Array = Array()

func _init() -> void:
	name = "Area"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta:float) -> void:
	for index:int in range(game_objects.size(), 0, -1):
		if is_instance_valid(game_objects[index-1]) == true:
			var game_object:GameObject = game_objects[index-1]
			if game_object.get("dead") == true:
				game_objects.pop_at(index-1)
				remove_child(game_object)
				game_object.queue_free()

func list_gameobject_types() -> Dictionary:
	var dict:Dictionary = {}
	for index:int in range(game_objects.size(), 0, -1):
		if is_instance_valid(game_objects[index-1]) == true:
			var game_object:GameObject = game_objects[index-1]
			var i:int = game_object.get("name").find("-")
			var _name:String = game_object.get("name").left(i)
			if _name in dict:
				dict[name] += 1
			else:
				dict[name] = 1
	return dict

func add_gameobject(game_object_type:Variant, x:int=0, y:int=0, opts:Dictionary={}) -> GameObject:
	var game_object:GameObject = game_object_type.new(self, x, y, opts)
	game_objects.append(game_object)
	add_child(game_object)
	return game_object

func get_gameobjects(f:Callable) -> Array:
	var found_objects:Array = Array()
	for object:GameObject in game_objects:
		if f.call(object) == true:
			found_objects.append(object)
	return found_objects

#61. Create a queryCircleArea function inside the Area class that works as follows:
#-- Get all objects of class 'Enemy' and 'Projectile' in a circle of 50 radius around point 100, 100
#objects = area:queryCircleArea(100, 100, 50, {'Enemy', 'Projectile'})
#It receives an x, y position, a radius and a list of strings containing names of target classes. 
#Then it returns all objects belonging to those classes inside the circle of radius radius centered
#in position x, y.
func query_circle_area(x:int, y:int, radius:int, types:Array) -> Array:
	var origin:Vector2 = Vector2(x, y)
	var found_objects:Array = Array()
	for object:GameObject in game_objects:
		if origin.distance_to(object.position) <= radius:
			for object_type:Variant in types:
				if object_type == object.get_script():
					found_objects.append(object)
	return found_objects

#62. Create a getClosestGameObject function inside the Area class that works follows:
#-- Get the closest object of class 'Enemy' in a circle of 50 radius around point 100, 100
#closest_object = area:getClosestObject(100, 100, 50, {'Enemy'})
#It receives the same arguments as the queryCircleArea function but returns only one object 
#(the closest one) instead.
func get_closest_gameobject(x:int, y:int, radius:int, types:Array) -> GameObject:
	var origin:Vector2 = Vector2(x, y)
	var candidate:GameObject = null
	var candidate_distance:float = radius +1
	for object:GameObject in game_objects:
		var current_distance:float = origin.distance_to(object.position)
		if current_distance <= radius:
			for object_type:Variant in types:
				if object_type == object.get_script():
					if current_distance < candidate_distance:
						candidate = object
						candidate_distance = current_distance
	return candidate

func destroy_random_gameobject(f:Callable) -> void:
	var found_objects:Array = get_gameobjects(f)
	found_objects[randi_range(0, found_objects.size()-1)].set("dead", true)
