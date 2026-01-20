extends Control

func _ready(): 
	Settings.helped = 0
	Settings.profit = 0.0
	Settings.scammed = []
	Settings.scammed_pic = []
	get_child(1).visible = false

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Code/MainGameScene.tscn")


func _on_gallery_pressed():
	get_child(0).visible = false
	get_child(1).visible = true

func _on_back_pressed():
	get_child(1).visible = false
	get_child(0).visible = true
