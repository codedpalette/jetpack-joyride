extends Node

var player_scene := preload("res://entities/player/player.tscn")
var player: Player
var score: float = 0
var high_score: int = 0
var is_playing: bool = false
@onready var world: World = $World
@onready var ui: UI = $UI

func _ready() -> void:
    player = player_scene.instantiate()
    ui.started.connect(_on_ui_started)
    player.died.connect(_on_player_died)

func _process(delta: float) -> void:
    if is_playing:
        score += randf_range(5, 15) * delta
        ui.show_score(int(score))

func _on_ui_started() -> void:
    world.start(player)
    is_playing = true

func _on_player_died() -> void:
    is_playing = false
    world.stop()
    ui.show_start_ui(int(score), high_score)
    high_score = max(high_score, int(score))
    score = 0