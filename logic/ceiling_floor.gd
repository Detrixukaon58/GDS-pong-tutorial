extends Area2D

export var _bounce_direction = 1

func _on_area_entered(area):
	if "Ball" in area.name:
		area.direction = (area.direction + Vector2(0, _bounce_direction)).normalized()
