extends HBoxContainer

@onready var buttons: Array[Button] = [
	$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Button,
	$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Button2,
	$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Button3,
	$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer2/Button,
	$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer2/Button2,
	$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer2/Button3,
	$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer3/Button,
	$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer3/Button2,
	$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer3/Button3,
]
var big_pic_mode: bool = false

func big_pic(b:Button):
	for n in buttons:
		if n != b: n.visible = false
	big_pic_mode = true
	if buttons.find(b) < 3:
		$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer2.visible = false
		$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer3.visible = false
	elif buttons.find(b) < 6:
		$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer.visible = false
		$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer3.visible = false
	else:
		$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer2.visible = false
		$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer.visible = false

func _on_back_pressed():
	if big_pic_mode:
		for n in buttons:
			n.visible = true
		big_pic_mode = false
		$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer.visible = true
		$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer2.visible = true
		$VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer3.visible = true
	
	else: get_parent()._on_back_pressed()


func _on_button0_pressed():
	big_pic(buttons[0])
func _on_button_1_pressed():
	big_pic(buttons[1])
func _on_button_2_pressed():
	big_pic(buttons[2])
func _on_button_3_pressed():
	big_pic(buttons[3])
func _on_button_4_pressed():
	big_pic(buttons[4])
func _on_button_5_pressed():
	big_pic(buttons[5])
func _on_button_6_pressed():
	big_pic(buttons[6])
func _on_button_7_pressed():
	big_pic(buttons[7])
func _on_button_8_pressed():
	big_pic(buttons[8])
