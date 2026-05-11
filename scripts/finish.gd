extends Area2D

func update_velocity(ve):
	$StaticBody2D.position = ve * 13
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.finish_position = self.position  + Vector2(0, 4)
		body.state = "finished"
		await get_tree().physics_frame
		$StaticBody2D/CollisionShape2D.disabled = true
		body.position = self.position + Vector2(0, 4)
		body.finish.emit()
		
