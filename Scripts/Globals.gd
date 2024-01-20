extends Node

signal game_over_signal()

var max_game_time = 30
var end_game_time
var isWin = false
var item_selected = null
var max_ball_count = 4
var current_ball_count = 2:
	set(new_ball_count):
		current_ball_count = new_ball_count
		if current_ball_count <= 1:
			isWin = false
			end_game()
			
var enemy_count = 3
var base_paw_wait_time = 3.0
var min_ball_speed = 100.0
var max_ball_speed = 120.0
var game_mode_name = "Normal"
var v_offsets = [300, 400, 400, 400, 400, 250, 400, 400, 300]
var colored = true

var paw_sides = {"left":[],"right":[],"top":[],"bottom":[]}

func _ready():
	current_ball_count = max_ball_count
	item_selected = null
	
func end_game():
	# send signals to end timers etc
	emit_signal("game_over_signal", isWin)
	print("game end")

func reset_values():
	isWin = false
	item_selected = null
	current_ball_count = max_ball_count
	
func get_free_side(paw):
	var choices = []
	for side in paw_sides:
		if paw in paw_sides[side]:
			paw_sides[side].remove(paw)
		if paw_sides[side].size() < 2:
			choices.append(side)
	if choices.size() == 0:
		return ["left","right","top","bottom"].pick_random()
	return choices.pick_random()
