extends CanvasLayer

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		ButtonClick.play()
		var exists = get_tree().get_root().get_node_or_null("Main/CanvasLayer/Options")
		if exists == null:
			get_tree().paused = true
			var options = preload("res://Scenes/options.tscn").instantiate()
			get_tree().get_root().get_node("Main/CanvasLayer").add_child(options)
			options.get_node("Panel/VBoxContainer/VBoxContainer/VBoxContainer/MenuButton").visible = true
		else:
			get_tree().paused = false
			exists.queue_free()

func _on_pause_button_pressed():
	ButtonClick.play()
	var exists = get_tree().get_root().get_node_or_null("Main/CanvasLayer/Options")
	if exists == null:
		get_tree().paused = true
		var options = preload("res://Scenes/options.tscn").instantiate()
		get_tree().get_root().get_node("Main/CanvasLayer").add_child(options)
		options.get_node("Panel/VBoxContainer/VBoxContainer/VBoxContainer/MenuButton").visible = true
	else:
		get_tree().paused = false
		exists.queue_free()
