extends Control



func _on_button_pressed():
	ButtonClick.play()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_button_2_pressed():
	ButtonClick.play()
	queue_free()
