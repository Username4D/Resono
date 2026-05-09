extends StaticBody2D

func _ready() -> void:
	for i in $polygons.get_children():
		print(randi_range(1,4))
		
		i.rotation_degrees += randi_range(1,4) * 90
		print(i.rotation)

func break_wall():
	var arr = $polygons.get_children()
	arr.shuffle()
	for i in arr:
		i.get_child(0).visible = false
		await get_tree().create_timer(0.05)
		i.get_child(1).visible = false
		await get_tree().create_timer(0.05)
	$CollisionShape2D.disabled = true

func respawn():
	for i in $polygons.get_children():
		for n in i.get_children():
			n.visible = true
	$CollisionShape2D.disabled = false
