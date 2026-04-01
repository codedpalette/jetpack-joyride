class_name UI
extends Control

signal started
@onready var start_ui: Control = $StartUI
@onready var title_label: Label = $StartUI/VBoxContainer/TitleLabel
@onready var start_button: TextureButton = $StartUI/VBoxContainer/StartButton
@onready var game_ui: Control = $GameUI
@onready var score_label: Label = $GameUI/ScoreLabel
@onready var final_score_label: Label = $StartUI/VBoxContainer/FinalScoreLabel

func _ready() -> void:
    start_button.pressed.connect(_on_start_button_pressed)
    game_ui.hide()

func show_start_ui(score: int, high_score: int) -> void:
    start_ui.show()
    game_ui.hide()
    final_score_label.show()
    if score > high_score:
        final_score_label.text = "New high score: %s!" % score
    else:
        final_score_label.text = "Score: %s" % score

func show_score(score: int) -> void:
    score_label.text = str(score)

func _on_start_button_pressed() -> void:
    start_ui.hide()
    title_label.hide()
    game_ui.show()
    started.emit()
