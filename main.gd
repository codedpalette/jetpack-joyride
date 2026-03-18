extends Node

@onready var world: World = $World
var player_scene := preload("res://entities/player/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var player: Player = player_scene.instantiate()
    world.add_player(player)
