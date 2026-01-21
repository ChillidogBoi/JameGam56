extends Button


func _ready():
	_on_m_vol_changed(Settings.m_vol + 50)
	_on_s_vol_changed(Settings.s_vol + 50)
	$HBoxContainer/VBoxContainer/Control/VBoxContainer3/Button/HSlider.value = \
		Settings.m_vol + 50
	$HBoxContainer/VBoxContainer/Control/VBoxContainer3/Button4/HSlider.value = \
		Settings.s_vol + 50

func _on_pressed():
	if $HBoxContainer.visible == false:
		$"../TextureProgressBar/Timer".paused = true
		get_parent().paused = true
		$HBoxContainer.visible = true
		$AnimationPlayer.play("open")
	else: _on_button_pressed()

func _on_button_pressed():
	$AnimationPlayer.play("close")
	await $AnimationPlayer.animation_finished
	get_parent().paused = false
	get_parent().resume.emit()
	$HBoxContainer.visible = false
	$"../TextureProgressBar/Timer".paused = false

func _on_button_2_pressed():
	$HBoxContainer/VBoxContainer/Control/VBoxContainer.visible = false
	$HBoxContainer/VBoxContainer/Control/VBoxContainer3.visible = true

func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://Code/UI/main_menu.tscn")

func _on_m_vol_changed(value):
	$"../music".volume_db = value - 50
	Settings.m_vol = $"../music".volume_db

func _on_s_vol_changed(value):
	$"../sfx".volume_db = value - 50
	$"../Dialogue/beltese".volume_db = value - 65
	Settings.s_vol = $"../sfx".volume_db

func _on_button_4_pressed():
	$HBoxContainer/VBoxContainer/Control/VBoxContainer.visible = true
	$HBoxContainer/VBoxContainer/Control/VBoxContainer3.visible = false
