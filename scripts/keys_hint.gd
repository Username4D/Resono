extends Control

func toggle(node: Panel):
	var box: StyleBoxFlat = node.get_theme_stylebox("panel")
	box.bg_color = Color(0.004, 0.329, 0.294)
	box.border_color = Color(0.623, 0.782, 0.78, 1.0)
	node.get_child(0).self_modulate = Color(0.623, 0.782, 0.78, 1.0)

func untoggle(node):
	var box: StyleBoxFlat = node.get_theme_stylebox("panel")
	box.bg_color = Color(0.623, 0.782, 0.78, 1.0)
	box.border_color = Color(0.004, 0.329, 0.294)
	node.get_child(0).self_modulate = Color(0.004, 0.329, 0.294)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		toggle($w)
	if Input.is_action_just_released("ui_up"):
		untoggle($w)
	if Input.is_action_just_pressed("ui_down"):
		toggle($s)
	if Input.is_action_just_released("ui_down"):
		untoggle($s)
	if Input.is_action_just_pressed("ui_left"):
		toggle($a)
	if Input.is_action_just_released("ui_left"):
		untoggle($a)
	if Input.is_action_just_pressed("ui_right"):
		toggle($d)
	if Input.is_action_just_released("ui_right"):
		untoggle($d)
