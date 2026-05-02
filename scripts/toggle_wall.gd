extends Area2D

var used = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !used:
		used = true
		await get_tree().create_timer(0.1).timeout
		$hitbox.process_mode = Node.PROCESS_MODE_INHERIT
		var timer = get_tree().create_timer(1)
		while timer.time_left != 0:
			$filler.scale.x = 0.125 - timer.time_left / 8
			$filler.scale.y = 0.125 - timer.time_left / 8
			$filler.visible = true
			await get_tree().process_frame
		$filler.scale = Vector2(0.125, 0.125)
