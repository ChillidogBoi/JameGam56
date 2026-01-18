extends Sprite2D
class_name Customer

@export var id: String
## How much the customer is willing to pay
@export_custom(PROPERTY_HINT_NONE, "suffix:$") var wallet: int
## Seperated by &
@export_multiline var start_dialogue: String
@export_multiline var end_dialogue_yes: String
@export_multiline var end_dialogue_no: String
var last_line_delivered: int = 0
var dialogue_seperated: Array = []


func _ready():
	for n:int in start_dialogue.count("&") + 1:
		dialogue_seperated.append(start_dialogue.get_slice("&", n))

func request_next_dialogue() -> String:
	if dialogue_seperated.size() == last_line_delivered: return ""
	
	last_line_delivered += 1
	return str(id, "\n", dialogue_seperated[last_line_delivered -1])

func end_dia_setup(answer: bool):
	if answer:
		for n:int in start_dialogue.count("&") + 1:
			dialogue_seperated.append(start_dialogue.get_slice("&", n))
