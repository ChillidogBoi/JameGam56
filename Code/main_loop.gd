extends Control

const cust_start_pos = Vector2(1368, 374)
@export var sound: AudioStreamPlayer
@export var timer: TextureProgressBar
@export var cust_belt: TextureRect
@export var profit: Label
@export var dialogue_box: PanelContainer
@export var track: Node2D
@export var customer_order: Array[Customer]
@export var price_d: VBoxContainer
@export var sell_buttons: Array[BaseButton]
@export var fix_buttons: Array[BaseButton]
var cust: Customer
const MONEY_SOUND = preload("res://Sound/coin_drop_01.ogg")
const AWW_01 = preload("uid://5styh0l528dh")
const BOSS_DIA1 = "Boss:Make $300 by the end of the day. Or you're fired."
const BOSS_DIA2 =  "Boss:I don't care if you have to cheat an OLD LADY out of her Social Security Check"
var paused = false
var boss = true
signal resume


func _ready():
	for n in customer_order:
		n.visible = false
	price_d.visible = false
	timer.visible = false
	cust_belt.visible = false
	for n in sell_buttons:
		n.disabled = true
		n.get_child(0).visible = true
	for n in fix_buttons:
		n.disabled = true
		n.get_child(0).visible = true
	
	$"../Sprite2D/AnimationPlayer".play("grow")
	await $"../Sprite2D/AnimationPlayer".animation_finished
	
	cust = $"../track/Boss"
	run_customer()

func run_customer():
	fix_buttons[1].tooltip_text = str("Replace -$", cust.replace_price)
	await customer_walkup()
	
	if cust.my_belt:
		cust_belt.texture = cust.my_belt
		cust_belt.visible = true
	for n in cust.dialogue_seperated:
		await dialogue(cust.request_next_dialogue(), cust.male)
	
	timer.get_child(0).stop()
	if cust.wait_time != 0.0:
		timer.get_child(0).wait_time = cust.wait_time
		timer.visible = true
		timer.get_child(0).start()
	
	for n in sell_buttons:
		n.disabled = false
		n.get_child(0).visible = false
	for n in fix_buttons:
		if cust.fix_works:
			n.disabled = false
			n.get_child(0).visible = false

func run_boss_again():
	if cust.my_belt:
		cust_belt.texture = cust.my_belt
		cust_belt.visible = true
	
	timer.get_child(0).stop()
	if cust.wait_time != 0.0:
		timer.get_child(0).wait_time = cust.wait_time
		timer.visible = true
		timer.get_child(0).start()
	
	for n in sell_buttons:
		n.disabled = false
		n.get_child(0).visible = false
	for n in fix_buttons:
		if cust.fix_works:
			n.disabled = false
			n.get_child(0).visible = false


func dialogue(txt: String, male: bool):
	if txt == "":
		return
	for n in sell_buttons:
		n.disabled = true
		n.get_child(0).visible = true
	for n in fix_buttons:
		n.disabled = true
		n.get_child(0).visible = true
	
	dialogue_box.reset()
	dialogue_box.label.text = txt.get_slice(":", 1)
	dialogue_box.nam.text = str(txt.get_slice(":", 0), ":")
	dialogue_box.visible = true
	dialogue_box.speak(male)
	await dialogue_box.next
	dialogue_box.visible = false
	await get_tree().create_timer(0.01).timeout
	return


func customer_walkup():
	track.position = cust_start_pos
	cust.flip_h = false
	cust.visible = true
	cust.anims.play("hop")
	var adder = 0.0001
	while track.position.x > 900:
		if paused: await resume
		track.position.x = lerp(track.position.x, 890.0, adder)
		adder += 0.0001
		await get_tree().create_timer(0.01).timeout
	cust.anims.play("stop")
	cust.find_child("inner").visible = true
	for n in cust.find_child("inner").get_children():
		n.mouse_entered.connect($Belts._on_inner_mouse_entered)
	return


func customer_walkaway():
	cust_belt.visible = false
	timer.visible = false
	cust.flip_h = true
	cust.anims.play("hop")
	var adder = 0.001
	while track.position.x < 1500:
		if paused: await resume
		track.position.x = lerp(track.position.x, 1510.0, adder)
		adder += 0.0003
		await get_tree().create_timer(0.01).timeout
	cust.anims.play("stop")
	cust.visible = false
	return


func _on_knife_pressed():
	if not cust.allowed.has(5):
		cust.end_dia_setup(false, false, 1)
		$"../Node2D/Player/Face/fail".visible = true
	
	elif cust.wants != 5:
		cust.end_dia_setup(true, true)
		$"../Node2D/Player/Face/joy".visible = true
	else:
		cust.end_dia_setup(true, false)
		$"../Node2D/Player/Face/kind".visible = true
	profit.text = str("$", float(profit.text.get_slice("$", 1)) - \
		float(fix_buttons[0].tooltip_text.get_slice("$", 1)))
	Settings.profit = float(profit.text.get_slice("$", 1))
	
	end_cust()


