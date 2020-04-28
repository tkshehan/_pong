extends AudioStreamPlayer2D

onready var sound_effects = [
	preload("res://assets/sfx/ball/TennisBall_01.wav"),
]

func _ready():
	next_sound()

func play_sound():
	play()
	next_sound()
	
func next_sound():
	stream = sound_effects[randi() % 1]
