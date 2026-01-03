extends RefCounted
class_name Conveyor

signal card_added(card : Card, index : int)
signal card_moved(card_display: CardDisplay, slot : int)
signal card_scrapped(card: Card, slot : int)
signal card_to_top_deck(card_display: CardDisplay)

# Cards in conveyor
var conveyor_cards: Array[Card] = []
# Power associated with each conveyor slot
var slot_powers: Array[int] = []
# Conveyor (hand) size
var max_size: int

func _init(_max_size: int):
	
	max_size = _max_size
	conveyor_cards.resize(max_size)
	
	for i in range(max_size - 1, -1, -1):
		slot_powers.append(i)
			
			
func add_test_cards():
	# Fill slot powers + test cards
	for i in range(max_size - 1, -1, -1):
		if i == 0:
			add_card(HydraulicUppercutCard.new(), i)
		elif i == 1:
			add_card(RewindCard.new(), i)
		elif i == 2:
			add_card(SalvageBeamCard.new(), i)
		else:
			add_card(MagneticCannonCard.new(), i)
		
		
func add_card(card : Card, index : int):
	if card != null:
		conveyor_cards[index] = card
		card_added.emit(card, index)
	

# --- SCRAPPING ----------------------------------------------------------

# Set rightmost card to null (end of turn function)
func remove_rightmost_card() -> Card:
	# Loop backward until non_null card found
	for i in range(conveyor_cards.size() - 1, -1, -1):
		var card = conveyor_cards[i]
		if card != null:
			# Set card to null
			conveyor_cards[i] = null
			# Animate card being scrapped
			emit_signal("card_scrapped", card, i)
			return card
	return null
	
# Scrap card at chosen index
func scrap_at_index(slot_index: int, scrap_pile):
	var card = conveyor_cards[slot_index]
	if card != null:
		# Signal to animate card being scrapped
		emit_signal("card_scrapped", card, slot_index)
		# Add card to scrap pile
		scrap_pile.add_to_scrap(conveyor_cards[slot_index])
		# Remove from hand
		conveyor_cards[slot_index] = null
	
## --- SMUSH TO RIGHT -----------------------------------------------------------

# Smush cards to rightside of conveyor
func smush_cards_to_right():
	# New hand layout
	var new_layout: Array[Card] = []
	# Collect non-null cards
	for card in conveyor_cards:
		if card != null:
			new_layout.append(card)
			
	# Clear old hand
	conveyor_cards.clear()

	# Num nulls to fill hand
	var nulls_to_add := max_size - new_layout.size()
	# Fill with nulls (empties)
	for i in range(nulls_to_add):
		conveyor_cards.append(null)

	# Append real cards to the right
	conveyor_cards.append_array(new_layout)
	
	# Animating cards shifting over
	for i in range(conveyor_cards.size()):
		var card = conveyor_cards[i]
		if card != null:
			emit_signal("card_moved", conveyor_cards[i].card_display, i)

	print("Smushed Cards to Right")
	print_hand()


## --- DRAW TO FULL -----------------------------------------------------------

func draw_to_full(deck):
	# Loop backward through hand
	for i in range(conveyor_cards.size() - 1, -1, -1):
		# If conveyor slot empty
		if conveyor_cards[i] == null:
			# Replace with card from top of deck
			add_card(deck.remove_top_card(), i)

	print("Drawing to full hand size")
	print_hand()
	print()


## --- SHIFTING ---------------------------------------------------------------

# Shift conveyor right 1 space, scrapping and refilling if necessary
func shift_right_one(deck, scrap_pile):
	# Scrap rightmost
	scrap_at_index(max_size - 1, scrap_pile)

	# Shift right
	for i in range(max_size - 1, 0, -1):
		conveyor_cards[i] = conveyor_cards[i - 1]
		
		# Animating cards shifting
		if conveyor_cards[i] != null:
			emit_signal("card_moved", conveyor_cards[i].card_display, i)

	# New card on left
	var top_card = deck.remove_top_card()
	add_card(top_card, 0)

# Shift conveyor left 1 space, retrieving from scrap and putting back on deck if necessary
func shift_left_one(deck, scrap_pile):
	# Move leftmost back to deck
	deck.add_top_card(conveyor_cards[0])
	
	if conveyor_cards[0] != null:
		# Animating card being moved back to deck
		emit_signal("card_to_top_deck", conveyor_cards[0].card_display)

	# Shift left
	for i in range(0, max_size - 1):
		conveyor_cards[i] = conveyor_cards[i + 1]
		
		# Animating cards shifting
		if conveyor_cards[i] != null:
			emit_signal("card_moved", conveyor_cards[i].card_display, i)

	# Restore from scrap
	var restored = scrap_pile.remove_top_card()
	add_card(restored, max_size - 1)

# Shift conveyor by chosen number of steps
func shift(steps: int, deck, scrap_pile):
	if steps > 0:
		for i in range(steps):
			shift_right_one(deck, scrap_pile)
	elif steps < 0:
		for i in range(-steps):
			shift_left_one(deck, scrap_pile)


## --- PRINTING ---------------------------------------------------------------

func print_hand():
	var output := ""
	for c in conveyor_cards:
		if c == null:
			output += "Empty  "
		else:
			output += str(c.name + "  ")
	print(output)
