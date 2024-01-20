extends Control

func _on_back_button_pressed():
	ButtonClick.play()
	get_tree().paused = false
	queue_free()

func _on_quit_button_pressed():
	ButtonClick.play()
	get_tree().paused = false
	Globals.reset_values()
	get_tree().change_scene_to_file("res://Scenes/game_start_screen.tscn")
