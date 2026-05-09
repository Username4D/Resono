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
