extends PanelContainer

signal next
@export var label: Label


func _on_continue_pressed():
	next.emit()
