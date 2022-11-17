extends Control

var add_name
var sex


func _ready():
	$Name.text = "Name"
	$Name.get_font("font").set_size(150)
	$EnterName.visible = true
	$transition/AnimationPlayer.play("fade_left_end")

func _on_TouchScreenButton_pressed():
	if (add_name == null) and ($EnterName/LineEdit.text != ""):
		
		$transition/AnimationPlayer.play("fade_left_start")
		yield(get_tree().create_timer(0.6),"timeout")

		add_name = $EnterName/LineEdit.text

		$Name.text = "Geschlecht"
		$Name.get_font("font").set_size(110)
		$EnterName.visible = false
		$SelectSex.visible = true
		$transition/AnimationPlayer.play("fade_left_end")
	elif add_name != null:
		$transition/AnimationPlayer.play("fade_left_start")
		yield(get_tree().create_timer(0.6),"timeout")
		sex = $SelectSex/ItemList.get_selected_items()[0]
		
		
		Global.players[Global.players.size()] = {
			"name" : add_name,
			"sex" : identify_sex(sex),
			"level" : 0
		}
		
		
		
		if get_tree().change_scene("res://Scenes/Player.tscn") == OK:
			pass
		else:
			print("error loading Scene")

func identify_sex(sex_id):
	if sex_id == 0:
		return "male"
	elif sex_id == 1:
		return "female"
