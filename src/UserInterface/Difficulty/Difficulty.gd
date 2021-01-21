extends Control

onready var fader = $Fader
var next_scene = null


func _ready():
	fader.connect("finish_fade_in", self, "_on_finish_fade_in")
	fader.fade_out()


func _on_Easy_pressed():
	next_scene = "res://src/Game/Game.tscn"
	Autoload.this_diffculty = "easy"
	fader.fade_in()
		

func _on_MediumButton_pressed():
	next_scene = "res://src/Game/Game.tscn"
	Autoload.this_diffculty = "medium"
	fader.fade_in()

func _on_finish_fade_in():
	# warning-ignore:return_value_discarded
		get_tree().change_scene(next_scene)


func _on_HardButton_pressed():
	next_scene = "res://src/Game/Game.tscn"
	Autoload.this_diffculty = "hard"
	fader.fade_in()


func _on_BackButton_pressed():
	next_scene = "res://src/UserInterface/MainMenu/MainMenu.tscn"
	Autoload.this_diffculty = "hard"
	fader.fade_in()
