extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.death.emit()

func _physics_process(delta: float) -> void:
	$StaticBody2D/hitbox.disabled = $hitbox.disabled
