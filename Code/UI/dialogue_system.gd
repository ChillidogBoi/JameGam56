extends PanelContainer

signal next
@export var label: Label


func reset(id: String):
	label.visible_characters = id.length()

func speak():
	for n in label.text.length():
		label.visible_characters += 1
		
		if label.text.length() > label.visible_characters:
			var t=str("res://Sound/Beltese/",label.text[label.visible_characters].to_upper(),"_1.wav")
			if FileAccess.file_exists(t):
				$beltese.stream = load(t)
				$beltese.play()
			
		await get_tree().create_timer(0.01).timeout

func _on_continue_pressed():
	if label.visible_characters > label.text.length() - 4: next.emit()
