## 金币对象
class_name GoldCoin extends AnimatedSprite2D

@onready
var _area2d: Area2D = $Area2D

@onready
var audioPlayer: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	play('default') # 播放默认动画

## 从父节点删除
func remove_from_parent() -> void:
	audioPlayer.play() # 播放音效
	set_deferred('visible', false)
	_area2d.set_deferred('monitoring', false)
	_area2d.set_deferred('monitorable', false)
	await get_tree().create_timer(0.5).timeout
	queue_free()
