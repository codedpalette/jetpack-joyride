class_name UI
extends Control

@onready var start_ui: Control = $StartUI
@onready var start_button: Button = $StartUI/StartButton
signal started

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    start_button.pressed.connect(_on_start_button_pressed)

func show_start_ui() -> void:
    start_ui.show()

func _on_start_button_pressed() -> void:
    start_ui.hide()
    started.emit()
