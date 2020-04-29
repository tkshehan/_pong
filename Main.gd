extends Node

# don't forget to use stretch mode 'viewport' and aspect 'ignore'
onready var viewport = get_viewport()
onready var game = load("res://Game/Game.tscn")

func _ready():
	# Handle window resizing to maintain pixel stretching
	var _err = get_tree().connect("screen_resized", self, "_screen_resized")
	GameState.root_scene = self
	if OS.get_name() == "HTML5":
		$GUI/FocusWindow.visible = true
	
	var splash_screen = load('res://SplashScreen.tscn').instance()
	$GUI.add_child(splash_screen, true)
	splash_screen.connect('tree_exited', self, 'load_title')

func load_title():
	var title = load("res://TitleScreen/TitleScreen.tscn").instance()
	$GUI.add_child(title, true)
	
func _on_start_1p():
	GameState.num_of_players = 1
	start_game()
	
func _on_start_2p():
	GameState.num_of_players = 2
	start_game()
	
func _on_start_0p():
	GameState.num_of_players = 0
	start_game()
	
func start_game():
	$GUI/TitleScreen.queue_free()
	$Game.add_child(
		game.instance()
	)
	
func reset():
	$Game.get_child(0).queue_free()
	load_title()
	
func _screen_resized():
	var window_size = OS.get_window_size()

	# see how big the window is compared to the viewport size
	# floor it so we only get round numbers (0, 1, 2, 3 ...)
	var scale_x = floor(window_size.x / viewport.size.x)
	var scale_y = floor(window_size.y / viewport.size.y)

	# use the smaller scale with 1x minimum scale
	var scale = max(1, min(scale_x, scale_y))

	# extend the viewport to actually fit the screen as much as possible, in pixel perfect amounts
	#find the scaled size difference (basically visual pixel difference) between the screen and viewport dimensions
	var sizeDiff = window_size - (viewport.size * scale)
	var pixelDiff = (sizeDiff/scale).ceil()
	#If either dimension is odd, make it even by adding a pixel (otherwise you might have everything offset by a half pixel)
	if int(pixelDiff.x) % 2 == 1:
		pixelDiff.x += 1
	if int(pixelDiff.y) % 2 == 1:
		pixelDiff.y += 1
	#Now actually scale up the viewport to make it fill the screen
	viewport.set_size(viewport.size + pixelDiff)


	# find the coordinate we will use to center the viewport inside the window
	var diff = window_size - (viewport.size * scale)
	var diffhalf = (diff * 0.5).floor()

	# attach the viewport to the rect we calculated
	viewport.set_attach_to_screen_rect(Rect2(diffhalf, viewport.size * scale))

func _notification(what) -> void:
	match what:
		MainLoop.NOTIFICATION_WM_FOCUS_IN:
			$GUI/FocusWindow.visible = false
			get_tree().paused = GameState.paused
		MainLoop.NOTIFICATION_WM_FOCUS_OUT:
			$GUI/FocusWindow.visible = true
			get_tree().paused = true

