@tool
class_name World
extends Node2D

@onready var player_track: Node2D = $PlayerTrack
@onready var obstacle_spawner: Path2D = $ObstacleSpawner
@onready var ceiling_body: StaticBody2D = $Ceiling
@onready var floor_body: StaticBody2D = $Floor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    if Engine.is_editor_hint():
        obstacle_spawner.curve.set_point_position(0, ceiling_body.position + Vector2.DOWN * 20)
        obstacle_spawner.curve.set_point_position(1, floor_body.position + Vector2.UP * 20)


func add_player(player: Player) -> void:
    player_track.add_child(player)