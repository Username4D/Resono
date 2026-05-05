extends Control

const level_amount = 2
var level_button = preload("res://scenes/level_menu/level_menu_button.tscn")
var unlocked_levels = 2

func _ready() -> void:
	for i in range(0, level_amount):
		var o = level_button.instantiate()
		o.level_id = i + 1
		if i >= unlocked_levels:
			o.level_disabled = true
		if i == unlocked_levels - 1:
			o.hide_line = true
		o.pressed.connect(func(): load_level(o.level_id))
		%buttons.add_child(o)

func load_level(x):
	get_tree().change_scene_to_file("res://scenes/levels/%d.tscn" % [x])
