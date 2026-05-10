extends Control

var init = false

func _ready() -> void:
	print(safe_manager.settings)
	$HBoxContainer/sfx_volume/HSlider.value = safe_manager.settings["sfx_volume"]
	$HBoxContainer/music_volume/HSlider.value = safe_manager.settings["music_volume"]
	$HBoxContainer/Control/CheckBox.button_pressed = safe_manager.settings["particles_enabled"]
	init = true

func save():
	if !init: return
	safe_manager.settings["sfx_volume"] = $HBoxContainer/sfx_volume/HSlider.value
	safe_manager.settings["music_volume"] = $HBoxContainer/music_volume/HSlider.value
	safe_manager.settings["particles_enabled"] = $HBoxContainer/Control/CheckBox.button_pressed
	safe_manager.save_savefile()


func _on_back_button_pressed() -> void:
	ui_transition_handler.transition_start.emit()
	await ui_transition_handler.transition_mid_point
	var new_scene = await load("res://scenes/menu_scenes/main_menu.tscn").instantiate()
	self.get_parent().add_child(new_scene)
	await get_tree().process_frame
	ui_transition_handler.transition_continue.emit()
	self.queue_free()
