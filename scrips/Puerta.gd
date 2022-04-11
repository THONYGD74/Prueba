extends Area2D

var piezas_listas : bool = false
export (String) var nivel

onready var coll = $CollisionShape2D

func _process(delta):
	if piezas_listas == true:
		coll.disabled = false

func _on_Puerta_body_entered(body):
	if body.is_in_group("jugador"):
		get_tree().call_deferred("reload_current_scene")
		NIVEL1.piezas = 0

