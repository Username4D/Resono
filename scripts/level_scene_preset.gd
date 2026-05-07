extends Control

@export var level = 0
var coins = 0

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

func _on_win_menu_menu() -> void:
	ui_transition_handler.transition_start.emit()
	await ui_transition_handler.transition_mid_point
	var next_level = await load("res://scenes/level_menu/level_selection_menu.tscn").instantiate()
	self.get_parent().add_child(next_level)
	await get_tree().process_frame
	ui_transition_handler.transition_continue.emit()
	self.queue_free()

func _on_win_menu_next() -> void:
	ui_transition_handler.transition_start.emit()
	await ui_transition_handler.transition_mid_point
	var next_level = await load("res://scenes/levels/%d.tscn" % (level + 1)).instantiate()
	self.get_parent().add_child(next_level)
	await get_tree().process_frame
	ui_transition_handler.transition_continue.emit()
	self.queue_free()

func _on_player_character_coin() -> void:
	coins += 1

func _on_player_character_death() -> void:
	coins = 0
