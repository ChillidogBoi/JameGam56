extends PanelContainer

signal next
@export var label: Label
@export var nam: Label
const DIALOGUE_SYSTEM = preload("uid://cuauo5um5p8ow")
const DIALOGUE_SYSTEM_FLIPPED = preload("uid://b5n6k2ft3v2fc")

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
const beltese_male = [
	preload("res://Sound/Beltese-Male/A2.wav"),
	preload("res://Sound/Beltese-Male/B2.wav"),
	preload("res://Sound/Beltese-Male/C2.wav"),
	preload("res://Sound/Beltese-Male/D2.wav"),
	preload("res://Sound/Beltese-Male/E2.wav"),
	preload("res://Sound/Beltese-Male/F2.wav"),
	preload("res://Sound/Beltese-Male/G2.wav"),
	preload("res://Sound/Beltese-Male/H2.wav"),
	preload("res://Sound/Beltese-Male/I2.wav"),
	preload("res://Sound/Beltese-Male/J2.wav"),
	preload("res://Sound/Beltese-Male/K2.wav"),
	preload("res://Sound/Beltese-Male/L2.wav"),
	preload("res://Sound/Beltese-Male/M2.wav"),
	preload("res://Sound/Beltese-Male/N2.wav"),
	preload("res://Sound/Beltese-Male/O2.wav"),
	preload("res://Sound/Beltese-Male/P2.wav"),
	preload("res://Sound/Beltese-Male/Q2.wav"),
	preload("res://Sound/Beltese-Male/R2.wav"),
	preload("res://Sound/Beltese-Male/S2.wav"),
	preload("res://Sound/Beltese-Male/T2.wav"),
	preload("res://Sound/Beltese-Male/U2.wav"),
	preload("res://Sound/Beltese-Male/V2.wav"),
	preload("res://Sound/Beltese-Male/W2.wav"),
	preload("res://Sound/Beltese-Male/X2.wav"),
	preload("res://Sound/Beltese-Male/Y2.wav"),
	preload("res://Sound/Beltese-Male/Z2.wav"),
]


func reset():
	label.visible_characters = 0

func speak(male:bool):
	if nam.text == "You:":
		add_theme_stylebox_override("panel", DIALOGUE_SYSTEM_FLIPPED)
		male = false
	else:
		add_theme_stylebox_override("panel", DIALOGUE_SYSTEM)
	for n in label.text.length():
		if not visible: return
		if get_parent().paused: await get_parent().resume
		label.visible_characters += 1
		
		if not Input.is_action_pressed("speed"):
			if male: $beltese.stream = beltese_male[randi_range(0,beltese.size() - 1)]
			else: $beltese.stream = beltese[randi_range(0,beltese.size() - 1)]
			$beltese.play()
				
			await get_tree().create_timer(0.05).timeout
	return

func _on_continue_pressed():
	next.emit()

func _input(event):
	if not event is InputEventMouseButton: return
	if event.button_index > 1 or event.pressed == false: return
	_on_continue_pressed()
