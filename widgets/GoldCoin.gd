## 金币对象
class_name GoldCoin extends AnimatedSprite2D

## 金币碰撞Area
@onready
var collisionArea: Area2D = $Area2D

## 金币碰撞形状
@onready
var collisionShape: CollisionShape2D = $CollisionShape2D

func _ready():
    set_frame(0)
    set_name("GoldCoin")
    collisionArea.set_name("GoldCoinArea")
    collisionShape.set_name("GoldCoinShape")

