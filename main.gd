extends Node2D


var space_hold_time = 0.0
var hold_duration = 3.0 # Time in seconds to check for
var begin = true
var defeat = false

func _process(delta):
	if Input.is_action_pressed("ui_accept") && begin == true: # "ui_accept" is mapped to space bar by default
		space_hold_time  += delta
		print(space_hold_time)
		if space_hold_time >= hold_duration:
			print("Space bar held for 3 seconds")
			space_hold_time = 0.0 # Reset or handle as needed
			$Player/Camera2D/Begin.visible = false
			$Player/Camera2D/Begin_Instructions.visible = false
			$Player/Camera2D/Space.visible = false
			$Player.move_speed = 500
			$Skeleton.enemy_chase_speed = 100
			$Skeleton.begin = true
			begin = false
	elif Input.is_action_pressed("ui_accept") && defeat == true: # "ui_accept" is mapped to space bar by default
		space_hold_time  += delta
		print(space_hold_time)
		if space_hold_time >= hold_duration:
			get_tree().reload_current_scene()
			defeat = false
	else:
		space_hold_time = 0.0 # Reset when the key is released  
		
	if($Player.hp == 0):
		defeat = true
		
	if defeat == true:
		$Player/Camera2D/Defeat.visible = true
		$Player/Camera2D/Instructions.visible = true
		$Player/Camera2D/Space.visible = true
