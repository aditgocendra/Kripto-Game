extends Node

# algorithm fisher yates---------------
# shuffle index last to generate random index number
# end algorithm fisher yates-----------------------------------------------------


func _ready():
	# generate random value
	randomize()
	
#fisher yates algorithm shuffle 
func fisher_yates_quest(data):
	var temp
	
	var current_index = data.size() - 1
	var size_random = data.size() - 1
	
	for _i in range(data.size()):
		var random_number = randi() % size_random
		
		temp = data[random_number]
		data[random_number] = data[current_index]
		data[current_index] = temp
		
		current_index -= 1
		
	return data


func fisher_yates_string(data):
	var array_string = []
	for c in data:
		array_string.append(c)

	var temp
	
	var current_index = array_string.size() - 1
	var size_random = array_string.size() - 1
	
	for _i in range(array_string.size()):
		var random_number = randi() % size_random
		
		temp = data[random_number]
		array_string[random_number] = array_string[current_index]
		array_string[current_index] = temp
		
		current_index -= 1
		
	return array_string
