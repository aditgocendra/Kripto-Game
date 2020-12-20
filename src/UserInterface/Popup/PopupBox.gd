extends TextureRect


var next_scene = null
var label = null

func start_anim():
	$Label.text = label
	get_tree().paused = true
	$AnimationPlayer.play("start")


func _on_YesBtn_pressed():
# warning-ignore:return_value_discarded
	get_tree().paused = false
	get_tree().change_scene(next_scene)


func _on_NoBtn_pressed():
	get_tree().paused = false
	$AnimationPlayer.play("close_popup")
