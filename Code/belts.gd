extends Control

@export var marker: BaseButton
@onready var main = get_parent()
const MARKER_SOUND_01 = preload("uid://dx4q81vsyt7r")
const BELT_SOUND_01 = preload("uid://da6nfjo2q3pu8")
const CLICK_SOUND_01 = preload("uid://cc5dvjl4wqkse")

func belt_pressed(type: int):
	if marker.button_pressed:
		await main.change_price(type)
		marker.button_pressed = false
	else: main.sell(type)

func _on_cheap_belt_pressed():
	belt_pressed(0)
func _on_red_belt_pressed():
	belt_pressed(1)
func _on_normal_belt_pressed():
	belt_pressed(2)
func _on_expensive_belt_pressed():
	belt_pressed(3)
func _on_gold_belt_pressed():
	belt_pressed(4)

func _on_price_marker_pressed():
	$"../sfx".stream = MARKER_SOUND_01
	$"../sfx".play()

func _on_cheap_belt_mouse_entered():
	$"../../Node2D/Player/Face/tense".visible = true
	$"../sfx".stream = BELT_SOUND_01
	$"../sfx".play()
func _on_cheap_belt_mouse_exited():
	$"../../Node2D/Player/Face/tense".visible = false
func _on_gold_belt_mouse_entered():
	$"../../Node2D/Player/Face/tense".visible = true
	$"../sfx".stream = BELT_SOUND_01
	$"../sfx".play()
func _on_gold_belt_mouse_exited():
	$"../../Node2D/Player/Face/tense".visible = false
func _on_price_marker_mouse_entered():
	$"../../Node2D/Player/Face/tense".visible = true
	$"../sfx".stream = MARKER_SOUND_01
	$"../sfx".play(1.3)
func _on_price_marker_mouse_exited():
	$"../../Node2D/Player/Face/tense".visible = false

func _on_solid_belt_mouse_entered():
	$"../sfx".stream = BELT_SOUND_01
	$"../sfx".play()
func _on_retro_belt_mouse_entered():
	$"../sfx".stream = BELT_SOUND_01
	$"../sfx".play()
func _on_fancy_belt_mouse_entered():
	$"../sfx".stream = BELT_SOUND_01
	$"../sfx".play()
func _on_replacement_mouse_entered():
	$"../sfx".stream = BELT_SOUND_01
	$"../sfx".play()

func _input(event):
	if not event is InputEventMouseButton: return
	if event.button_index > 1 or event.pressed == false: return
	$"../sfx".stream = CLICK_SOUND_01
	$"../sfx".play()
	print(event)
