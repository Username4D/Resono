extends Area2D

var collected = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !collected:
		collected = true
		body.coin.emit()
		var time = get_tree().create_timer(0.5)
		while time.time_left != 0:
			self.scale = Vector2(time.time_left * 2, time.time_left * 2)
			await get_tree().process_frame
		self.visible = false

func respawn():
	self.scale = Vector2.ONE
	collected = false
	self.visible = true
			
