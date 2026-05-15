extends Control

const level_amount = 20
var level_button = preload("res://scenes/level_menu/level_menu_button.tscn")
var unlocked_levels = 2

func _ready() -> void:
	unlocked_levels = safe_manager.unlocked_levels
	for i in range(0, level_amount):
		var o = level_button.instantiate()
		o.level_id = i + 1
		if i >= unlocked_levels:
			o.level_disabled = true
		if i == unlocked_levels - 1 or i == level_amount - 1:
			o.hide_line = true
		o.pressed.connect(func(): load_level(o.level_id))
		%buttons.add_child(o)

func load_level(x):
	ui_transition_handler.transition_start.emit()
	await ui_transition_handler.transition_mid_point
	var new_scene = await load("res://scenes/levels/%d.tscn" % [x]).instantiate()
	self.get_parent().add_child(new_scene)
	await get_tree().process_frame
	audio_handler.break_toggled = true
	ui_transition_handler.transition_continue.emit()
	self.queue_free()


func _on_back_button_pressed() -> void:
	ui_transition_handler.transition_start.emit()
	await ui_transition_handler.transition_mid_point
	var new_scene = await load("res://scenes/menu_scenes/main_menu.tscn").instantiate()
	self.get_parent().add_child(new_scene)
	await get_tree().process_frame
	ui_transition_handler.transition_continue.emit()
	self.queue_free()
