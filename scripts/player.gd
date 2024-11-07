extends CharacterBody2D

# Speed of movement to the left when space bar is pressed
var move_speed := 200  # Pixels per second

var hp = 1

func _physics_process(delta):
	if Input.is_action_pressed("ui_select") && hp != 0:
		velocity.x = move_speed
	else:
		velocity.x = 0

	move_and_slide()

	if hp == 0:
		$Timer.start()
		
		



func _on_timer_timeout() -> void:
	#Player Animation Player Death
	#Lose Screen and Play Again
	get_tree().reload_current_scene()
	pass # Replace with function body.
