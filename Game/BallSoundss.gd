extends AudioStreamPlayer2D

onready var sound_effects = [
	preload("res://assets/sfx/ball/TennisBall_01.wav"),
	preload("res://assets/sfx/ball/TennisBall_02.wav"),
	preload("res://assets/sfx/ball/TennisBall_03.wav"),
	preload("res://assets/sfx/ball/TennisBall_04.wav"),
	preload("res://assets/sfx/ball/TennisBall_05.wav"),
	preload("res://assets/sfx/ball/TennisBall_06.wav")
]

func _ready():
	next_sound()

func play_sound():
	play()
	next_sound()
	
func next_sound():
	stream = sound_effects[randi() % 1]
