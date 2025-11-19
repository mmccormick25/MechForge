extends Node

class_name Battle

@onready var output_label = $OutputLabel

signal card_played(card_display : CardDisplay, slot : int)

# --- References to your game systems ---
var conveyor: Conveyor
var scrap_pile: ScrapPile
var deck: Deck

var player_bot
var enemy_bot

# This runs before _ready of child nodes
func _enter_tree() -> void:
	deck = Deck.new()
	scrap_pile = ScrapPile.new()
	conveyor = Conveyor.new(4)

# This runs after _ready of child nodes
func _ready() -> void:
	conveyor.add_test_cards()

# ---------------------------------------------------------
# Take a player turn (console-based for now)
# ---------------------------------------------------------
func play_card(card_display: CardDisplay, selection: int) -> void:
	print("")
	conveyor.print_hand()
	print("SELECTED: " + str(selection))

	# If selection < 0 → player ended turn
	if selection < 0:
		end_turn()
		return

	# Bounds + null check
	if selection < conveyor.conveyor_cards.size():
		var card_to_play = conveyor.conveyor_cards[selection]

		if card_to_play:
			# Remove from conveyor
			conveyor.conveyor_cards[selection] = null
			# Play card
			emit_signal("card_played", card_display, selection)
			card_to_play.play(self, selection)
			# Add card to scrap
			scrap_pile.add_to_scrap(card_to_play)

	# Print updated conveyor
	conveyor.print_hand()


# ---------------------------------------------------------
# Scraps the next card (rightmost non-null or deck fallback)
# ---------------------------------------------------------
func scrap_next_card():
	# Try to find card to scrap from hand
	var scrapped := conveyor.remove_rightmost_card()
	# Scrap from deck if card not found
	if scrapped == null:
		scrapped = deck.remove_top_card()

	# Add found card to scrap
	scrap_pile.add_to_scrap(scrapped)

	print("Scrapped Rightmost Card")
	conveyor.print_hand()


# ---------------------------------------------------------
# Shift conveyor by steps
# ---------------------------------------------------------
func shift_conveyor(steps: int):
	conveyor.shift(steps, deck, scrap_pile)

# ---------------------------------------------------------
# End turn logic
# ---------------------------------------------------------
func end_turn():
	print("\n-- END TURN --")

	scrap_next_card()
	conveyor.smush_cards_to_right()
	conveyor.draw_to_full(deck)
	
