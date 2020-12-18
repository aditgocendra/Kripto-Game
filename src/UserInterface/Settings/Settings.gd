extends Control

onready var check_backsound = $SoundContainer/BacksoundContainer/CheckBoxBacksound
onready var check_sfx = $SoundContainer/SFXContainer/CheckBoxSFX


var game_sett
var data

func _ready():
	data = Autoload.loadData()
	game_sett = data["game_settings"]
	set_game_setting()

func set_game_setting():
	var backsound = game_sett["sound"]["backsound"]
	var sfx = game_sett["sound"]["sound_fx"]
	
	if backsound:
		check_backsound.pressed = true
		check_backsound.text = "ON"
		
	if sfx:
		check_sfx.pressed = true
		check_sfx.text = "ON"
		

func _on_CheckBoxBacksound_pressed():
	var label = check_backsound.text
	if label == "OFF":
		check_backsound.text = "ON"
	else : check_backsound.text = "OFF"


func _on_CheckBoxSFX_pressed():
	var label = check_sfx.text
	if label == "OFF":
		check_sfx.text = "ON"
	else : check_sfx.text = "OFF"


func _on_Back_pressed():
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")


func _on_Apply_pressed():
	if check_backsound.pressed:
		data["game_settings"]["sound"]["backsound"] = true
	else : data["game_settings"]["sound"]["backsound"] = false
	
	if check_sfx.pressed:
		data["game_settings"]["sound"]["sound_fx"] = true
	else : data["game_settings"]["sound"]["sound_fx"] = false
	
	Autoload.save_data(data)
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
