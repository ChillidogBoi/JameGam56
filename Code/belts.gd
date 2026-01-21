extends Control

@export var marker: BaseButton
@onready var main = get_parent()

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

func _on_gold_belt_mouse_entered():
	$"../../Node2D/Player/Face/tense".visible = true
func _on_gold_belt_mouse_exited():
	$"../../Node2D/Player/Face/tense".visible = false
func _on_price_marker_mouse_entered():
	$"../../Node2D/Player/Face/tense".visible = true
func _on_price_marker_mouse_exited():
	$"../../Node2D/Player/Face/tense".visible = false
