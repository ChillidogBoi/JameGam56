extends Button


func _on_pressed():
	$"../UI".paused = true
	$PanelContainer.visible = true


func _on_button_pressed():
	$"../Node2D/Player/Label".text = $PanelContainer/HBoxContainer/LineEdit.text
	$"../UI".paused = false
	$PanelContainer.visible = false
	$"../UI".resume.emit()
