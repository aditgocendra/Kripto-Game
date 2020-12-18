extends Node


signal pressed_character(object)

#signal answer------------
signal false_answer
signal true_answer
#-------------------------

onready var this_diffculty = null

var db_path = "res://Autoload/database.json"
var _file
var json_data

var default_data = {
		  "question": {
			"easy": {
			  "1": {
				"id_quest": 1,
				"hint": "ROT 10",
				"problem": "dkhtyd",
				"answer": "nurdin",
				"solve": false,
				"time" : 60
			  },
			  "2": {
				"id_quest": 2,
				"hint": "ROT 13",
				"problem": "qvgun",
				"answer": "ditha",
				"solve": false,
				"time": 30
			  }
			}
		  }
		}
	
	



func loadData():
	_file = File.new()
		
	if not _file.file_exists(db_path):
		save_data(default_data)
		return default_data
	else:
		_file.open(db_path, File.READ)
		
		json_data = parse_json(_file.get_as_text())
		
		if json_data.size() > 0:
			return json_data


func save_data(new_data):
	_file = File.new()
	
	_file.open(db_path, File.WRITE)
	_file.store_line(to_json(new_data))
	_file.close()
