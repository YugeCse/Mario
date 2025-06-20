class_name GoldBrick extends AnimatedSprite2D

func _ready() -> void:
    play('default')
    name = 'GoldBrick'
    $Area2D.name = 'GoldBrickArea'