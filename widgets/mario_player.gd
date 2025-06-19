extends CharacterBody2D

## 上跳的垂直方向值
const JUMP_FORCE = -360.0

## 单次最大可跳跃次数
const JUMP_MAX_COUNT = 2

## 地心引力值：980.0
var gravity: float = 980.0

## 行走时的速度
var walk_speed: float = 120.0

## 跳跃计数，最大不超过2次
var jump_count: float = 0

## 之前是否时在地板上
var was_on_floor: bool = false

func _ready() -> void:
	set_process_input(true)
	
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var is_on_floor_now = is_on_floor()
	if was_on_floor and not is_on_floor_now:
		jump_count = 1
	if Input.is_action_just_pressed(&'ui_jump'):
		if is_on_floor_now:
			jump_count = 1
			velocity.y = JUMP_FORCE
		elif jump_count < JUMP_MAX_COUNT:
			jump_count += 1
			velocity.y = JUMP_FORCE * 0.9
	was_on_floor = is_on_floor_now
	var target_velocity_x = 0.0
	if Input.is_action_pressed(&'ui_left'):
		$ASprites.play('walk')
		$ASprites.flip_h = true
		target_velocity_x = -walk_speed
	elif Input.is_action_pressed(&'ui_right'):
		$ASprites.play('walk')
		$ASprites.flip_h = false
		target_velocity_x = walk_speed
	else:
		$ASprites.play('default')
	if not is_on_floor_now:
		velocity.x = lerp(velocity.x, target_velocity_x, 0.8)
	else:
		velocity.x = target_velocity_x
	move_and_slide() # 移动并执行滑动
