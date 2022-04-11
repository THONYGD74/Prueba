extends KinematicBody2D

var gravedad = 10
var dir = 0
var motion: Vector2 = Vector2()

export (int) var lim_cam_der
export (int) var lim_cam_izq
export (int) var lim_cam_up
export (int) var lim_cam_down

export (int) var jump
export (int) var sp_ladder
export var acc = 15
export var ficc = 7
export var maxspeed = 11000

var subiendo: bool
var is_ladder: bool = false

onready var camara = $Camera2D
onready var anim = $AnimatedSprite

func _ready():
	camara.limit_bottom = lim_cam_down
	camara.limit_left = lim_cam_izq
	camara.limit_right = lim_cam_der
	camara.limit_top = lim_cam_up

func _physics_process(delta):
	
	
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
		motion.x = move(motion.x , maxspeed * dir * delta, acc)
	else:
		motion.x = move(motion.x, 0,ficc)
		
	if Input.is_action_pressed("ui_up") and is_ladder :
		motion.y -= sp_ladder
		subiendo = true
		anim.play("ladder")
	else:
		subiendo = false
	
	if Input.is_action_pressed("ui_down") and is_ladder:
		motion.y += sp_ladder
		subiendo = true
	else:
		subiendo = false
	
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			motion.y = -jump
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
	
	if !is_on_floor() and is_ladder:
		anim.play("ladder")
	if !subiendo and is_ladder and motion.y == 0 and !is_on_floor():
		anim.stop()
	

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
		
