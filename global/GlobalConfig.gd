## 全局配置信息
extends Node

## 地图宽度-640
const MAP_WIDTH = 640

## 地图高度-480
const MAP_HEIGHT = 480

## 地图尺寸 W:H
const MAP_SIZE = Vector2(MAP_WIDTH, MAP_HEIGHT)

## 地图地块大小-16
const MAP_TILE_SIZE = 16

## 当前游戏等级-1
var current_level: int = 1

## 玩家生命数
var player_life_count: int = 3

## 玩家收集的金币数量
var player_coin_count: int = 0