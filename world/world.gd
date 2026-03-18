class_name World
extends Node2D

@onready var player_track: Node2D = $PlayerTrack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass

func add_player(player: Player) -> void:
    player_track.add_child(player)