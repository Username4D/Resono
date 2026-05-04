extends CenterContainer

class_name BasicMenu

var open = false
var ongoing = false

signal animation_open_start
signal animation_open_end
signal animation_close_start
signal animation_close_end

func animation_open():
	if ongoing: return
	if open: return
	self.visible = true
	print(self.visible)
	animation_open_start.emit()
	ongoing = true
	for i in %bg_polygons.get_children():
		var children = i.get_children()
		children.shuffle()
		for n in children.slice(0, 9):
			n.visible = true
			await get_tree().create_timer(0.001).timeout
		for n in children.slice(9, 16):
			n.visible = true
			await get_tree().create_timer(0.001).timeout
	await get_tree().create_timer(0.1).timeout
	var timer = get_tree().create_timer(2)
	while timer.time_left != 0:
		%content.size.y = (1 - ease(timer.time_left / 2, 6)) * 512
		await get_tree().process_frame
	ongoing = false
	open = true
	animation_open_end.emit()

func animation_close():
	if ongoing: return
	if !open: return
	animation_close_start.emit()
	ongoing = true
	var timer = get_tree().create_timer(2)
	while timer.time_left != 0:
		%content.size.y = (ease(timer.time_left / 2, 0.1)) * 512
		await get_tree().process_frame
	var arr = %bg_polygons.get_children()
	arr.reverse()
	for i in arr:
		var children = i.get_children()
		children.shuffle()
		for n in children.slice(0, 9):
			n.visible = false
			await get_tree().create_timer(0.001).timeout
		for n in children.slice(9, 16):
			n.visible = false
			await get_tree().create_timer(0.001).timeout
	ongoing = false
	open = false
	animation_close_end.emit()
	self.visible = false

func _ready() -> void:
	for i in %bg_polygons.get_children():
		for n in range(1, 9):
			if randi_range(0,1) == 1:
				i.get_node("poly_up%d" % [n]).rotation_degrees += 90
				i.get_node("poly_down%d" % [n]).rotation_degrees += 90
