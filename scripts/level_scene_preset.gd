extends Node2D

@export var level = 0
var coins = 0
var max_coins = 0


func _ready() -> void:
	if $player_character and $foreground:
		$player_character.move.connect($foreground.input)
		$player_character.move.connect($background.input)
	#await $level.changed
	$level.update_internals()
	for i: Node in $level.get_children():
		if i.has_method("respawn"):
			$player_character.respawn.connect(i.respawn)
		if i.has_method("update_velocity"):
			$player_character.update_velocity.connect(i.update_velocity)
		if i.is_in_group("coin"):
			max_coins += 1 
func _process(delta: float) -> void:
	if $player_character and $foreground:
		$foreground.offset = ($player_character.position - Vector2(get_viewport().size) / 2) * 0.1

func _on_player_character_finish() -> void:
	if level >= safe_manager.unlocked_levels:
		safe_manager.unlocked_levels = level + 1
	if safe_manager.level_coins[level - 1] < coins:
		safe_manager.level_coins[level - 1] = coins
	safe_manager.save_savefile()
	await get_tree().create_timer(1).timeout
	$win_menu.coins = coins
	$win_menu.max_coins = max_coins
	$win_menu.animation_open()

func _on_win_menu_menu() -> void:
	ui_transition_handler.transition_start.emit()
	await ui_transition_handler.transition_mid_point
	var next_level = await load("res://scenes/level_menu/level_selection_menu.tscn").instantiate()
	self.get_parent().add_child(next_level)
	await get_tree().process_frame
	audio_handler.break_toggled = false
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


func _on_back_button_pressed() -> void:
	ui_transition_handler.transition_start.emit()
	await ui_transition_handler.transition_mid_point
	var new_scene = await load("res://scenes/level_menu/level_selection_menu.tscn").instantiate()
	self.get_parent().add_child(new_scene)
	await get_tree().process_frame
	audio_handler.break_toggled = false
	ui_transition_handler.transition_continue.emit()
	self.queue_free()


func _on_win_menu_retry() -> void:
	$win_menu.animation_close()
	await $win_menu.animation_close_end
	$player_character.respawn.emit()


func _on_player_character_respawn() -> void:
	coins = 0
