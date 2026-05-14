extends Node

func _ready() -> void:
	if self.get_parent():
		if self.get_parent() is Button:
			self.get_parent().pressed.connect(func(): audio_handler.play_sfx("click", false, 0.7),)
			#self.get_parent().mouse_entered.connect(func(): audio_handler.play_sfx("hover", false, 0.8),)
		elif self.get_parent() is Slider:
			await self.get_parent().value_changed
			self.get_parent().value_changed.connect(func(x): audio_handler.play_sfx("hover", false, 1),)
			self.get_parent().drag_started.connect(func(): audio_handler.play_sfx("click", false, 0.7),)
		
