extends Control

@export var image: TextureRect
@export var title: Label
@export var blurb: Label

func _ready():
	_on_button_pressed()

func news_blurb():
	var tmp1 = Settings.scammed.pop_front()
	if tmp1.contains("&"):
		title.text = tmp1.get_slice("&", 0)
		blurb.text = tmp1.get_slice("&", 1)
	
	var tmp2 = Settings.scammed_pic.pop_front()
	if tmp2 != null: image = tmp2


func _on_button_pressed():
	if Settings.scammed.is_empty(): get_tree().change_scene_to_file("res://Code/UI/main_menu.tscn")
	else: news_blurb()
	
