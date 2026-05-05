extends Button

@export var level_id = 0
@export var level_disabled = false
@export var hide_line = false

func _enter_tree() -> void:
	$Label.text = str(level_id)
	if level_disabled:
		self.disabled = true
		$Line2D.visible = false
		self.modulate.a = 0.5
	if hide_line:
		$Line2D.visible = false
