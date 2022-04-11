extends Node2D

onready var puerta = $Puerta
onready var Piezas_contador = $KinematicBody2D/GUI/piezas
var piezas_restantes

func _ready():
	piezas_restantes = $piezas.get_child_count()
	

func _process(delta):
	Piezas_contador.text = str(NIVEL1.piezas,"/",piezas_restantes)
	habrir_pueta()
	
func habrir_pueta():
	if NIVEL1.piezas == 5:
		puerta.piezas_listas = true
