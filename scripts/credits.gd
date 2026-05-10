extends Control


func _on_back_button_pressed() -> void:
	ui_transition_handler.transition_start.emit()
	await ui_transition_handler.transition_mid_point
	var new_scene = await load("res://scenes/menu_scenes/main_menu.tscn").instantiate()
	self.get_parent().add_child(new_scene)
	await get_tree().process_frame
	ui_transition_handler.transition_continue.emit()
	self.queue_free()
