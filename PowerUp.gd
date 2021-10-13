extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isAGo : bool;

var timeout : Timer;

var rng : RandomNumberGenerator;

var dir;
# Called when the node enters the scene tree for the first time.
func _ready():
	
	isAGo = false;
	
	timeout = Timer.new()
	timeout.name = "timer"
	timeout.set_one_shot(true)
	timeout.set_wait_time(400)
	add_child(timeout)
	rng = RandomNumberGenerator.new();
	rng.randomize()
	dir = rng.randi_range(1,-1);
	self.add_to_group("PowerUp");
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if dir == 0:
		dir = rng.randi_range(-1,1)
	
	if isAGo:
		if !timeout.is_stopped():
			position.x += 250 * delta * dir
		elif timeout.is_stopped():
			queue_free()
		
	

func set_isAGo(val):
	
	isAGo = val
	timeout.start()

func _on_area_entered(area):
	
	queue_free()
	

#func _set_position(pos):
	
	#_set_position(pos)


func _on_PowerUp_area_entered(area):
	if area.is_in_group("Paddle"):
		queue_free()
		print("hi")
