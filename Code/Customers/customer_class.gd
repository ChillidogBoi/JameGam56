extends Sprite2D
class_name Customer

@export var id: String
## How much the customer is willing to pay
@export_custom(PROPERTY_HINT_NONE, "suffix:$") var wallet: int
@export_enum("Cheap Belt", "Red Belt", "Normal Belt", "Expensive Belt", "Fix", "Replacement", "Any") \
	var wants: int = 6
@export_custom(PROPERTY_HINT_RANGE, "0,100, suffix:%") var fix_works: int
@export_custom(PROPERTY_HINT_NONE, "suffix:$") var replace_price: int
## Seperated by &
@export_multiline var start_dialogue: String
@export_multiline var end_dialogue_yes: String
@export_multiline var end_dialogue_no: String
@export var anims: AnimationPlayer
var last_line_delivered: int = 0
var dialogue_seperated: Array = []



func _ready():
	last_line_delivered = 0
	dialogue_seperated = []
	for n:int in start_dialogue.count("&") + 1:
		dialogue_seperated.append(start_dialogue.get_slice("&", n))

func request_next_dialogue() -> String:
	if dialogue_seperated.size() == last_line_delivered:
		print(dialogue_seperated)
		return ""
	
	last_line_delivered += 1
	return str(id, "\n", dialogue_seperated[last_line_delivered -1])

func end_dia_setup(answer: bool, scam: bool):
	Settings.scammed.append(scam)
	if answer:
		for n:int in end_dialogue_yes.count("&") + 1:
			dialogue_seperated.append(end_dialogue_yes.get_slice("&", n))
		return
	for n:int in end_dialogue_no.count("&") + 1:
		dialogue_seperated.append(end_dialogue_no.get_slice("&", n))
