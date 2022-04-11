extends Node

var piezas: int
func _ready():
	piezas = 0

func _process(delta):
	piezas = clamp(piezas, 0, 5)
