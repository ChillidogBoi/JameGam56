extends Control

func _ready(): 
	Settings.helped = 0
	Settings.profit = 0.0
	Settings.scammed = []
	Settings.scammed_pic = []
	$Gallery.visible = false
	$Sprite2D/AnimationPlayer.play("grow")
	await $Sprite2D/AnimationPlayer.animation_finished
	$Gallery/VBoxContainer/PanelContainer/VBoxContainer.visible = true

func _on_play_pressed():
	$Sprite2D/AnimationPlayer.play("shrink")
	await $Sprite2D/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Code/MainGameScene.tscn")


func _on_gallery_pressed():
	$Main.visible = false
	$Gallery.visible = true
	

func _on_back_pressed():
	$Gallery.visible = false
	$Main.visible = true
