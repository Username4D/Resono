extends Control

func _ready() -> void:
	if $player_character and $foreground:
		$player_character.move.connect($foreground.input)
		$player_character.move.connect($background.input)

func _process(delta: float) -> void:
	if $player_character and $foreground:
		$foreground.offset = ($player_character.position - Vector2(get_viewport().size) / 2) * 0.1
