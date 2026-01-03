extends Node2D
class_name CardDisplay

# Card to be displayed
var card_data : Card
var slot_num : int

# Great grand parent :(
@onready var battle: Battle = get_parent().get_parent().get_parent()
# References to child nodes
@onready var border_sprite = $Border
@onready var card_art = $CardArt
@onready var name_label = $NameLabel
@onready var cost_label = $CostLabel
@onready var rules_label = $RulesLabel

# Signals for interaction
signal card_clicked(slot: int)
signal card_hovered(display: CardDisplay)
signal card_unhovered(display: CardDisplay)

# Hover scale
var hover_scale = Vector2(1.2, 1.2) # Scaled display
var normal_scale = Vector2(1, 1) # Normal display

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self.set_card(RewindCard.new())
	card_clicked.connect(battle.play_card)
	# Enable mouse input detection
	set_process_input(true)
	set_process(true)

# Assign card to this display
func set_card(card):
	card_data = card
	
	# If card not provided
	if not card:
		name_label.text = ""
		cost_label.text = ""
		rules_label.text = ""
		card_art.texture = null
		return
		
	# Otherwise if card provided
	name_label.text = card.name
	cost_label.text = str(card.cost)
	rules_label.text = card.rules
	card_art.texture = load("res://assets/images/card/" + card.name.replace(" ", "") + "Art.png")
		
# Click detection
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("card_clicked", slot_num)
		
		

# Hover detection
func _on_area_2d_mouse_entered() -> void:	
	emit_signal("card_hovered", self)
	var tween = create_tween()
	tween.tween_property(self, "scale", hover_scale, 0.2)

# Unhover detection
func _on_area_2d_mouse_exited() -> void:
	emit_signal("card_unhovered", self)
	var tween = create_tween()
	tween.tween_property(self, "scale", normal_scale, 0.2)
