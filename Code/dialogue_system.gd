extends PanelContainer

signal next
@export var label: Label


func reset():
	label.visible_characters = 0

func speak():
	for n in label.text.length():
		label.visible_characters += 1
		await get_tree().create_timer(0.01).timeout

func _on_continue_pressed():
	next.emit()
