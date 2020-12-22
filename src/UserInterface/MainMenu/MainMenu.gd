extends Control


onready var fader = $Fader


func _ready():
	$AnimationPlayer.play("play_button")
	$AnimationPlayer2.play("setting_btn")
	$AnimationPlayer3.play("exit_btn")
	fader.connect("finish_fade_in", self, "_on_Fade_IN_Finish")
	fader.fade_out()
	sound_setup()

func _on_StartBtn_pressed():
	fader.fade_in()


func _on_Fade_IN_Finish():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/Difficulty/Difficulty.tscn")


func _on_SettingBtn_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/Settings/Settings.tscn")


func _on_Quitbtn_pressed():
	get_tree().quit()


func sound_setup():
	var data = Autoload.loadData()
	var backsound = data["game_settings"]["sound"]["backsound"]
	
	if backsound:
		$Backsound.play()
	
	
	
	
	
	
	
