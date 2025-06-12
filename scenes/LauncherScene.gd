extends ColorRect

@onready
var title_logo: TextureRect = $Title

var _title_logo_speed: float = 38.0

var _title_logo_direction = "up"

var _title_logo_move_max = 26.0

var _title_logo_move_offset = 0.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var distance = _title_logo_speed * delta
	if _title_logo_direction == "up":
		distance = distance * -1.0
	else:
		distance = distance * 1.0
	title_logo.position.y += distance
	_title_logo_move_offset += distance
	if abs(_title_logo_move_offset) >= _title_logo_move_max:
		if _title_logo_direction == "up":
			_title_logo_direction = "down"
		else:
			_title_logo_direction = "up"
	if Input.is_anything_pressed():
		get_tree().change_scene_to_file('res://scenes/MainScene.tscn')
