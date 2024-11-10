extends CharacterBody2D

# Speed of movement to the left when space bar is pressed
var move_speed := 0  # Pixels per second

var hp = 1

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select") && hp != 0:
		print("Move Speed: ")
		print(move_speed)
		velocity.x = move_speed
	else:
		velocity.x = 0

	move_and_slide()
	#await Input.is_action_just_released("ui_select")

	if hp == 0:
		$Timer.start()
		
		



func _on_timer_timeout() -> void:
	#Player Animation Player Death
	#Lose Screen and Play Again
	get_tree().reload_current_scene()
	pass # Replace with function body.
