extends Control

var heat_level: int = 0

@onready var heat_bar_1 = $HeatBar1
@onready var heat_bar_2 = $HeatBar2
@onready var heat_bar_3 = $HeatBar3

var empty_texture = load("res://assets/images/HUD/HeatGagueEmpty1.png")
var filled_texture = load("res://assets/images/HUD/HeatGagueFilled1.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func increase_heat() -> void:
	heat_level += 1
	
	if (heat_level == 1):
		heat_bar_1.texture = filled_texture
	elif (heat_level == 2):
		heat_bar_1.texture = filled_texture
		heat_bar_2.texture = filled_texture
	elif (heat_level == 3):
		heat_bar_1.texture = filled_texture
		heat_bar_2.texture = filled_texture
		heat_bar_3.texture = filled_texture
		
func reset_heat() -> void:
	heat_level = 0
	
	heat_bar_1.texture = empty_texture
	heat_bar_2.texture = empty_texture
	heat_bar_3.texture = empty_texture
