extends Control

func _ready():
	$MenuBackgroundMusic.play()
	$Panel/VBoxContainer/VBoxContainer/CheckButton.button_pressed = Globals.colored

func _physics_process(_delta):
	$ParallaxBackground/ParallaxLayer.motion_offset.x += 0.5
	$ParallaxBackground/ParallaxLayer.motion_offset.y += 0.5

func _on_quit_pressed():
	ButtonClick.play()
	get_tree().quit()

func on_start():
	#$MenuBackgroundMusic.stop()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_mode_1_pressed():
	ButtonClick.play()
	Globals.game_mode_name = "Normal"
	Globals.max_game_time = 60
	Globals.max_ball_count = 6
	Globals.current_ball_count = Globals.max_ball_count
	Globals.enemy_count = 3
	Globals.base_paw_wait_time = 4.0
	Globals.min_ball_speed = 90.0
	Globals.max_ball_speed = 130.0
	Globals.v_offsets = [250, 300, 300, 400, 400, 400, 400, 400]
	on_start()


func _on_mode_2_pressed():
	ButtonClick.play()
	Globals.game_mode_name = "Hard"
	Globals.max_game_time = 60
	Globals.max_ball_count = 7
	Globals.current_ball_count = Globals.max_ball_count
	Globals.enemy_count = 4
	Globals.base_paw_wait_time = 2.0
	Globals.min_ball_speed = 100.0
	Globals.max_ball_speed = 160.0
	Globals.v_offsets = [250, 250, 300, 300, 300, 400]
	on_start()

func _on_mode_3_pressed():
	ButtonClick.play()
	Globals.game_mode_name = "Endless"
	Globals.max_game_time = 0
	Globals.max_ball_count = 8
	Globals.current_ball_count = Globals.max_ball_count
	Globals.enemy_count = 3
	Globals.base_paw_wait_time = 3.0
	Globals.min_ball_speed = 90.0
	Globals.max_ball_speed = 150.0
	Globals.v_offsets = [250, 300, 300, 400, 400, 400, 400, 400]
	on_start()

func _on_mode_4_pressed():
	ButtonClick.play()
	Globals.game_mode_name = "Custom"
	Globals.max_game_time = 30
	Globals.max_ball_count = 2
	Globals.current_ball_count = Globals.max_ball_count
	Globals.enemy_count = 2
	Globals.base_paw_wait_time = 4.0
	Globals.min_ball_speed = 100.0
	Globals.max_ball_speed = 100.0
	Globals.v_offsets = [250, 300, 300, 400, 400, 400, 400, 400]
	var custom = preload("res://Scenes/custom_settings.tscn").instantiate()
	get_tree().current_scene.add_child(custom)

func _on_credits_pressed():
	ButtonClick.play()
	var credits = preload("res://Scenes/credits.tscn").instantiate()
	get_tree().current_scene.add_child(credits)

func _on_instructions_pressed():
	ButtonClick.play()
	var instructions = preload("res://Scenes/inscrutions.tscn").instantiate()
	get_tree().current_scene.add_child(instructions)


func _on_options_pressed():
	ButtonClick.play()
	var options = preload("res://Scenes/options.tscn").instantiate()
	get_tree().current_scene.add_child(options)

func _on_check_button_pressed():
	ButtonClick.play()
	Globals.colored = $Panel/VBoxContainer/VBoxContainer/CheckButton.is_pressed()
