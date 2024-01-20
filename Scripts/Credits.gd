extends Control

func _on_button_pressed():
	ButtonClick.play()
	queue_free()
