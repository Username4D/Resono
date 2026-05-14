extends Node

var audio_tracks = {}
var break_toggled = false

@onready var streams = {
	"click": AudioStreamOggVorbis.load_from_file("res://resources/audio/sfx/click.ogg"),
	"coin": AudioStreamOggVorbis.load_from_file("res://resources/audio/sfx/coin.ogg"), 
	"death": AudioStreamOggVorbis.load_from_file("res://resources/audio/sfx/death.ogg"), 
	"fin": AudioStreamOggVorbis.load_from_file("res://resources/audio/sfx/fin.ogg"), 
	"hover": AudioStreamOggVorbis.load_from_file("res://resources/audio/sfx/hover.ogg"), 
	"swipe": AudioStreamOggVorbis.load_from_file("res://resources/audio/sfx/swipe.ogg")
}

func _ready() -> void:
	var menu_track = AudioStreamPlayer.new()
	menu_track.stream = AudioStreamOggVorbis.load_from_file("res://resources/audio/music_track_menu.ogg")
	menu_track.bus = "music"
	menu_track.stream.loop = true
	audio_tracks["music_track_menu"] = menu_track
	self.add_child(menu_track)
	var break_track = AudioStreamPlayer.new()
	break_track.stream = AudioStreamOggVorbis.load_from_file("res://resources/audio/music_track_break.ogg")
	break_track.bus = "break"
	break_track.stream.loop = true
	audio_tracks["music_track_break"] = break_track
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

func play_sfx(name: String, randomize_pitch: bool, _custom_volume: float = 1):
	var player = AudioStreamPlayer.new()
	player.stream = streams[name]
	player.pitch_scale = randf_range(0.89, 1.12) if randomize_pitch else 1
	player.bus = "sfx"
	player.volume_db = linear_to_db(_custom_volume)
	self.add_child(player)
	player.play()
	await player.finished
	player.queue_free()
	
	
