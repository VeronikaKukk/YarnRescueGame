extends Node2D

@onready var ball_scene = preload("res://Scenes/ball.tscn")
@onready var enemy_paw_scene = preload("res://Scenes/paw.tscn")
@export var bg_textures: Array[Texture]

func _ready():
	Globals.game_over_signal.connect(on_game_over)
	for n in Globals.max_ball_count:
		var ball = ball_scene.instantiate()
		ball.set_name("Ball"+str(n))
		ball.position = Vector2(100+n*20,100+n*20)
		$Balls.add_child(ball)
	for n in Globals.enemy_count:
		var enemy = enemy_paw_scene.instantiate()
		enemy.z_index = 1
		enemy.set_name("Paw"+str(n))
		$Enemy.add_child(enemy)
	$GameBackgroundMusic.play()

func on_game_over(_isWin):
	for ball in $Balls.get_children():
		ball.queue_free()
	for enemy in $Enemy.get_children():
		enemy.queue_free()
	Globals.end_game_time = Globals.max_game_time - $GameTimer.time_left
	$GameTimer.stop()
	get_tree().change_scene_to_file("res://Scenes/game_end_screen.tscn")

func _input(event):
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_M:
			_on_color_mode_pressed()

func _on_color_mode_pressed():
	ButtonClick.play()
	if $CanvasLayer/ColorMode.text == "L":
		$TextureRect.texture = bg_textures[1]
		$CanvasLayer/ColorMode.text = "D"
		$CanvasLayer/TimerLabel.modulate = Color.BLACK
	else:
		$TextureRect.texture = bg_textures[0]
		$CanvasLayer/ColorMode.text = "L"
		$CanvasLayer/TimerLabel.modulate = Color.WHITE
