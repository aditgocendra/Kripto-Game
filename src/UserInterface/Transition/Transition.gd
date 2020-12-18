extends ColorRect

func trans_in():
	$AnimationPlayer.play("transition_in")
	
func trans_out():
	$AnimationPlayer.play("transition_out")

func trans_lose():
	$AnimationPlayer.play("trans_lose")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "trans_lose":
		get_tree().paused = false
		get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
