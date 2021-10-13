extends Area2D

var score = 0;

var scoreDisp : Label;
var dir;

func _on_wall_area_entered(area):
	if area.name == "Ball":
		#oops, ball went out of game place, reset
		area.reset()
		
		score += 1;
	if "sBall" in area.name:
		
		score += 2;
		
		

func _ready():
	
	scoreDisp = get_child(1);
	

func _process(delta):
	scoreDisp.text = String(score);


