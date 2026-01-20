extends Sprite2D
class_name Customer

@export var id: String
## How much the customer is willing to pay
@export_custom(PROPERTY_HINT_NONE, "suffix:$") var wallet: int
@export_enum("Cheap Belt", "Solid Belt", "Retro Belt", "Fancy Belt", "Gold Belt", "Fix", "Replacement", "Any") \
	var wants: int = 6
@export_enum("Cheap Belt", "Solid Belt", "Retro Belt", "Fancy Belt", "Gold Belt", "Fix", "Replacement", "Any") \
	var allowed: Array[int]
	
@export var my_belt: Texture2D
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var wait_time: float
@export_custom(PROPERTY_HINT_RANGE, "0,100, suffix:%") var fix_works: int
@export_custom(PROPERTY_HINT_NONE, "suffix:$") var replace_price: int
## Seperated by &
@export_multiline var start_dialogue: String
@export_multiline var end_dialogue_yes: String
@export_multiline var end_dialogue_no_exp: String
@export_multiline var end_dialogue_no_wrng: String
@export_multiline var end_dialogue_no_tim: String
@export_multiline var news_scammed: String
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

func end_dia_setup(answer: bool, scam: bool, reason: int = 0):
	if scam: Settings.scammed.append(news_scammed)
	if answer:
		for n:int in end_dialogue_yes.count("&") + 1:
			dialogue_seperated.append(end_dialogue_yes.get_slice("&", n))
		return
	
	match reason:
		0:
			for n:int in end_dialogue_no_exp.count("&") + 1:
				dialogue_seperated.append(end_dialogue_no_exp.get_slice("&", n))
		1:
			for n:int in end_dialogue_no_wrng.count("&") + 1:
				dialogue_seperated.append(end_dialogue_no_wrng.get_slice("&", n))
		2:
			for n:int in end_dialogue_no_tim.count("&") + 1:
				dialogue_seperated.append(end_dialogue_no_tim.get_slice("&", n))
