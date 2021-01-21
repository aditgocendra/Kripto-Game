extends Node


signal pressed_character(object)

#signal answer------------
signal false_answer
signal true_answer
#-------------------------

onready var this_diffculty = null

var db_path = "user://database.json"
#var db_path = "res://Autoload/database.json"
var _file
var json_data

var default_data = {
  "game_settings": {
	"sound": {
	  "backsound": true,
	  "sound_fx": true
	}
  },
  "question": {
	"easy": {
	  "1": {
		"answer": "moshing",
		"clue": "wycrsxq",
		"hint": "Cukup geser aja sebanyak 10 huruf kebelakang atau mundur gausah lebih",
		"id_quest": 1,
		"solve": false,
		"time": 60
	  },
	  "2": {
		"answer": "coding",
		"clue": "rdsxcv",
		"hint": "Hmm kali ini 15 aja ngga kurang ngga lebih. ' ROT 15 '",
		"id_quest": 2,
		"solve": false,
		"time": 60
	  },
	  "3": {
		"answer": "postman",
		"clue": "xwabuiv",
		"hint": "Mundur delapan langkah gerak",
		"id_quest": 3,
		"solve": false,
		"time": 60
	  }
	},
	"hard": {
	  "1": {
		"answer": "kripto",
		"clue": null,
		"hint": "Null Cipher + Enter............,,keris raja itali patah tiga oktober",
		"id_quest": 1,
		"solve": false,
		"time": 60
	  },
	  "2": {
		"answer": "bendera",
		"clue": null,
		"hint": "Arti dari bahasa inggris,7 huruf.....,, kriptografI merupakaN sebuah kategori darI perlomBaan hacking ataU\n\n         biasa diKenal sebagai cApture the flag, capture sendiri berarti\n\n         meNangkap, sedangkan Flag adalah bendera. namun artian sebenarnya\n\n         dari capture the fLag sendiri adalah sebuAh perlombaan hackinG yang\n\n         dimana peserta dituntut untuk mencari sebuah flag yang sudah\n\n         disisipkan oleh panitia dalam sebuah celah keamanan.",
		"id_quest": 2,
		"solve": false,
		"time": 90
	  }
	},
	"medium": {
	  "1": {
		"answer": "caesar",
		"clue": "hfjxfw",
		"hint": "Caesar Cipher Key 5",
		"id_quest": 1,
		"solve": false,
		"time": 60
	  },
	  "2": {
		"answer": "ganteng",
		"clue": "frdwcxa",
		"hint": "!=1, @=2, A =1, Z=26/Letter Number, , dapatkah kamu menterjemahkan yang ini& ! !$ @) % !$ & ",
		"id_quest": 2,
		"solve": false,
		"time": 60
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
