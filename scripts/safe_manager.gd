extends Node

var settings = {"sfx_volume": 10, "music_volume": 10, "particles_enabled": true}
var level_coins = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var unlocked_levels = 1

func load_savefile():
	var file = FileAccess.open("user://savefile.dat", FileAccess.READ)
	if file:
		var content = file.get_var()
		settings = content["settings"]
		level_coins = content["level_coins"]
		unlocked_levels = content["unlocked_levels"]
		AudioServer.set_bus_volume_db(1 ,linear_to_db(settings["sfx_volume"] / 10))
		AudioServer.set_bus_volume_db(2 ,linear_to_db(settings["music_volume"] / 10))
	else:
		save_savefile()
func save_savefile():
	AudioServer.set_bus_volume_db(1 ,linear_to_db(settings["sfx_volume"] / 10))
	AudioServer.set_bus_volume_db(2 ,linear_to_db(settings["music_volume"] / 10))
	var content = {
		"settings": settings,
		"level_coins": level_coins,
		"unlocked_levels": unlocked_levels
		}
	var file = FileAccess.open("user://savefile.dat", FileAccess.WRITE)
	if file:
		file.store_var(content)

func _ready() -> void:
	load_savefile()
		
	
