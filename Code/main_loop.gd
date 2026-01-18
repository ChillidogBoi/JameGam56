extends Control

const cust_start_pos = Vector2(1368, 374)
@export var dialogue_box: PanelContainer
@export var track: Node2D


func _ready():
	run_customer($"../track/Customer")


func run_customer(cust: Customer):
	customer_walkup(cust)
	


func customer_walkup(cust: Customer):
	track.position = cust_start_pos
	cust.visible = true
	cust.anims.play("hop")
	var adder = 0.001
	while track.position.x > 970:
		track.position.x = lerp(track.position.x, 960.0, adder)
		adder += 0.0001
		await get_tree().create_timer(0.01).timeout
	cust.anims.play("stop")
