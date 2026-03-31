extends Node

var player_scene := preload("res://entities/player/player.tscn")
var player: Player
@onready var world: World = $World
@onready var ui: UI = $UI

func _ready() -> void:
    player = player_scene.instantiate()
    ui.started.connect(_on_ui_started)
    player.died.connect(_on_player_died)

func _on_ui_started() -> void:
    world.start(player)

func _on_player_died() -> void:
    world.stop()
    ui.show_start_ui()