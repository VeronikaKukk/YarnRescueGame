extends RigidBody2D

var is_dragging = false
var velocity = Vector2(100, 100)# initial velocity
var dir = [-1,1]
var mouse_over = false
var min_speed
var max_speed
var is_allowed_to_mouse = true
@export var texture_choices: Array[Texture]
var start_pos
var rot_dir = -1

func _ready():
	min_speed = Globals.min_ball_speed
	max_speed = Globals.max_ball_speed
	velocity = Vector2(get_random_velocity(), get_random_velocity())
	$Sprite2D.rotation = randi_range(-30,150)
	if Globals.colored:
		$Sprite2D.texture = texture_choices.pick_random()
	else:
		$Sprite2D.texture = texture_choices[3]

func _process(_delta):
	if is_dragging:
		$Sprite2D.modulate -= Color(0.005,0.005,0.005, 0)
		update_drag()
	if mouse_over and is_allowed_to_mouse:
		$hoverring.visible = true
	elif !is_allowed_to_mouse or !mouse_over:
		$hoverring.visible = false

func _physics_process(delta):
	if !is_dragging:
		$Sprite2D.rotation += 0.005 * rot_dir
		var motion = velocity * delta
		var collision_info = move_and_collide(motion)
		if collision_info:
			#velocity = velocity.bounce(collision_info.get_normal())
			velocity = Vector2(get_random_velocity(), get_random_velocity())
			$YarnCollide.play()
			$Sprite2D.rotation += 0.05
			rot_dir = -rot_dir

func update_drag():
	var mouse_position = get_global_mouse_position()
	var viewport_size = get_viewport_rect().size
	global_position.x = clamp(mouse_position.x, 0, viewport_size.x)
	global_position.y = clamp(mouse_position.y, 0, viewport_size.y)

func _input(event):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("click") and mouse_over and !Globals.item_selected and is_allowed_to_mouse:
			is_dragging = true
			Globals.item_selected = self
			$PickUpActive.play()
			#$BallCollision.disabled = true
			$MaxHoldTimer.wait_time = 2.0
			$MaxHoldTimer.start()
			start_pos = global_position
		elif Input.is_action_just_released("click") and is_dragging and Globals.item_selected:
			is_dragging = false
			Globals.item_selected = null
			#$BallCollision.disabled = false
			$DropDown.play()
			$MaxHoldTimer.stop()
			$WaitTimer.wait_time = 0.5
			$WaitTimer.start()
			is_allowed_to_mouse = false
			$Sprite2D.modulate = Color.DARK_GRAY
			var mouse_position = get_global_mouse_position()
			var direction = (mouse_position - start_pos).normalized()
			velocity = direction * max_speed
			#velocity = Vector2(get_random_velocity(), get_random_velocity())

func get_random_velocity():
	return randi_range(min_speed, max_speed) * dir.pick_random()

func _on_area_2d_mouse_entered():
	mouse_over = true

func _on_area_2d_mouse_exited():
	mouse_over = false
	$hoverring.visible = false

func _on_max_hold_timer_timeout():
	is_allowed_to_mouse = false
	is_dragging = false
	Globals.item_selected = null
	$Sprite2D.modulate = Color.DARK_GRAY
	$WaitTimer.wait_time = 2.0
	$WaitTimer.start()
	$DropDown.play()
	
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - start_pos).normalized()
	velocity = direction * max_speed

func _on_wait_timer_timeout():
	is_allowed_to_mouse = true
	$Sprite2D.modulate = Color.WHITE
