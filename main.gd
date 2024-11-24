extends Node2D


var space_hold_time = 0.0
var hold_duration = 3.0 # Time in seconds to check for
var begin = true
var defeat = false
var death = false
var victory = false


func _process(delta):
	if Input.is_action_pressed("ui_accept") && begin == true: # "ui_accept" is mapped to space bar by default
		#if $Countdown_SFX.playing == false:
			#$Countdown_SFX.play()
		if $Camera2D/Countdown.visible == false:
			$Camera2D/Countdown.visible = true
		if space_hold_time >= 1.0 && space_hold_time < 2.0:
			$Camera2D/Countdown.text = "2"
		if $Countdown_SFX.playing == false:
			$Countdown_SFX.play()
		if space_hold_time >= 2.0 && space_hold_time < 3.0:
			$Camera2D/Countdown.text = "1"
			if $Countdown_SFX.playing == false:
				$Countdown_SFX.play()
		space_hold_time  += delta
		print(space_hold_time)
		if space_hold_time >= hold_duration:
			$Camera2D/Countdown.text = "3"
			$Start_SFX.play()
			print("Space bar held for 3 seconds")
			space_hold_time = 0.0 # Reset or handle as needed
			$Camera2D/Begin.visible = false
			$Camera2D/Begin_Instructions.visible = false
			$Camera2D/Space.visible = false
			$Player.move_speed = 750
			$Skeleton.enemy_chase_speed = 90
			$Skeleton.begin = true
			begin = false
			$Camera2D/AnimationPlayer.play("camera_movement")
			$Camera2D/Countdown.visible = false
			$Idle_Music.stop()
			$Run_Music.play()
	elif Input.is_action_pressed("ui_accept") && defeat == true: # "ui_accept" is mapped to space bar by default
		if $Camera2D/Countdown.visible == false:
			$Camera2D/Countdown.visible = true
		if space_hold_time >= 1.0 && space_hold_time < 2.0:
			$Camera2D/Countdown.text = "2"
			if $Countdown_SFX.playing == false:
				$Countdown_SFX.play()
		if space_hold_time >= 2.0 && space_hold_time < 3.0:
			$Camera2D/Countdown.text = "1"
			if $Countdown_SFX.playing == false:
				$Countdown_SFX.play()
		space_hold_time  += delta
		print(space_hold_time)
		if space_hold_time >= hold_duration:
			$Start_SFX.play()
			$Camera2D/Countdown.text = "3"
			get_tree().reload_current_scene()
			defeat = false
	elif Input.is_action_pressed("ui_accept") && victory == true:
		if $Camera2D/Countdown.visible == false:
			$Camera2D/Countdown.visible = true
		if space_hold_time >= 1.0 && space_hold_time < 2.0:
			$Camera2D/Countdown.text = "2"
			if $Countdown_SFX.playing == false:
				$Countdown_SFX.play()
		if space_hold_time >= 2.0 && space_hold_time < 3.0:
			$Camera2D/Countdown.text = "1"
			if $Countdown_SFX.playing == false:
				$Countdown_SFX.play()
		space_hold_time  += delta
		print(space_hold_time)
		if space_hold_time >= hold_duration:
			$Start_SFX.play()
			$Camera2D/Countdown.text = "3"
			victory = false
			get_tree().reload_current_scene()
	else:
		space_hold_time = 0.0 # Reset when the key is released  
		$Camera2D/Countdown.text = "3"
		
	if($Player.hp == 0):
		defeat = true
		$Camera2D/AnimationPlayer.pause()
		if death == false:
			$Player/AnimatedSprite2D.play("death")
			$Player_Death.play()
			death = true
			$deathTimer.start()

		
	if defeat == true:
		$Camera2D/Defeat.visible = true
		$Camera2D/Instructions.visible = true
		$Camera2D/Space.visible = true
		if $Run_Music.playing == true:
			$Run_Music.stop()
			await $Run_Music.playing == false
			$Idle_Music.play(0.0)
	
	if victory == true:
		$Camera2D/Victory.visible = true
		$Camera2D/Instructions.visible = true
		$Camera2D/Space.visible = true
		$Skeleton/AnimatedSprite2D.play("default")
		if $Run_Music.playing == true:
			$Run_Music.stop()
			$Idle_Music.play()
		


func _on_death_timer_timeout() -> void:
	death = true
	$Player/AnimatedSprite2D.play("dead")
	pass # Replace with function body.



func _on_victory_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		victory = true
		$Skeleton.enemy_chase_speed = 0
		$Player.move_speed = 4000
		$Skeleton/AnimatedSprite2D.play("default")
		$Victory_SFX.play()
	pass # Replace with function body.
