extends Control



func _ready():
	$AnimationPlayer.play("loading")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "loading":
		get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
