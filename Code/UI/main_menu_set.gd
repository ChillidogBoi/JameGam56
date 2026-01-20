extends Button


func _ready():
	$"../../AudioStreamPlayer".volume_db = Settings.m_vol
	$"../../HBoxContainer/VBoxContainer/Control/VBoxContainer3/Button/HSlider".value = \
		Settings.m_vol + 50
	$"../../HBoxContainer/VBoxContainer/Control/VBoxContainer3/Button4/HSlider".value = \
		Settings.s_vol + 50

func _on_pressed():
	$"../../HBoxContainer".visible = true
	$AnimationPlayer.play("open")

func _on_button_pressed():
	$AnimationPlayer.play("open_2")
	await $AnimationPlayer.animation_finished
	$"../../HBoxContainer".visible = false

func _on_m_vol_changed(value):
	$"../../AudioStreamPlayer".volume_db = value - 50
	Settings.m_vol = $"../../AudioStreamPlayer".volume_db

func _on_s_vol_changed(value):
	Settings.s_vol = value - 50
