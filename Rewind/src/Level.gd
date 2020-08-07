extends Node2D
onready var player = get_node("Player")
onready var enemy = get_node("Enemy")
onready var plate = get_node("Pressure Plate")

export var level: = 0
var l: = 1
var reset: = false

func _physics_process(delta: float) -> void:
	if(player.player_state != "dead"):
		get_node("Camera2D").position = player.position
	
	if(l != level or player.position.y > 1000):
		if(l == level):
			player.player_state = "alive"
			player.position = enemy.points[0]
			enemy.points.empty()
			player.set_collision_mask_bit(1, true)
			enemy.set_collision_mask_bit(0, true)
		player.points.append(Vector2(player.position));
		enemy.position = Vector2(-10000000,-1000)
		l = level
		reset = false
	if(enemy.player_in_sight == true):
		player.player_state = "dead"
		
		player.set_collision_mask_bit(1, false)
		enemy.set_collision_mask_bit(0, false)
	
	if(Input.is_action_pressed("Reset") and reset == false):
		enemy.position = player.points[0]
		enemy.points.empty()
		enemy.points = player.points
		player.points.empty()
		
		reset = true
		
