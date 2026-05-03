extends CanvasLayer

var rotations = []

func _ready() -> void:
	for i in $layer_1.get_children():
		var rot = 90 * randi_range(1,4)
		rotations.append(rot)
		i.rotation_degrees = rot

func input():
	for i in len(rotations):
		rotations[i] += 90 if randi_range(0,1) == 1 else -90

func _process(delta: float) -> void:
	for i in $layer_1.get_child_count():
		$layer_1.get_child(i).rotation_degrees = move_toward($layer_1.get_child(i).rotation_degrees, rotations[i], delta * 520)
