extends Control

func _ready():
	$transition/AnimationPlayer.play("fade_left_end")


func _on_TouchScreenButton_pressed():
	$transition/AnimationPlayer.play("fade_right_start")
	yield(get_tree().create_timer(0.6),"timeout")
	if get_tree().change_scene("res://Scenes/Main.tscn") == OK:
		pass
	else:
		print("Error changing Scene")