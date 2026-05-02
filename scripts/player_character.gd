extends CharacterBody2D

var custom_velocity = Vector2.ZERO
const speed = 30

signal coin 
signal death

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(custom_velocity)
	if collision:
		if collision.get_collider().is_in_group("wall"):
			%hitbox.scale = Vector2.ONE
			custom_velocity = Vector2.ZERO
			print("wall")

func _input(event: InputEvent) -> void:
	if custom_velocity == Vector2.ZERO:
		if event.is_action_pressed("ui_up"):
			custom_velocity.y = -speed
			%hitbox.scale = Vector2(0.9,1)
		if event.is_action_pressed("ui_down"):
			custom_velocity.y = speed
			%hitbox.scale = Vector2(0.9,1)
		if event.is_action_pressed("ui_right"):
			custom_velocity.x = speed
			%hitbox.scale = Vector2(1,0.9)
		if event.is_action_pressed("ui_left"):
			custom_velocity.x = -speed
			%hitbox.scale = Vector2(1,0.9)
	

func _on_death() -> void:
	print(custom_velocity)
	$GPUParticles2D.process_material.gravity = Vector3(custom_velocity.x * -6, custom_velocity.y * -6, 0)
	$GPUParticles2D.position = custom_velocity / speed * 16
	$Polygon2D.visible = false
	$trail.visible = false
	$GPUParticles2D.emitting = true
