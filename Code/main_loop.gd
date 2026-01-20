extends Control

const cust_start_pos = Vector2(1368, 500)
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
	
	cust = customer_order.pop_front()
	
	run_customer()


func run_customer():
	fix_buttons[1].tooltip_text = str("Replace -$", cust.replace_price)
	await customer_walkup()
	
	if cust.my_belt:
		cust_belt.texture = cust.my_belt
		cust_belt.visible = true
	for n in cust.dialogue_seperated:
		await dialogue()
	
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


func dialogue():
	for n in sell_buttons:
		n.disabled = true
		n.get_child(0).visible = true
	for n in fix_buttons:
		n.disabled = true
		n.get_child(0).visible = true
	
	dialogue_box.reset(cust.id)
	dialogue_box.label.text = cust.request_next_dialogue()
	dialogue_box.speak()
	dialogue_box.visible = true
	await dialogue_box.next
	dialogue_box.visible = false
	await get_tree().create_timer(0.01).timeout
	return


func customer_walkup():
	track.position = cust_start_pos
	cust.flip_h = false
	cust.visible = true
	cust.anims.play("hop")
	var adder = 0.001
	while track.position.x > 900:
		track.position.x = lerp(track.position.x, 890.0, adder)
		adder += 0.000275
		await get_tree().create_timer(0.01).timeout
	cust.anims.play("stop")
	return


func customer_walkaway():
	cust_belt.visible = false
	timer.visible = false
	cust.flip_h = true
	cust.anims.play("hop")
	var adder = 0.001
	while track.position.x < 1500:
		track.position.x = lerp(track.position.x, 1510.0, adder)
		adder += 0.0003
		await get_tree().create_timer(0.01).timeout
	cust.anims.play("stop")
	cust.visible = false
	return


func _on_knife_pressed():
	if sell_buttons[5].button_pressed:
		change_fix_price()
		return
	
	if float(fix_buttons[0].tooltip_text.get_slice("$", 1)) > cust.wallet:
		cust.end_dia_setup(false, false)
	
	elif not cust.allowed.has(5): cust.end_dia_setup(false, false)
	
	elif cust.wants != 5: cust.end_dia_setup(true, true)
	else: cust.end_dia_setup(true, false)
	profit.text = str("$", float(profit.text.get_slice("$", 1)) + \
		float(fix_buttons[0].tooltip_text.get_slice("$", 1)))
	
	end_cust()


func change_price(type:int):
	price_d.get_child(1).get_child(0).value =\
		float(sell_buttons[type].tooltip_text.get_slice("$", 1))
	price_d.get_child(1).get_child(0).max_value =\
		float(sell_buttons[type].tooltip_text.get_slice("$", 1)) * 1.5
	price_d.visible = true
	price_d.get_child(0).get_child(0).text = str("Enter New Price For: ", sell_buttons[type].name)
	await price_d.get_child(1).get_child(1).pressed
	sell_buttons[type].tooltip_text = str(sell_buttons[type].tooltip_text.get_slice("$", 0),\
		"$", price_d.get_child(1).get_child(0).value)
	price_d.visible = false


func change_fix_price():
	price_d.get_child(1).get_child(0).value =\
		float(fix_buttons[0].tooltip_text.get_slice("$", 1))
	price_d.visible = true
	price_d.get_child(0).get_child(0).text = str("Enter New Price For: ", fix_buttons[0].name)
	await price_d.get_child(1).get_child(1).pressed
	fix_buttons[0].tooltip_text = str("$", price_d.get_child(1).get_child(0).value)
	price_d.visible = false


func sell(type:int):
	if not cust.allowed.has(type): cust.end_dia_setup(false, false)
	
	elif float(sell_buttons[type].tooltip_text.get_slice("$", 1)) <= cust.wallet:
		if cust.wants == type or cust.wants == 6: cust.end_dia_setup(true, false)
		else:  cust.end_dia_setup(true, true)
		profit.text = str("$", float(profit.text.get_slice("$", 1)) + \
			float(sell_buttons[type].tooltip_text.get_slice("$", 1)))
	else: cust.end_dia_setup(false, false)
	
	end_cust()


func end_cust():
	timer.visible = false
	timer.get_child(0).stop()
	await dialogue()
	await customer_walkaway()
	
	if customer_order.is_empty(): end_game()
	else:
		cust = customer_order.pop_front()
		cust._ready()
		run_customer()


func end_game():
	print("Morality Rating: ", Settings.scammed.count(false) - Settings.scammed.count(true))


func _on_replacement_pressed():
	if not cust.allowed.has(6): cust.end_dia_setup(false, false)
	
	else:
		profit.text = str("$", float(profit.text.get_slice("$", 1)) - cust.replace_price)
		cust.end_dia_setup(true, false)
	end_cust()


func _process(delta):
	if not timer.visible: return
	timer.value = (timer.get_child(0).time_left/cust.wait_time) * 100


func _on_timer_timeout():
	timer.visible = false
	cust.end_dia_setup(false, false, 2)
	end_cust()
