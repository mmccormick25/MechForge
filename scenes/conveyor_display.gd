extends Node2D

@onready var battle: Battle = get_parent()
@onready var conveyor_canvas = $ConveyorCanvas
@onready var slot_0 = $Slot0
@onready var slot_1 = $Slot1
@onready var slot_2 = $Slot2
@onready var slot_3 = $Slot3

const CARD_DISPLAY_SCENE = preload("res://ui/card_display/card_display.tscn")

func _ready() -> void:
	battle.conveyor.card_added.connect(_spawn_card)
	battle.card_played.connect(_on_card_played)

func _spawn_card(card : Card, slot : int):
	# Create new card_display scene
	var new_card_display = CARD_DISPLAY_SCENE.instantiate()
	# Set slot num
	new_card_display.slot_num = slot
	# Set battle controller (for passing signal)
	new_card_display.battle = battle
	
	# Connect clicked signal
	# new_card_display.card_clicked.connect(BattleController._on_card_clicked)
	# Add to tree
	conveyor_canvas.add_child(new_card_display)
	
	# Position in conveyor (TEMP)
	var new_position : Vector2
	match slot:
		0:
			new_position = slot_0.position
		1:
			new_position = slot_1.position
		2:
			new_position = slot_2.position
		3:
			new_position = slot_3.position
	new_card_display.position = position + new_position
	
	# Set card to be displayed
	new_card_display.set_card(card)
	
func _on_card_played(card_display: CardDisplay, slot: int):
	if card_display and card_display.is_inside_tree():
		card_display.queue_free()
	
	
