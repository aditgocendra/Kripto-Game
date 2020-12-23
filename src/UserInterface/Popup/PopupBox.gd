extends TextureRect


var next_scene = null
var label = null
var reset_mission = false


func start_anim():
	$Label.text = label
	get_tree().paused = true
	$AnimationPlayer.play("start")


func _on_YesBtn_pressed():
# warning-ignore:return_value_discarded
	get_tree().paused = false
	
	if reset_mission:
		reset_quest()
		
	get_tree().change_scene(next_scene)


func _on_NoBtn_pressed():
	get_tree().paused = false
	$AnimationPlayer.play("close_popup")
	
	if reset_mission:
			get_tree().change_scene("res://src/UserInterface/Difficulty/Difficulty.tscn")

func reset_quest():
	var data = Autoload.loadData()
	var this_diff = Autoload.this_diffculty
	data["question"][this_diff] = Autoload.default_data["question"][this_diff]
	Autoload.save_data(data)


