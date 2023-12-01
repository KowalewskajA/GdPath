class_name ShootEffect extends GameObject

var w:int = 8
var player:Player
var d:float
var r:float

func _init(area, x=0, y=0, opts={}):
	super(area, x, y, opts)
	name = "ShootEffect-" + str(G.get_id())

# Called when the node enters the scene tree for the first time.
func _ready():
	tween=create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "w", 0, 0.1)
	tween.finished.connect(die)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_instance_valid(player): 
		position.x = player.position.x + d * cos(player.r) 
		position.y = player.position.y + d * sin(player.r)
		rotation = player.r
	pass

func _draw():
#	85. Using pushRotate, rotate the ShootEffect object around the player's center
#	by 90 degrees (on top of already rotating it by the player's direction).
#	TODO: Something is wrong here, it glitches
#	draw_set_transform(
#		Vector2(
#			- d  * cos(rotation) + d * cos(rotation + PI/2),
#			- d  * sin(rotation) + d * sin(rotation + PI/2)
#		), PI/4
#	)
	draw_set_transform(Vector2.ZERO, PI/4)
	draw_rect(Rect2(Vector2(-0.5 * w, -0.5 * w), Vector2(w,w)), G.de_color)
