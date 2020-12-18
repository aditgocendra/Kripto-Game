extends Control


onready var fader = $Fader


func _ready():
	fader.connect("finish_fade_in", self, "_on_Fade_IN_Finish")
	fader.fade_out()


func _on_StartBtn_pressed():
	fader.fade_in()


func _on_Fade_IN_Finish():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/Difficulty/Difficulty.tscn")


func _on_SettingBtn_pressed():
	get_tree().change_scene("res://src/UserInterface/Settings/Settings.tscn")
