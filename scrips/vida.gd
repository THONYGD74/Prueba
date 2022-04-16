extends Node2D

export (PackedScene) var spr_vidas

var offset_vidas = 40
var vida_player = 6
var total_vidas = []

func _ready():
	crear_vidas()

func crear_vidas():
	for i in vida_player:
		var newVida = spr_vidas.instance()
		get_tree().get_nodes_in_group("gui")[0].add_child(newVida)
		newVida.global_position.x += offset_vidas * i
		total_vidas.append(newVida)

func quitar_vida():
	vida_player -= 1
	total_vidas[vida_player].queue_free()

func agregar_vida():
	vida_player += 1
	var newVida = spr_vidas.instance()
	get_tree().get_nodes_in_group("gui")[0].add_child(newVida)
	newVida.global_position.x += offset_vidas * (vida_player - 1)
	total_vidas[vida_player - 1].append(newVida)
