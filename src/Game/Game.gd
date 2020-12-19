extends Node

#instance scene ---------------------------------------------------------------------
onready var character = preload("res://src/Game/Character/Character.tscn").instance()
#------------------------------------------------------------------------------------

#instance node -----------------------------------------------
onready var alfhabet_container = $DangerRect/AlfhabetContainer
onready var transition = $DangerRect/Transition
onready var hint_label = $DangerRect/BoxDialog/Hint
#-------------------------------------------------------------

# instance variabel---------------------------
var answer = null
var hint = null
var clue = null
var id_quest = null


var string_count = null
var active_char_node = null

#display value timer
var display_value = null
#--------------------------------------------

func _ready():
# warning-ignore:return_value_discarded
	Autoload.connect("pressed_character", self, "_change_character_active")
	alfhabet_container.connect("alfha_pressed", self, "_change_character_alfha")
	set_question()
	
	if id_quest != null:
		string_count = answer.length()
		set_label_hint()
		add_character_node()
		transition.trans_in()
		$TimeLeft.start()


func add_character_node():
	# clue null is hard diffculty------------
	if clue == null :
		clue = Shuffle.fisher_yates_string(answer)
	#-----------------------------------------
	
	for i in range(string_count):
		var new_character = character.duplicate()
		new_character.text = clue[i]
		$DangerRect/ContainerCharacter.add_child(new_character)


func _change_character_active(object):
	$CharacterClick.play()
	var count_char = $DangerRect/ContainerCharacter.get_child_count()
	active_char_node = object 
	for i in range(count_char):
		var char_alfha = $DangerRect/ContainerCharacter.get_child(i)
		if char_alfha != object:
#			char_alfha.get_stylebox("normal").border_color = Color(1,1,0)
			var new_style_box = char_alfha.get_stylebox("normal").duplicate()
			new_style_box.border_color = Color(0.8, 0.8, 0.8) 
			char_alfha.add_stylebox_override("normal", new_style_box)


func _change_character_alfha(alfhabet):
	$AlfhabetClick.play()
	if active_char_node != null:
		active_char_node.play_particle()
		active_char_node.text = alfhabet


func _on_Enter_pressed():
	var char_alfha = []
	var count_child = $DangerRect/ContainerCharacter.get_child_count()
	
	for i in range(count_child):
		var node = $DangerRect/ContainerCharacter.get_child(i)
		char_alfha.append(node.text)
		
	#string join
	var string_join = PoolStringArray(char_alfha).join("")
	
	#check true or false quiz
	if string_join == answer:
		quest_complete()
	else: 
		Autoload.emit_signal("false_answer")
		


func _on_TimeLeft_timeout():
	if display_value == 0:
		get_tree().paused = true
		transition.trans_lose()
	else:
		display_value -= 1
		$DangerRect/LabelTimer.text = "Time Left : " + str(display_value)
		$TimeLeft.start()
		
	if display_value <= 15:
		$AnimationPlayer.play("danger_time")


# get quest from data in database json
func get_question():
	var data = Autoload.loadData()
	var question = []
	
	#get data from question in easy diff
	#change data quest from dictionary to array object
	var diff_set = Autoload.this_diffculty
	if diff_set == null:
		diff_set = "easy"
	var data_quest = data["question"][diff_set].values()
	
	#shuffle quest used fisher yates 
	var shuffle_quest = Shuffle.fisher_yates_quest(data_quest)
	
	#check quest if not complete append to question
	for i in range(shuffle_quest.size()):
		if not shuffle_quest[i]["solve"]:
			question.append(shuffle_quest[i])
			break
	
	return question


# set quest
func set_question():
	#get quest from func get_question()
	var quest = get_question()
	
	
	# if quest true then all quest finish
	# else set question 
	if quest.empty():
		print("pass")
	else:
		answer = quest[0]["answer"]
		clue = quest[0]["clue"]
		hint = quest[0]["hint"]
		display_value = quest[0]["time"]
		id_quest = quest[0]["id_quest"]
	
	
func quest_complete():
	var current_quest = Autoload.loadData()
	current_quest["question"]["easy"][str(id_quest)]["solve"] = true
	Autoload.save_data(current_quest)
	
	Autoload.emit_signal("true_answer")
	$TrueAnswerTimer.start()
	

func _on_TrueAnswerTimer_timeout():
	$TimeLeft.stop()
	get_tree().paused = true


func set_label_hint():
	hint_label.set_bbcode(hint)
	hint_label.set_visible_characters(0)


func _on_DialogTimer_timeout():
	hint_label.set_visible_characters(hint_label.get_visible_characters() + 1) 


func _on_BackButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/Difficulty/Difficulty.tscn")


func _on_ResetClue_pressed():
	var all_character_count = $DangerRect/ContainerCharacter.get_child_count()
	for i in range(all_character_count):
		var char_alfha = $DangerRect/ContainerCharacter.get_child(i)
		char_alfha.text = clue[i]


func _on_MainMenuBtn_pressed():
# warning-ignore:return_value_discarded
	$PopupBox.next_scene = "res://src/UserInterface/MainMenu/MainMenu.tscn"
	$PopupBox.start_anim()
