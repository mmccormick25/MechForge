extends Node2D
class_name EnemyCardDisplay

# Card to be displayed
var enemy_card_data : EnemyCard
var slot_num : int

# References to child nodes
@onready var border_sprite = $Border
@onready var rules_label = $RulesLabel
@onready var name_label = $NameLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	return

# Assign cenemy_card to this display
func set_card(enemy_card):
	enemy_card_data = enemy_card
	
	# If card not provided
	if not enemy_card:
		rules_label.text = ""
		name_label.text = ""
		return
		
	# Otherwise if card provided
	rules_label.text = enemy_card.rules
	name_label.text = enemy_card.name
	
