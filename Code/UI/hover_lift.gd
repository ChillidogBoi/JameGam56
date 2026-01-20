extends Control

const gray = [
	preload("res://Art/UI/start_gray.png"),
	preload("res://Art/UI/settings_gray.png"),
	preload("res://Art/UI/gallery_gray.png")
]
const selected = [
	preload("res://Art/UI/start_selected.png"),
	preload("res://Art/UI/settings_selected.png"),
	preload("res://Art/UI/gallery_selected.png")
]
@onready var nodes: Array[TextureRect] = [
	$TextureRect,
	$TextureRect2,
	$TextureRect3
]

func hover(i:int, m:bool):
	if m: nodes[i].texture = selected[i]
	else: nodes[i].texture = gray[i]

func _on_start_mouse_entered():
	hover(0, true)
func _on_start_mouse_exited():
	hover(0, false)
func _on_settings_mouse_entered():
	hover(1, true)
func _on_settings_mouse_exited():
	hover(1, false)
func _on_gallery_mouse_entered():
	hover(2, true)
func _on_gallery_mouse_exited():
	hover(2, false)
