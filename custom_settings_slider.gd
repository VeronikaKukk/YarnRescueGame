extends HSlider

@export var setting_name: String

func _ready():
	value_changed.connect(_on_value_changed)
	if setting_name == "enemy":
		$Label.text = str(2)
	elif setting_name == "ball":
		$Label.text = str(2)
	elif setting_name == "time":
		$Label.text = str(30)
	elif setting_name == "yarn_speed":
		$Label.text = str(100)
	
func _on_value_changed(value: int):
	$Label.text = str(value)
	if setting_name == "enemy":
		Globals.enemy_count = value
	elif setting_name == "ball":
		Globals.max_ball_count = value
		Globals.current_ball_count = Globals.max_ball_count
	elif setting_name == "time":
		Globals.max_game_time = value
	elif setting_name == "yarn_speed":
		Globals.min_ball_speed = value
		Globals.max_ball_speed = value

func _on_mouse_exited():
	self.release_focus()
