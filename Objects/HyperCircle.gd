class_name HyperCircle extends Circle

@export var line_width:float
@export var outer_radius: float

func _init(x=0, y=0, r=100, lw=10, ou_r=200):
	print("HyperCircle: _init")
	super(x, y, r)
	line_width = lw
	outer_radius = ou_r

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	line_width = 10
	outer_radius = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("Circle: _process")
	#queue_redraw()
	pass

func _draw():
	# Your draw commands here
	print("HyperCircle: _draw")
	draw_circle(Vector2(0, 0), outer_radius, Color.WHITE)
	draw_circle(Vector2(0, 0), outer_radius - line_width, Color.BLACK)
	super()

#Create an HyperCircle class that inherits from the Circle class. 
#An HyperCircle is just like a Circle, except it also has an outer ring 
#drawn around it. It should receive additional arguments line_width and 
#outer_radius in its constructor.
#
#An instance of this HyperCircle class should be created at 
#position 400, 300 with radius 50, line width 10 and outer radius 120.
