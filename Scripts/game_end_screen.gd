extends Control

var perfect_ending = ["Purrfect.", "Litter-ally unstoppable.", "Meow-nificent.", "Best catitude."]
var good_ending = ["Claw-some.","Pawsome Potential.", "Almost purrfect.","Feline good.", "Nice catitude."]
var bad_ending = ["Un-Fur-tunately not good.", "Meow...", "Litter-ally sad.","Fur-real?","Cat-astrophe.", "Un-Fur-giveable performance.","Not claw-some."]
var ending_text = "Cat."
# Called when the node enters the scene tree for the first time.
func _ready():
	set_end_texts()
	$MenuBackgroundMusic.play()

func set_end_texts():
	if Globals.isWin:
		$Panel/VBoxContainer/EndText.text = "You win!"
		$Panel/VBoxContainer/ScoreText.text = "You kept "+str(Globals.current_ball_count) +" yarn balls out of "+ str(Globals.max_ball_count)+". \n("+(Globals.game_mode_name)+" mode)"
	else:
		$Panel/VBoxContainer/EndText.text = "You lost!"
		$Panel/VBoxContainer/ScoreText.text = "You lost all your yarn balls." + " ("+(Globals.game_mode_name)+" mode)"
	if Globals.game_mode_name != "Endless":
		var score = float(Globals.current_ball_count) / float(Globals.max_ball_count)
		if score >= 0.9:
			ending_text = perfect_ending.pick_random()
		elif score >= 0.4 or Globals.current_ball_count >= 2:
			ending_text = good_ending.pick_random()
		else:
			ending_text = bad_ending.pick_random()
		$Panel/VBoxContainer/ScoreText2.text = ending_text
	else:
		$Panel/VBoxContainer/ScoreText2.text = "Meow!"
func _on_replay_pressed():
	ButtonClick.play()
	Globals.reset_values()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_main_menu_pressed():
	ButtonClick.play()
	Globals.reset_values()
	get_tree().change_scene_to_file("res://Scenes/game_start_screen.tscn")

