class_name GoldBrick extends AnimatedSprite2D

## 被顶撞的次数
var _hurt_count: int = 0

@onready
var _area2d: Area2D = $Area2D

@onready
var _areaCollisionShape: CollisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	play('default')
	_area2d.area_entered.connect(_on_area_entered)

func _on_area_entered(other: Area2D):
	var parent = other.get_parent()
	if parent is MarioPlayer:
		print_debug('提示：金砖与玩家发生碰撞！')

## 被玩家顶撞
func hurt_by_player():
	$AudioStreamPlayer.play()
	self.position.y -= 5
	await get_tree().create_timer(0.2).timeout
	self.position.y += 5