func change_price(type:int):
	price_d.get_child(1).get_child(0).value =\
		float(sell_buttons[type].tooltip_text.get_slice("$", 1))
	price_d.get_child(1).get_child(0).max_value =\
		float(sell_buttons[type].tooltip_text.get_slice("$", 1)) * 1.5
	price_d.visible = true
	price_d.get_child(0).get_child(0).text = str("Enter New Price For: ", sell_buttons[type].name)
	if paused: await resume
	await price_d.get_child(1).get_child(1).pressed
	profit.text = str("$", float(profit.text.get_slice("$", 1)) - \
		float(sell_buttons[5].tooltip_text.get_slice("$", 1)))
	Settings.profit = float(profit.text.get_slice("$", 1))
	sell_buttons[type].tooltip_text = str(sell_buttons[type].tooltip_text.get_slice("$", 0),\
		"$", price_d.get_child(1).get_child(0).value)
	price_d.visible = false

func boss_sell(type:int):
	
	if not cust.allowed.has(type):
		cust.end_dia_setup(false, false, 1)
		$"../Node2D/Player/Face/sad".visible = true
		sound.stream = AWW_01
		sound.play()

	elif float(sell_buttons[type].tooltip_text.get_slice("$", 1)) <= cust.wallet:
		if cust.wants == type or cust.wants == 6:
			cust.end_dia_setup(true, false)
			$"../Node2D/Player/Face/fail".visible = true
			sound.stream = AWW_01
			sound.play()
		else: 
			if type == 2: cust.end_dialogue_scam = "Boss:Not my style.\nSomething flashier.&Boss:Let's try that one more time."
			else: cust.end_dialogue_scam = "Boss:Do I look like a \"fashion diva\"? Open your eyes!&Boss:Let's try that one more time."
			cust.end_dia_setup(true, true)
			$"../Node2D/Player/Face/sad".visible = true
			sound.stream = AWW_01
			sound.play()
	else:
		cust.end_dia_setup(false, false)
		$"../Node2D/Player/Face/kind".visible = true
		boss = false
		
	profit.text = "$0"
	
	end_boss()

func end_boss():
	Settings.scammed = []
	Settings.scammed_pic = []
	Settings.helped = 0
	if not boss:
		end_cust()
		return
	
	timer.visible = false
	timer.get_child(0).stop()
	if paused: await resume
	for n in cust.dialogue_seperated:
		await dialogue(cust.request_next_dialogue(), cust.male)
	
	$"../Node2D/Player/Face/fail".visible = false
	$"../Node2D/Player/Face/joy".visible = false
	$"../Node2D/Player/Face/sad".visible = false
	$"../Node2D/Player/Face/kind".visible = false
	if paused: await resume
	
	run_boss_again()

func sell(type:int):
	if not cust.allowed.has(type):
		cust.end_dia_setup(false, false, 1)
		$"../Node2D/Player/Face/fail".visible = true
		sound.stream = AWW_01
		sound.play()
	
	elif float(sell_buttons[type].tooltip_text.get_slice("$", 1)) <= cust.wallet:
		if cust.wants == type or cust.wants == 6:
			cust.end_dia_setup(true, false)
			$"../Node2D/Player/Face/kind".visible = true
			profit.text = str("$", clamp(float(profit.text.get_slice("$", 1)) + cust.tip, 0, 5000000))
		else: 
			cust.end_dia_setup(true, true)
			$"../Node2D/Player/Face/joy".visible = true
		profit.text = str("$", float(profit.text.get_slice("$", 1)) + \
			float(sell_buttons[type].tooltip_text.get_slice("$", 1)))
		Settings.profit = float(profit.text.get_slice("$", 1))
		sound.stream = MONEY_SOUND
		sound.play()
	else:
		cust.end_dia_setup(false, false)
		$"../Node2D/Player/Face/sad".visible = true
		sound.stream = AWW_01
		sound.play()
	
	end_cust()

func end_cust():
	timer.visible = false
	timer.get_child(0).stop()
	if paused: await resume
	for n in cust.dialogue_seperated:
		await dialogue(cust.request_next_dialogue(), cust.male)
	
	$"../Node2D/Player/Face/fail".visible = false
	$"../Node2D/Player/Face/joy".visible = false
	$"../Node2D/Player/Face/sad".visible = false
	$"../Node2D/Player/Face/kind".visible = false
	if paused: await resume
	await customer_walkaway()
	
	if customer_order.is_empty(): end_game()
	else:
		cust = customer_order.pop_front()
		cust._ready()
		run_customer()


func end_game():
	$"../Sprite2D/AnimationPlayer".play("shrink")
	await $"../Sprite2D/AnimationPlayer".animation_finished
	get_tree().change_scene_to_file("res://Code/UI/Newspaper.tscn")


func _on_replacement_pressed():
	if not cust.allowed.has(6): cust.end_dia_setup(true, true)
	
	else:
		profit.text = str("$", float(profit.text.get_slice("$", 1)) - cust.replace_price)
		Settings.profit = float(profit.text.get_slice("$", 1))
		cust.end_dia_setup(true, false)
	end_cust()


func _process(delta):
	if not timer.visible: return
	timer.value = (timer.get_child(0).time_left/cust.wait_time) * 100


func _on_timer_timeout():
	sound.stream = AWW_01
	sound.play()
	$"../Node2D/Player/Face/sad".visible = true
	price_d.visible = false
	timer.visible = false
	cust.end_dia_setup(false, false, 2)
	end_cust()
