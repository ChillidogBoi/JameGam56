extends PanelContainer

signal next
@export var label: Label


func reset(id: String):
	label.visible_characters = id.length()

func speak():
	for n in label.text.length():
		label.visible_characters += 1
		await get_tree().create_timer(0.01).timeout

func _on_continue_pressed():
	if label.visible_characters > label.text.length() - 4: next.emit()
