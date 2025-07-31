extends Node


@onready var damage_timer: Timer = $"Damage Timer"

@export var MAXHEALTH: float
@export var REGENTIME: float
@export var REGENAMOUNT: float
@export var CANREGEN: bool

var health
var canRegen := true
var timer := 0.0

signal death

func _ready() -> void:
	health = MAXHEALTH

func _process(delta: float) -> void:
	if CANREGEN:
		timer += delta
		if timer >= REGENTIME:
			timer = 0.0
			regen_health()

func take_damage(damageAmount: float):
	health = health - damageAmount
	canRegen = false
	damage_timer.start()
	
	if health <= 0:
		death.emit()

func _heal(healAmount: float):
	if health + healAmount > MAXHEALTH:
		health = MAXHEALTH
	else:
		health = health + healAmount

func regen_health():
	if health >= MAXHEALTH:
		return
	
	if health + REGENAMOUNT > MAXHEALTH:
		health = MAXHEALTH
	else:
		health += REGENAMOUNT

func get_health() -> float:
	return health

func reset_health():
	health = MAXHEALTH

func _on_damage_timer_timeout() -> void:
	if not damage_timer.is_stopped():
		return
	canRegen = true
