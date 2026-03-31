@tool
class_name World
extends Node2D

@onready var player_track: Node2D = $PlayerTrack
@onready var obstacle_spawner: ObstacleSpawner = $ObstacleSpawner
@onready var ceiling_body: StaticBody2D = $Ceiling
@onready var floor_body: StaticBody2D = $Floor
@onready var background: Background = $Background

func _process(_delta: float) -> void:
    if Engine.is_editor_hint():
        obstacle_spawner.curve.set_point_position(0, ceiling_body.position + Vector2.DOWN * 20)
        obstacle_spawner.curve.set_point_position(1, floor_body.position + Vector2.UP * 20)

func start(player: Player) -> void:
    player.reset()
    for child in player_track.get_children():
        if child is Bullet:
            player_track.remove_child(child)
    player_track.add_child(player)
    obstacle_spawner.start()
    background.is_moving = true

func stop(player: Player) -> void:
    background.is_moving = false
    obstacle_spawner.stop()
    player_track.remove_child(player)
