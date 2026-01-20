extends Control

func _ready(): 
	Settings.helped = 0
	Settings.profit = 0.0
	Settings.scammed = []
	Settings.scammed_pic = []
	$Gallery.visible = false
	await get_tree().create_timer(0.01).timeout
	$Gallery/VBoxContainer/PanelContainer/VBoxContainer.visible = true

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Code/MainGameScene.tscn")


func _on_gallery_pressed():
	$Main.visible = false
	$Gallery.visible = true
	

func _on_back_pressed():
	$Gallery.visible = false
	$Main.visible = true
