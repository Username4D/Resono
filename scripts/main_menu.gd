extends Control


func _on_levels_button_pressed() -> void:
	ui_transition_handler.transition_start.emit()
	await ui_transition_handler.transition_mid_point
	var new_scene = await load("res://scenes/level_menu/level_selection_menu.tscn").instantiate()
	self.get_parent().add_child(new_scene)
	await get_tree().process_frame
	ui_transition_handler.transition_continue.emit()
	self.queue_free()

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_colors_button_pressed() -> void:
	pass # Replace with function body.
