## 马里奥玩家类
class_name MarioPlayer extends CharacterBody2D

## 上跳的垂直方向值：-360.0
const JUMP_FORCE = -360.0

## 单次最大可跳跃次数：2
const JUMP_MAX_COUNT = 2

## 重力值：980.0
var gravity: float = 980.0

## 行走时的速度：120为初始速度
var walk_speed: float = 120.0

## 跳跃计数，最大不超过2次
var jump_count: float = 0

## 之前是否时在地板上
var was_on_floor: bool = false

## 准备事件
func _ready() -> void:
	set_process_input(true)
	$Area2D.area_entered.connect(_on_area_entered)

## 物理过程事件，每帧调用一次
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta # 加上重力，重力加速度
	var is_on_floor_now = is_on_floor()
	if was_on_floor and not is_on_floor_now: # 此时在空中，还可以跳转的次数设置为1
		jump_count = 1
	if Input.is_action_just_pressed(&'ui_jump'):
		var allow_jump: bool = false
		if is_on_floor_now: # 在地板上，可以直接跳
			jump_count = 1
			allow_jump = true
			velocity.y = JUMP_FORCE
		elif jump_count < JUMP_MAX_COUNT: # 在空中二次跳
			jump_count += 1
			allow_jump = true
			velocity.y = JUMP_FORCE * 0.9 # 二次跳，垂直向上有衰减
		if allow_jump: # 允许跳跃
			$AudioStreamPlayer.play() # 播放跳跃声音
			$ASprites.play('jump') # 播放跳跃动画
	was_on_floor = is_on_floor_now
	var target_velocity_x = 0.0
	if Input.is_action_pressed(&'ui_left'):
		$ASprites.play('walk')
		$ASprites.flip_h = true
		target_velocity_x = - walk_speed # 左移时速度为负
	elif Input.is_action_pressed(&'ui_right'):
		$ASprites.play('walk')
		$ASprites.flip_h = false
		target_velocity_x = walk_speed # 右移时速度为正
	else:
		$ASprites.play('default')
		target_velocity_x = 0.0 # 没有左右按键时，水平速度为0
	if not is_on_floor_now: # 如果不在地上，水平速度变化慢一些
		velocity.x = lerp(velocity.x, target_velocity_x, 0.8) # 在空中时，水平速度变化慢一些
	else:
		velocity.x = target_velocity_x # 在地上时，水平速度是正常的
	if not move_and_slide(): # 移动并执行滑动
		return # 如果移动未发生碰撞，则不执行下面的代码

## 处理碰撞事件
func _handle_collision_events() -> void:
	var collider = get_last_slide_collision() # 获取最后一次滑动碰撞
	print_debug('发生了碰撞事件，被碰撞者是：' + collider.name)
	# if collider.is_in_group('enemy'):
	# 	velocity.y = JUMP_FORCE # 跳起来
	# 	velocity.x = 0.0 # 停止水平移动

## 处理区域进入事件，一般为碰撞检测
func _on_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	print_debug('进入了区域：' + area.name)
	if parent is GoldCoin: # 与金币发生碰撞
		parent.remove_from_parent() # 销毁金币
		GlobalConfig.player_coin_count += 1 # 玩家金币数加1
	elif parent is GoldBrick: # 与金币砖块发生碰撞
		parent.hurt_by_player()
		#area.get_parent().queue_free() # 销毁金币砖块
		#GlobalConfig.player_coin_count += 1 # 玩家金币数加1
