class_name UI
extends Control

signal started
@onready var start_ui: Control = $StartUI
@onready var title_label: Label = $StartUI/VBoxContainer/TitleLabel
@onready var start_button: TextureButton = $StartUI/VBoxContainer/StartButton

func _ready() -> void:
    start_button.pressed.connect(_on_start_button_pressed)

func show_start_ui() -> void:
    start_ui.show()

func _on_start_button_pressed() -> void:
    start_ui.hide()
    title_label.hide()
    started.emit()
