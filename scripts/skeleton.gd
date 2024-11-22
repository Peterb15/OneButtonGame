extends CharacterBody2D

#Speed of Enemy
var enemy_chase_speed := 0
var begin := false

#Reference to the player node
var caught: bool = false

func _physics_process(delta: float) -> void:
	if caught == false && begin == true:
		velocity.x = enemy_chase_speed
		move_and_slide()
		$AnimatedSprite2D.play("moving_right")


func _on_detection_range_area_entered(area: Area2D) -> void:
	
	$AnimatedSprite2D.play("hit")
	var player = $DetectionRange.get_overlapping_bodies()
	if (not player.is_empty()):
		print(player[0])
		if player[0] == CharacterBody2D:
			print("DEATH")
			player[0].hp = 0
	pass # Replace with function body.


func _on_detection_range_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.play("hit")
	var player = $DetectionRange.get_overlapping_bodies()
	if (body.is_in_group("player")): 
		print(body)
		body.hp = 0
		caught = true
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("default")
	pass # Replace with function body.
