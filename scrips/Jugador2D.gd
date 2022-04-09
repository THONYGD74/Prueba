extends KinematicBody2D

var gravedad = 10
var dir = 0
var motion: Vector2 = Vector2()
export var acc = 10
export var ficc = 5
export var maxspeed = 12000

onready var anim = $AnimatedSprite

func _physics_process(delta):
	motion.y += gravedad
	
	get_input(delta)
	state_ma()
	motion = move_and_slide(motion, Vector2.UP)
	

func get_input(delta):
	var KEYLEFT = Input.is_action_pressed("ui_left")
	var KETYRIGHT = Input.is_action_pressed("ui_right")
	
	dir = int(KETYRIGHT) - int(KEYLEFT)
	
	if dir != 0:
		motion.x = move(motion.x , maxspeed * dir * delta, acc)
	else:
		motion.x = move(motion.x, 0,ficc)
		
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
	if motion.y and !is_on_floor():
		anim.play("jump")


func move(inicio: int, final: int, progreso: int):
	if inicio < final:
		return min(inicio + progreso, final)
	else:
		return max(inicio - progreso, final)
