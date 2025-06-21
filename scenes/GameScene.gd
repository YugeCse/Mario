extends Node2D

## 马里奥玩家
@onready
var marioPlayer: MarioPlayer = $MarioPlayer

@onready
var coinCounter: RichTextLabel = \
	$HUDContainer/MarginContainer/HBoxContainer/CoinCounter

## 时间计数器
var timerCountInt: int = 0

## 时间计数的定时器组件
@onready
var timeTimer: Timer = $TimerContainer/Timer

## 时间计数器的文本控件
@onready
var timerCounter: RichTextLabel = $TimerContainer/TimerCounter

## 准备事件
func _ready() -> void:
	# $BgAudioPlayer.play() # 播放背景音乐
	_start_time_timer_counter() # 开始计时器计算时间显示

func _physics_process(delta: float) -> void:
	coinCounter.text = 'x %d' % GlobalConfig.player_coin_count

## 开始计算时间显示
func _start_time_timer_counter():
	timeTimer.one_shot = false
	timeTimer.wait_time = 1
	timeTimer.timeout.connect(_on_timer_timeout)
	timeTimer.start()

## 定时器事件
func _on_timer_timeout() -> void:
	timerCountInt += 1 # 每次增加1秒
	var minutes = int((timerCountInt % 60) / 60.0)
	var seconds = int((timerCountInt % 60) % 60)
	timerCounter.text = "时间  %02d:%02d" % [minutes, seconds]
