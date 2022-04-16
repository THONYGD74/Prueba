extends KinematicBody2D

var gravedad = 10
var dir = 0
var motion: Vector2 = Vector2()

export var acc = 10
export var ficc = 5
export var maxspeed = 12000

var subiendo: bool
var is_ladder: bool = false

onready var anim = $AnimatedSprite

func _physics_process(delta):
	
	if get_parent().vida_player == 0:
		get_tree().reload_current_scene()
	
	if !is_ladder:
		motion.y += gravedad
	else:
		motion.y = 0
	
	get_input(delta)
	state_ma()
	motion = move_and_slide(motion, Vector2.UP)
	

func get_input(delta):
	var KEYLEFT = Input.is_action_pressed("ui_left")
	var KETYRIGHT = Input.is_action_pressed("ui_right")
	
	dir = int(KETYRIGHT) - int(KEYLEFT)
	
	if dir != 0:
# warning-ignore:narrowing_conversion
		motion.x = move(motion.x , maxspeed * dir * delta, acc)
	else:
# warning-ignore:narrowing_conversion
		motion.x = move(motion.x, 0,ficc)
		
	if Input.is_action_pressed("ui_up") and is_ladder :
		motion.y -= 200
		subiendo = true
	if Input.is_action_pressed("ui_down") and is_ladder:
		motion.y += 200
		subiendo = true
	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			motion.y = -200
			anim.play("jump")

func state_ma():

	if motion.x == 0 and is_on_floor():
		anim.play("idle")
	if motion.x != 0 and is_on_floor():
		anim.play("run")
	if dir != 0:
		anim.scale.x = dir
	if motion.y and !is_on_floor() and !is_ladder:
		anim.play("jump")

	if !is_on_floor() and is_ladder and subiendo:
		anim.play("ladder")

func move(inicio: int, final: int, progreso: int):
	if inicio < final:
		return min(inicio + progreso, final)
	else:
		return max(inicio - progreso, final)


func _on_ladder_body_entered(body):
	if body.is_in_group("escaleras"):
		is_ladder = true
		

func _on_ladder_body_exited(body):
	if body.is_in_group("escaleras"):
		is_ladder = false
		subiendo = false

#####################Alesis######################
func _on_colision_pinchos_body_entered(body):
	var padre = get_parent()
	if body.is_in_group("pinchos"):
		print("pinchos")
		padre.quitar_vida()
