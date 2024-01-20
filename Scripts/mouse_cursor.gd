extends Sprite2D

@export var basic_cursor: Texture
@export var click_cursor: Texture

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	texture = basic_cursor

func _process(_delta):
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("click"):
		texture = click_cursor
	if Input.is_action_just_released("click"):
		texture = basic_cursor
