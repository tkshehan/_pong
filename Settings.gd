extends Node

const SAVE_PATH = "res://config.cfg"

var _config_file = ConfigFile.new()
var _settings = {
	"audio": {
		"master_volume": 2000,
		"music_volume": 2000,
		"effects_volume": 2000,
		"mute": false
	},
	"video": {
		"height": ProjectSettings.get_setting("display/window/size/height"),
		"width": ProjectSettings.get_setting("display/window/size/width")
	},
	"controls": {},
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func save_settings():
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])
	print(_config_file.save(SAVE_PATH))
	

func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		print("Failed to load settings. Error Code %s" % error)
		return
	
	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key, null)
		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
