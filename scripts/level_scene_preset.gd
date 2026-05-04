extends Control

func _ready() -> void:
	if $player_character and $foreground:
		$player_character.move.connect($foreground.input)
		$player_character.move.connect($background.input)
	#await $level.changed
	$level.update_internals()
	print($level.get_children())
	for i: Node in $level.get_children():
		print(i.name)
		if i.has_method("respawn"):
			$player_character.respawn.connect(i.respawn)
func _process(delta: float) -> void:
	if $player_character and $foreground:
		$foreground.offset = ($player_character.position - Vector2(get_viewport().size) / 2) * 0.1


func _on_player_character_finish() -> void:
	await get_tree().create_timer(1).timeout
	print("lol")
	$win_menu.animation_open()

	
