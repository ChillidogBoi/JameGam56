extends Button


func _on_pressed():
	$"../UI".paused = true
	$"../UI/TextureProgressBar/Timer".paused = true
	$PanelContainer.visible = true


func _on_button_pressed():
	$"../Node2D/Player/Label".text = $PanelContainer/HBoxContainer/LineEdit.text
	$PanelContainer/HBoxContainer/LineEdit.text = ""
	$"../UI".paused = false
	$"../UI/TextureProgressBar/Timer".paused = false
	$PanelContainer.visible = false
	$"../UI".resume.emit()
