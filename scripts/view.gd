extends Control


func transition():
	$click_protector.visible = true
	for i in range(0, $transition/row.get_child_count() + $transition.get_child_count() - 1):
		var trigger_objects = []
		for n in range(0, i + 1 if i < $transition.get_child_count() else $transition.get_child_count()):
			if i - n < $transition.get_child(n).get_child_count():
				trigger_objects.append($transition.get_child(n).get_child(i - n))
		for n in trigger_objects:
			n.get_child(0).visible = true
		await get_tree().create_timer(0.025).timeout
		for n in trigger_objects:
			n.get_child(1).visible = true
	ui_transition_handler.transition_mid_point.emit()
	await ui_transition_handler.transition_continue
	await get_tree().create_timer(0.7).timeout
	for i in range(0, $transition/row.get_child_count() + $transition.get_child_count() - 1):
		var trigger_objects = []
		for n in range(0, i + 1 if i < $transition.get_child_count() else $transition.get_child_count()):
			if i - n < $transition.get_child(n).get_child_count():
				trigger_objects.append($transition.get_child(n).get_child(i - n))
		for n in trigger_objects:
			n.get_child(0).visible = false
		await get_tree().create_timer(0.025).timeout
		for n in trigger_objects:
			n.get_child(1).visible = false
	ui_transition_handler.transition_end.emit()
	$click_protector.visible = false

func _ready() -> void:
	for i in $transition.get_children():
		for n in i.get_children():
			n.get_child(0).visible = false
			n.get_child(1).visible = false
			var rot = randi_range(0,4)

			n.get_child(0).rotation_degrees += rot * 90
			n.get_child(1).rotation_degrees += rot * 90
	ui_transition_handler.transition_start.connect(transition)
