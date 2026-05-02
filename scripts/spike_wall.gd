extends StaticBody2D

var used = false

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !used:
		used = true
		var timer = get_tree().create_timer(0.5)
		while timer.time_left != 0:
			$spike.position.y = -32 + 64 * timer.time_left
			$Control/spike_poly.position.y = 1.5 + 64 * timer.time_left
			await get_tree().process_frame
		$spike.position.y = -32
		$Control/spike_poly.position.y = 1.5
		
