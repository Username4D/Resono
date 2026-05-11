extends StaticBody2D

@export var wait_time = 1.0
signal output
var toggled = true

func _ready() -> void:
	toggle()
	$direction_indicator.visible = false
	for i in $polygons.get_children():
		var rand = randi_range(1,4) * 90
		i.get_child(0).rotation_degrees = rand

func toggle():
	if toggled:
		toggled = !toggled
		if randi_range(1,2) == 1:
			$polygons/b1.visible = false
			$polygons/b1/spike/hitbox.disabled = true
			await get_tree().create_timer(0.06).timeout
			$polygons/b2.visible = false
			$polygons/b2/spike/hitbox.disabled = true
			await get_tree().create_timer(0.06).timeout
		else:
			$polygons/b2.visible = false
			$polygons/b2/spike/hitbox.disabled = true
			await get_tree().create_timer(0.06).timeout
			$polygons/b1.visible = false
			$polygons/b1/spike/hitbox.disabled = true
			await get_tree().create_timer(0.06).timeout
		if randi_range(1,2) == 1:
			$polygons/f1.visible = false
			$polygons/f1/spike/hitbox.disabled = true
			await get_tree().create_timer(0.06).timeout
			$polygons/f2.visible = false
			$polygons/f2/spike/hitbox.disabled = true
			await get_tree().create_timer(0.06).timeout
		else:
			$polygons/f2.visible = false
			$polygons/f2/spike/hitbox.disabled = true
			await get_tree().create_timer(0.06).timeout
			$polygons/f1.visible = false
			$polygons/f1/spike/hitbox.disabled = true
			await get_tree().create_timer(0.06).timeout
		$CollisionShape2D.disabled = true
		await get_tree().create_timer(0.06).timeout
		output.emit()
	else:
		toggled = !toggled
		$CollisionShape2D.disabled = false
		if randi_range(1,2) == 1:
			$polygons/b1.visible = true
			$polygons/b1/spike/hitbox.disabled = false
			await get_tree().create_timer(0.06).timeout
			$polygons/b2.visible = true
			$polygons/b2/spike/hitbox.disabled = false
			await get_tree().create_timer(0.06).timeout
		else:
			$polygons/b2.visible = true
			$polygons/b2/spike/hitbox.disabled = false
			await get_tree().create_timer(0.06).timeout
			$polygons/b1.visible = true
			$polygons/b1/spike/hitbox.disabled = false
			await get_tree().create_timer(0.06).timeout
		if randi_range(1,2) == 1:
			$polygons/f1.visible = true
			$polygons/f1/spike/hitbox.disabled = false
			await get_tree().create_timer(0.06).timeout
			$polygons/f2.visible = true
			$polygons/f2/spike/hitbox.disabled = false
			await get_tree().create_timer(0.06).timeout
		else:
			$polygons/f2.visible = true
			$polygons/f2/spike/hitbox.disabled = false
			await get_tree().create_timer(0.06).timeout
			$polygons/f1.visible = true
			$polygons/f1/spike/hitbox.disabled = false
			await get_tree().create_timer(0.06).timeout
		$CollisionShape2D.disabled = false
		await get_tree().create_timer(0.06).timeout
		output.emit()
	get_tree().create_timer(wait_time).timeout.connect(toggle)
