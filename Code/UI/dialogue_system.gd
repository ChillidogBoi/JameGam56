extends PanelContainer

signal next
@export var label: Label

const beltese = [
	preload("res://Sound/Beltese/A_1.wav"),
	preload("res://Sound/Beltese/B_1.wav"),
	preload("res://Sound/Beltese/C_1.wav"),
	preload("res://Sound/Beltese/D_1.wav"),
	preload("res://Sound/Beltese/E_1.wav"),
	preload("res://Sound/Beltese/F_1.wav"),
	preload("res://Sound/Beltese/G_1.wav"),
	preload("res://Sound/Beltese/H_1.wav"),
	preload("res://Sound/Beltese/I_1.wav"),
	preload("res://Sound/Beltese/J_1.wav"),
	preload("res://Sound/Beltese/K_1.wav"),
	preload("res://Sound/Beltese/L_1.wav"),
	preload("res://Sound/Beltese/M_1.wav"),
	preload("res://Sound/Beltese/N_1.wav"),
	preload("res://Sound/Beltese/O_1.wav"),
	preload("res://Sound/Beltese/P_1.wav"),
	preload("res://Sound/Beltese/Q_1.wav"),
	preload("res://Sound/Beltese/R_1.wav"),
	preload("res://Sound/Beltese/S_1.wav"),
	preload("res://Sound/Beltese/T_1.wav"),
	preload("res://Sound/Beltese/U_1.wav"),
	preload("res://Sound/Beltese/V_1.wav"),
	preload("res://Sound/Beltese/W_1.wav"),
	preload("res://Sound/Beltese/X_1.wav"),
	preload("res://Sound/Beltese/Y_1.wav"),
	preload("res://Sound/Beltese/Z_1.wav"),
]

func reset(id: String):
	label.visible_characters = id.length()

func speak():
	for n in label.text.length():
		if get_parent().paused: await get_parent().resume
		label.visible_characters += 1
		
		$beltese.stream = beltese[randi_range(0,beltese.size() - 1)]
		$beltese.play()
			
		await get_tree().create_timer(0.05).timeout
	return

func _on_continue_pressed():
	if label.visible_characters > label.text.length() - 4: next.emit()
