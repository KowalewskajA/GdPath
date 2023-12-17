extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass

func populate_polygons(str:String, w:int) -> Dictionary:
	var polygons = {}
	if str == "Fighter":
		polygons[0] = PackedVector2Array()
		polygons[0].append(Vector2(w, 0))
		polygons[0].append(Vector2(w/2, -w/2))
		polygons[0].append(Vector2(-w/2, -w/2))
		polygons[0].append(Vector2(-w, 0))
		polygons[0].append(Vector2(-w/2, w/2))
		polygons[0].append(Vector2(w/2, w/2))
		polygons[0].append(Vector2(w, 0))
		
		polygons[1] = PackedVector2Array()
		polygons[1].append(Vector2(w/2, -w/2))
		polygons[1].append(Vector2(0, -w))
		polygons[1].append(Vector2(-w -w/2, -w))
		polygons[1].append(Vector2(-3*w/4, -w/4))
		polygons[1].append(Vector2(-w/2, -w/2))
		polygons[1].append(Vector2(w/2, -w/2))
		
		polygons[2] = PackedVector2Array()
		polygons[2].append(Vector2(w/2, w/2))
		polygons[2].append(Vector2(0, w))
		polygons[2].append(Vector2(-w -w/2, w))
		polygons[2].append(Vector2(-3*w/4, w/4))
		polygons[2].append(Vector2(-w/2, w/2))
		polygons[2].append(Vector2(w/2, w/2))
	return polygons
