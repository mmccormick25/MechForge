extends RefCounted
class_name Conveyor

signal card_added(card, index)

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
		if i % 2 == 0:
			add_card(StrikeCard.new(), i)
		else:
			add_card(RewindCard.new(), i)
		
		
func add_card(card : Card, index : int):
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
			return card
	return null
	
# Scrap card at chosen index
func scrap_at_index(slot_index: int, scrap_pile):
	scrap_pile.add_to_scrap(conveyor_cards[slot_index])
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

	# New card on left
	conveyor_cards[0] = deck.remove_top_card()

# Shift conveyor left 1 space, retrieving from scrap and putting back on deck if necessary
func shift_left_one(deck, scrap_pile):
	# Move leftmost back to deck
	deck.add_top_card(conveyor_cards[0])

	# Shift left
	for i in range(0, max_size - 1):
		conveyor_cards[i] = conveyor_cards[i + 1]

	# Restore from scrap
	var restored = scrap_pile.remove_top_card()
	conveyor_cards[max_size - 1] = restored

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
