extends Control


onready var texture_progress = $Background/TextureProgress
onready var timer_progress = $TimerProgress
onready var loading_label = $Background/TextureProgress/LoadingLabel


func _ready():
	loading_label.set_visible_characters(0)

func _on_TimerProgress_timeout():
	if texture_progress.value < 100:
		texture_progress.value += 1
		timer_progress.start()
	else:
		$AnimationPlayer.play("out")
		timer_progress.stop()
		


func _on_TimerLoadingLabel_timeout():
	loading_label.set_visible_characters(loading_label.get_visible_characters() + 1) 
	if loading_label.visible_characters > 7 :
		timer_progress.start()
		$TimerLoadingLabel.stop()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "out":
		get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
