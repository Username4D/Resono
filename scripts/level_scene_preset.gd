extends Control

func _ready() -> void:
	if $player_character and $foreground:
		$player_character.move.connect($foreground.input)
		$player_character.move.connect($background.input)

func _process(delta: float) -> void:
	if $player_character and $foreground:
		$foreground.offset = ($player_character.position - Vector2(get_viewport().size) / 2) * 0.1


func _on_player_character_finish() -> void:
	await get_tree().create_timer(1).timeout
	print("lol")
	$win_menu.animation_open()
