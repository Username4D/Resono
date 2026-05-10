extends Node

var audio_streams = {}
var break_toggled = false

func _ready() -> void:
	var menu_track = AudioStreamPlayer.new()
	menu_track.stream = AudioStreamOggVorbis.load_from_file("res://resources/audio/music_track_menu.ogg")
	menu_track.bus = "music"
	audio_streams["music_track_menu"] = menu_track
	self.add_child(menu_track)
	var break_track = AudioStreamPlayer.new()
	break_track.stream = AudioStreamOggVorbis.load_from_file("res://resources/audio/music_track_break.ogg")
	break_track.bus = "break"
	audio_streams["music_track_break"] = break_track
	self.add_child(break_track)
	menu_track.play()
	break_track.play()
	AudioServer.set_bus_volume_linear(2, 0)
	AudioServer.set_bus_volume_linear(3, 0)
	var timer = get_tree().create_timer(2)
	while timer.time_left != 0:
		AudioServer.set_bus_volume_linear(2, (1 - timer.time_left / 2) * safe_manager.settings["music_volume"] / 10)
		await get_tree().process_frame

func _process(delta: float) -> void:
	AudioServer.set_bus_volume_linear(3, move_toward(AudioServer.get_bus_volume_linear(3), 1 if break_toggled else 0, delta / 2))
