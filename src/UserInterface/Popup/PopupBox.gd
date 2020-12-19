extends TextureRect


var next_scene = null


func start_anim():
	$AnimationPlayer.play("start")




func _on_YesBtn_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(next_scene)


func _on_NoBtn_pressed():
	$AnimationPlayer.play("close_popup")
