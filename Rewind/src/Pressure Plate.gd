extends KinematicBody2D
export var state: = "off"

func _physics_process(delta: float) -> void:
	print(state)

func _on_StompDetector_body_entered(body: Node) -> void:
	state = "on"
		




func _on_StompDetector_body_exited(body: Node) -> void:
	state = "off"
