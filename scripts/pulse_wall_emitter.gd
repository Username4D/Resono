extends StaticBody2D

@export var wait_time = 1
signal output
var toggled = true

func _ready() -> void:
	toggle()
	$direction_indicator.visible = false
	for i in $polygons.get_children():
		i.rotation_degrees = randi_range(1,4) * 90

func toggle():
	if toggled:
		toggled = !toggled
		if randi_range(1,2) == 1:
			$polygons/b1.visible = false
			await get_tree().create_timer(0.06).timeout
			$polygons/b2.visible = false
			await get_tree().create_timer(0.06).timeout
		else:
			$polygons/b2.visible = false
			await get_tree().create_timer(0.06).timeout
			$polygons/b1.visible = false
			await get_tree().create_timer(0.06).timeout
		if randi_range(1,2) == 1:
			$polygons/f1.visible = false
			await get_tree().create_timer(0.06).timeout
			$polygons/f2.visible = false
		else:
			$polygons/f2.visible = false
			await get_tree().create_timer(0.06).timeout
			$polygons/f1.visible = false
		$CollisionShape2D.disabled = true
		await get_tree().create_timer(0.06).timeout
		output.emit()
	else:
		toggled = !toggled
		$CollisionShape2D.disabled = false
		if randi_range(1,2) == 1:
			$polygons/b1.visible = true
			await get_tree().create_timer(0.06).timeout
			$polygons/b2.visible = true
			await get_tree().create_timer(0.06).timeout
		else:
			$polygons/b2.visible = true
			await get_tree().create_timer(0.06).timeout
			$polygons/b1.visible = true
			await get_tree().create_timer(0.06).timeout
		if randi_range(1,2) == 1:
			$polygons/f1.visible = true
			await get_tree().create_timer(0.06).timeout
			$polygons/f2.visible = true
		else:
			$polygons/f2.visible = true
			await get_tree().create_timer(0.06).timeout
			$polygons/f1.visible = true
		
		await get_tree().create_timer(0.06).timeout
		output.emit()
	get_tree().create_timer(wait_time).timeout.connect(toggle)
