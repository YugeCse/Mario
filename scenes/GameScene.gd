extends Node2D

var timerCountInt: int = 0

@onready
var timeTimer: Timer = $TimerContainer/Timer

@onready
var timerCounter: RichTextLabel = $TimerContainer/TimerCounter

## 准备事件
func _ready() -> void:
	timeTimer.one_shot = false
	timeTimer.wait_time = 1
	timeTimer.connect("timeout", _on_timer_timeout)
	timeTimer.start()
	
## 物理事件，每帧调用
func _physics_process(delta: float) -> void:
	pass

## 定时器事件
func _on_timer_timeout() -> void:
	timerCountInt += 1
	var minutes = str((timerCountInt % 60) / 60)
	var seconds = str((timerCountInt % 60) % 60)
	minutes = "0".repeat(2 - max(minutes)) + minutes
	seconds = "0".repeat(2 - max(seconds)) + seconds
	timerCounter.text = minutes + ":" + seconds
