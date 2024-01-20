extends Timer

func _ready():
	if Globals.max_game_time > 1:
		wait_time = Globals.max_game_time
		start()
		one_shot = true

func _on_timeout():
	print("time over")
	Globals.isWin = true
	Globals.end_game()

func _process(_delta):
	if Globals.max_game_time > 1:
		$"../CanvasLayer/TimerLabel".text = "Time left: %.1f"%time_left
