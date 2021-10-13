extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var powerUp;

var timer : Timer;

var rng : RandomNumberGenerator;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	powerUp = get_parent().get_node("PowerUp")
	
	print(get_parent().get_node("PowerUp").name)
	
	if powerUp.name == "PowerUp":
		
		print("Done!!")
		
	timer = get_node(("PPTimer"))
	timer.wait_time = 5
	timer.start();
	
	rng = RandomNumberGenerator.new()
	
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer.is_stopped():
		var newPU = load("res://PowerUp.gd").new()
		#newPU.add_to_group("PowerUP")
		if(rng.randi_range(0,1) == 1):
			newPU.name = "PowerUp"
			newPU.modulate = Color(0,1,0);
		else:
			newPU.name = "Split"
			newPU.modulate = Color(0,0.4,0.7);
		for i in range(0,powerUp.get_child_count() - 1):
			
			var temp;
			
			#print(powerUp.get_child(i).name)
			
			if powerUp.get_child(i).name == "Sprite":
				
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
				temp.set_texture(powerUp.get_child(i).texture)
				#temp.texture.set("",texTemp)
				#temp.texture.load(powerUp.get_child(i).texture.resource_path)
				#temp.texture = powerUp.get_child(i).texture
				#temp.texture.set_data(powerUp.get_child(i).texture.get_data())
				#print(powerUp.get_child(i).texture.get_data())
				#print(temp.texture.resource_path)
				#temp.load(powerUp.get_child(i).get_load_path())
				
			elif powerUp.get_child(i).name == "PowerUpColl":
				
				temp = CollisionShape2D.new()
				
				var shape = RectangleShape2D.new()
				shape.set_extents(powerUp.get_child(i).shape.extents)
				
				temp.set_shape(shape)
				#print(temp.shape.extents)
				#temp.set_disabled(false)
				#temp.set_physics_process(true)
				
			newPU.add_child(temp)
			
			
			
		#newPU.name = "newP"
		
		var scene = get_tree().root
		scene.add_child(newPU)
		#powerUp.set_position(Vector2(position.x,position.y))
		newPU.set_position(Vector2(position.x,position.y + rng.randi_range(0,400)));
		newPU.set_isAGo(true);
		#newPU.isAGo = true
		
		#$newP.isAGo = true
		print("Done spawning!!")
		timer.start();
	#print(timer.time_left)
