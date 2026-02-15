extends Node2D

class_name EnemyBot

@onready var bot_texture = $EnemyBotTexture
@onready var health_label = $HealthNumberLabel

var bot_name : String
var bot_health : int = 100
var enemy_deck : EnemyDeck

# This runs before _ready of child nodes
func _enter_tree() -> void:
	enemy_deck = EnemyDeck.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize enemy deck displaying top card
	enemy_deck.emit_signal("top_card_changed", enemy_deck.get_top_card())
	pass # Replace with function body.

func take_turn(battle : Battle) -> void:
	enemy_deck.play_top_card(battle)
	# Wait to show damage after playing enemy card
	await get_tree().create_timer(1.0).timeout
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func take_damage(dmg: int) -> void:
	bot_health -= dmg
	health_label.text = str(bot_health)
