extends Label


var style_box

func _ready():
# warning-ignore:return_value_discarded
	Autoload.connect("false_answer", self, "_anim_false_play")
# warning-ignore:return_value_discarded
	Autoload.connect("true_answer", self, "_anim_true_play")
	style_box = self.get_stylebox("normal")

func border_pressed():
#	self.get_stylebox("normal").border_color = Color(1,1,0)
	var new_style_box = get_stylebox("normal").duplicate()
	new_style_box.border_color = Color(1, 1, 0) 

	self.add_stylebox_override("normal", new_style_box)


func _on_Character_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			border_pressed()
			Autoload.emit_signal("pressed_character", self)


func _anim_false_play():
	self.add_stylebox_override("normal", style_box)
	$AnimationPlayer.play("false_answer_player")


func _anim_true_play():
	self.add_stylebox_override("normal", style_box)
	$AnimationPlayer.play("true_answer_player")


func play_particle():
	$AnimationPlayer.play("change_alfhabet")
