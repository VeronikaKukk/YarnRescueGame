extends Node2D

var is_paw_moving = false
var speed = 200
var side = ["left","right","top","bottom"]
var chosen_side = "left"
var speed_up = 0.05
var v_offsets = [300, 400, 400, 400, 400, 250, 400, 400, 300]
@export var texture_choices: Array[Texture]
@export var texture_choices2: Array[Texture]
var sprite_idx = 0
var catched = false


var sound_has_played = false
func _ready():
	v_offsets = Globals.v_offsets
	reset_path()
	

func start_timer():
	$Timer.one_shot = true
	var wait_time = Globals.base_paw_wait_time-speed_up + randi_range(0,2)
	speed_up += 0.3
	$Timer.wait_time = wait_time
	$Timer.start()

func _physics_process(delta):
	if is_paw_moving:
		$Path2D/PathFollow2D.set_progress($Path2D/PathFollow2D.get_progress() + speed*delta)
	if $Path2D/PathFollow2D.get_progress_ratio() >= 0.9:
		is_paw_moving = false
		reset_path()
	if $Path2D/PathFollow2D.get_progress_ratio() >= 0.15:
		$EnemyApproachingSymbol.visible = false
		if !sound_has_played:
			sound_has_played = true
			$PawMeowing.play()

func _on_timer_timeout():
	show_enemy_approach_symbol()
	paw_movement()
	
func show_enemy_approach_symbol():
	$EnemyApproachingSymbol.visible = true
	if chosen_side == "left":
		global_position = Vector2(0,randi_range(0,get_viewport_rect().size.y-200))
		rotation_degrees = 90
	elif chosen_side == "top":
		global_position = Vector2(randi_range(0,get_viewport_rect().size.x-200),0)
		rotation_degrees = 180
	elif chosen_side == "bottom":
		global_position = Vector2(randi_range(0,get_viewport_rect().size.x-200),get_viewport_rect().size.y)
		rotation_degrees = 0
	elif chosen_side == "right":
		global_position = Vector2(get_viewport_rect().size.x, randi_range(0+200,get_viewport_rect().size.y))
		rotation_degrees = -90

func paw_movement():
	is_paw_moving = true

func _on_area_2d_body_entered(body):
	if body.name.begins_with("Ball") and !catched:
		catched = true
		$Path2D/PathFollow2D/pawcomponent/Sprite2D.texture = texture_choices[sprite_idx]
		body.queue_free()
		Globals.current_ball_count -= 1

func reset_path():
	sound_has_played = false
	catched = false
	$Path2D/PathFollow2D.set_progress_ratio(0.0)
	$EnemyApproachingSymbol.visible = false
	sprite_idx = randi() % 5
	$Path2D/PathFollow2D/pawcomponent/Sprite2D.texture = texture_choices2[sprite_idx]
	start_timer()
	chosen_side = Globals.get_free_side(self)
	$Path2D/PathFollow2D.v_offset = v_offsets.pick_random()
	$Path2D/PathFollow2D/pawcomponent.rotation_degrees = randf_range(-20,20)
	if chosen_side == "left":
		global_position = Vector2(0,randi_range(10,get_viewport_rect().size.y-200))
		rotation_degrees = 90
	elif chosen_side == "top":
		global_position = Vector2(randi_range(0+200,get_viewport_rect().size.x),0)
		rotation_degrees = 180
	elif chosen_side == "bottom":
		global_position = Vector2(randi_range(10,get_viewport_rect().size.x-200),get_viewport_rect().size.y)
		rotation_degrees = 0
	elif chosen_side == "right":
		global_position = Vector2(get_viewport_rect().size.x, randi_range(0+200,get_viewport_rect().size.y))
		rotation_degrees = -90
