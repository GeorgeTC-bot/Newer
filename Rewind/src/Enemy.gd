extends Entity


onready var player = get_parent().get_node("Player")

var player_in_sight = false
var player_in_range = false
var deltaX
var deltaY

var i: = -1
var rnge = Vector2(10,10);

func _physics_process(delta: float) -> void:
	Sight_Check();
	
	_sprite()
	
	if(points.size() != 0):
		if(i == -1):
			i += 1
		
		if(i < points.size() - 1 and position >= points[i] - rnge and position <= points[i] + rnge):
			velocity = follow(points[i], position)
			i += 1
			print(i, "in the range of ", points.size())
			
	
	#_speed() 
	move_and_slide(velocity)

func _sprite():
	if(velocity.x != 0):
		get_node("Enemy").play("Walk", false);
	else:
		get_node("Enemy").play("Idle");
	
	
	if(velocity.x < 0 and flip == false):
		flip = true
		get_node("Vision/CollisionPolygon2D").set_rotation_degrees(180)
	elif(velocity.x > 0 and flip == true): 
		flip = false
		get_node("Vision/CollisionPolygon2D").set_rotation_degrees(0)
	get_node("Enemy").set_flip_h(flip)


#these are to kill the player ;)
func _on_Vision_body_entered(body: Node) -> void:
	if(body == player):
		player_in_range = true

func _on_Vision_body_exited(body: Node) -> void:
	if(body == player):
		player_in_range = false

func Sight_Check():
	if(player_in_range == true):
		var space = get_world_2d().direct_space_state
		var sight_check = space.intersect_ray(
			position,
			player.position,
			[self],
			collision_mask
		)
		if(sight_check):
			if(sight_check.collider.name == "Player"):
				player_in_sight = true
		else:
			player_in_sight = false 

func follow(target: Vector2, follower: Vector2) -> Vector2:
	var new_velocity = Vector2.ZERO
	
	new_velocity.x = (target.x - follower.x)*20
	new_velocity.y = (target.y - follower.y)*20
	
	return new_velocity
