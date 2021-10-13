extends Area2D

const MOVE_SPEED = 200

var _ball_dir
var _up
var _down

var timer : Timer;
var poweredUp : bool;
var splitTheBall : bool;

onready var _screen_size_y = get_viewport_rect().size.y

func _ready():
	var n = String(name).to_lower()
	_up = n + "_move_up"
	_down = n + "_move_down"
	if n == "left":
		_ball_dir = 1
	else:
		_ball_dir = -1
	timer = get_node("Timeout_" + name)
	timer.wait_time = 10
	splitTheBall = true;
	


func _process(delta):
	# Move up and down based on input.
	var input = Input.get_action_strength(_down) - Input.get_action_strength(_up)
	position.y = clamp(position.y + input * MOVE_SPEED * delta, 16, _screen_size_y - 16)
	if poweredUp:
		get_node("Sprite").scale.y = 1.5
		get_node("Collision").scale.y = 1.5
		if timer.is_stopped():
			poweredUp = false
	elif timer.is_stopped():
		get_node("Sprite").scale.y = 1
		get_node("Collision").scale.y = 1
	#print(timer.time_left)
		
	if splitTheBall && timer.is_stopped():
		splitTheBall = false;
	

func _on_area_entered(area):
	if "Ball" in area.name:
		# Assign new direction.
		if !splitTheBall :
			area.direction = Vector2(_ball_dir, randf() * 2 - 1).normalized()
		else:
			var ball2 = load("res://logic/ball.gd").new();
			var ball3 = load("res://logic/ball.gd").new();
			ball2.name = "sBall2";
			ball3.name = "sBall3";
			ball2.set_position(area.position + Vector2(0,3))
			ball3.set_position(area.position + Vector2(0,-3))
			ball2.modulate = Color(0.4,0.4,0);
			ball3.modulate = Color(0.4,0.4,0);
			for i in range(0,area.get_child_count()):
			
				var temp;
			
			#print(powerUp.get_child(i).name)
			
				if area.get_child(i).name == "Sprite":
				
					temp = Sprite.new()
				#var texTemp = StreamTexture.new()
				#var texTemp = ImageTexture.new()
				#var img = Image.new()
				#img.load("res://ball.png")
				#temp.texture = ImageTexture.new()
				#texTemp.load("res://ball.png")
				#texTemp.load("res://ball.png")
				#texTemp.create_from_image(img)
				#temp.set_texture(texTemp)
					temp.set_texture(area.get_child(i).texture)
				#temp.texture.set("",texTemp)
				#temp.texture.load(powerUp.get_child(i).texture.resource_path)
				#temp.texture = powerUp.get_child(i).texture
				#temp.texture.set_data(powerUp.get_child(i).texture.get_data())
				#print(powerUp.get_child(i).texture.get_data())
				#print(temp.texture.resource_path)
				#temp.load(powerUp.get_child(i).get_load_path())
				
				elif area.get_child(i).name == "Collision":
				
					temp = CollisionShape2D.new()
				
					var shape = RectangleShape2D.new()
					shape.set_extents(area.get_child(i).shape.extents)
				
					temp.set_shape(shape)
				#print(temp.shape.extents)
				#temp.set_disabled(false)
				#temp.set_physics_process(true)
				
				ball2.add_child(temp)
			for i in range(0,area.get_child_count()):
			
				var temp;
			
			#print(powerUp.get_child(i).name)
			
				if area.get_child(i).name == "Sprite":
				
					temp = Sprite.new()
				#var texTemp = StreamTexture.new()
				#var texTemp = ImageTexture.new()
				#var img = Image.new()
				#img.load("res://ball.png")
				#temp.texture = ImageTexture.new()
				#texTemp.load("res://ball.png")
				#texTemp.load("res://ball.png")
				#texTemp.create_from_image(img)
				#temp.set_texture(texTemp)
					temp.set_texture(area.get_child(i).texture)
				#temp.texture.set("",texTemp)
				#temp.texture.load(powerUp.get_child(i).texture.resource_path)
				#temp.texture = powerUp.get_child(i).texture
				#temp.texture.set_data(powerUp.get_child(i).texture.get_data())
				#print(powerUp.get_child(i).texture.get_data())
				#print(temp.texture.resource_path)
				#temp.load(powerUp.get_child(i).get_load_path())
				
				elif area.get_child(i).name == "Collision":
				
					temp = CollisionShape2D.new()
				
					var shape = RectangleShape2D.new()
					shape.set_extents(area.get_child(i).shape.extents)
				
					temp.set_shape(shape)
				#print(temp.shape.extents)
				#temp.set_disabled(false)
				#temp.set_physics_process(true)
				
				ball3.add_child(temp)
			
			var scene = get_tree().root
			
			print(ball2.name);
			
			scene.add_child(ball2);
			scene.add_child(ball3);
			
			area.direction = Vector2(_ball_dir, randf() * 2 - 1).normalized()
			ball2.direction = Vector2(_ball_dir, randf() * 2 - 1).normalized()
			ball3.direction = Vector2(_ball_dir, randf() * 2 - 1).normalized()
			splitTheBall = false;
			timer.stop();
	if "PowerUp" in area.name:
		print("Hit")
		timer.start()
		poweredUp = true;
		
	if "Split" in area.name:
		splitTheBall = true;
		timer.start();
		
	if area.is_in_group("PowerUp"):
		
		area.queue_free();
		
		print("hello")
