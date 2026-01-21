extends Control

@export var image: TextureRect
@export var title: Label
@export var blurb: Label
@export var result: Label
@export var profit: Label
@export var scammed: Label
@export var helped: Label

func _ready():
	if Settings.profit < 0: result.text = "You're In Debt!"
	elif Settings.profit < 300: result.text = "You Got Fired!"
	else: result.text = "You Survived The Day!"
	profit.text = str("Money Made: $", Settings.profit)
	scammed.text = str("Customers Scammed: ", Settings.scammed.size())
	helped.text = str("Customers Helped: ", Settings.helped)
	$Sprite2D/AnimationPlayer.play("grow")
	await $Sprite2D/AnimationPlayer.animation_finished
	_on_button1_pressed()

func news_blurb():
	var tmp1 = Settings.scammed.pop_front()
	if tmp1.contains("&"):
		title.text = tmp1.get_slice("&", 0)
		blurb.text = tmp1.get_slice("&", 1)
	
	var tmp2 = Settings.scammed_pic.pop_front()
	if tmp2 != null: image = tmp2


func _on_button_pressed():
	$Sprite2D/AnimationPlayer.play("shrink")
	await $Sprite2D/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Code/UI/main_menu.tscn")

func _on_button1_pressed():
	$sfx.play()
	if Settings.scammed.is_empty():
		$HBoxContainer.visible = false
		$HBoxContainer2.visible = true
	else: news_blurb()
