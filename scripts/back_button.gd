extends CanvasLayer

signal pressed

func _ready() -> void:
	%Button.pressed.connect(func(): pressed.emit(),)
