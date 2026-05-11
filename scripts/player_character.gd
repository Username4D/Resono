extends CharacterBody2D

var custom_velocity = Vector2.ZERO
const speed = 30
var state = "alive" # alive, dead, finished

var start_position = Vector2.ZERO
@export var finish_position = Vector2.ZERO
signal move
signal coin 
signal death
signal finish
signal respawn
signal update_velocity(ve)

func _physics_process(delta: float) -> void:
	if state == "alive":
		var collision = move_and_collide(custom_velocity)
		if collision:
			if collision.get_collider().is_in_group("wall"):
				%hitbox.scale = Vector2.ONE
				custom_velocity = Vector2.ZERO
				print("wall")
			if collision.get_collider().is_in_group("break_wall"):
				collision.get_collider().break_wall()
func _input(event: InputEvent) -> void:
	if custom_velocity == Vector2.ZERO:
		if state != "alive": return
		if event.is_action_pressed("ui_up"):
			custom_velocity.y = -speed
			%hitbox.scale = Vector2(0.5,1)
			move.emit()
			update_velocity.emit(Vector2(0, -1))
		if event.is_action_pressed("ui_down"):
			custom_velocity.y = speed
			%hitbox.scale = Vector2(0.5,1)
			move.emit()
			update_velocity.emit(Vector2(0, 1))
		if event.is_action_pressed("ui_right"):
			custom_velocity.x = speed
			%hitbox.scale = Vector2(1,0.5)
			move.emit()
			update_velocity.emit(Vector2(1,0))
		if event.is_action_pressed("ui_left"):
			custom_velocity.x = -speed
			%hitbox.scale = Vector2(1,0.5)
			move.emit()
			update_velocity.emit(Vector2(-1, 0))
func _on_death() -> void:
	state = "dead"
	print(custom_velocity)
	$GPUParticles2D.process_material.gravity = Vector3(custom_velocity.x * -6, custom_velocity.y * -6, 0)
	$GPUParticles2D.position = custom_velocity / speed * 16
	$Polygon2D.visible = false
	$trail.visible = false
	$GPUParticles2D.emitting = true
	await get_tree().create_timer(2).timeout
	respawn.emit()
	self.position = start_position
	$Polygon2D.visible = true
	custom_velocity = Vector2.ZERO
	state = "alive"
	%hitbox.scale = Vector2.ONE
func _on_finish() -> void:
	state = "finished"
	position = finish_position
func _ready() -> void:
	start_position = position
	if !safe_manager.settings["particles_enabled"]:
		$GPUParticles2D.visible = false
