class_name ExtendedCamera extends Camera2D

#We want a Camera with a shake we can call via:
#camera.shake(amplitude=4[pixels], frequency=60[Hertz], duration=1[Seconds])
#https://jonny.morrill.me/en/blog/gamedev-how-to-implement-a-camera-shake-effect/

var starting_position:Vector2
var samples_x:Array
var samples_y:Array
var is_shaking:bool
var start_time:float
var end_time:float
var current_time:float

var root:Node
var rect:ColorRect
var timer:Timer

func _init() -> void:
	name = "exCamera"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	root = get_node('/root')

func _draw() -> void:
	draw_rect(Rect2(Vector2(-0.5 * G.gw, -0.5 * G.gh), Vector2(G.gw,G.gh)), G.bg_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta:float) -> void:
	if is_shaking:
		current_time += delta * 1000
		if current_time > end_time:
			is_shaking = false
			position = starting_position
		else:
			var percentage:float = (current_time-start_time)/(end_time - start_time)
			var x:float = current_amplitude(percentage, samples_x)
			var y:float = current_amplitude(percentage, samples_y)
			position = starting_position + Vector2(x, y)
	pass

func shake(amplitude:int=10, frequency:int=60, duration:float=1.0) -> void:
	if !is_shaking:
		starting_position = position
		samples_x = create_samples(int(amplitude * G.game_scale), frequency, duration)
		samples_y = create_samples(int(amplitude * G.game_scale), frequency, duration)
		is_shaking = true
		start_time = Time.get_ticks_msec()
		end_time = start_time + duration * 1000
		current_time = start_time

func create_samples(amplitude:int, frequency:int, duration:float) -> Array:
	var sample_count:float = duration * frequency
	var samples:Array = Array()
	for i in sample_count:
		samples.append(randf_range(-amplitude, amplitude))
	return samples

func current_amplitude(percentage:float, samples:Array) -> float:
	var length:int = samples.size()
	var s:int = min(length * percentage, length-2)
	var s0:int = floori(s)
	var s1:int = s0 + 1
	return (samples[s0] + (s - s0)*(samples[s1] - samples[s0])) * (1 - percentage)

func flash(seconds:float) -> void:
	rect = ColorRect.new()
	rect.set_size(Vector2(G.gw, G.gh))
	rect.set_color(G.bg_color)
	root.add_child(rect)
	timer = Timer.new()
	timer.set_autostart(true)
	timer.set_wait_time(seconds)
	timer.timeout.connect(
		func() -> void:
			rect.queue_free()
			timer.queue_free()
	)
	add_child(timer)
