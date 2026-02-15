extends Node2D

@onready var enemy_bot: EnemyBot = get_parent()
@onready var battle: Battle = get_parent().get_parent().get_parent()

const ENEMY_CARD_DISPLAY_SCENE = preload("res://ui/enemy_card_display/enemy_card_display.tscn")

var current_card_display: EnemyCardDisplay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_bot.enemy_deck.top_card_changed.connect(_on_top_card_changed)
	pass # Replace with function body.

func _on_top_card_changed(new_card : EnemyCard) -> void:
	current_card_display = new_card.enemy_card_display

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
