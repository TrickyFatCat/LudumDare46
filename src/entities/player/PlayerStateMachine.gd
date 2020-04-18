extends StateMachine

var is_holding_egg : bool = false 

onready var Parent : Player = self.get_parent()
onready var SpriteNode : AnimatedSprite = Parent.get_node("AnimatedSprite")


func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("dash")
	add_state("damaged")
	add_state("death")
	set_state_idle()


func _physics_process(delta) -> void:
	#Apply gravity here
	
	if state == states.idle or state == states.run or state == states.fall or state == states.dash:
		Parent.calculate_direction_x()
		SpriteNode.flip_sprite(Parent.direction)
	
	Parent.calculate_velocity_x(delta, Parent.direction)
	Parent.move()
	check_states()


func check_states() -> void:
	match state:
		states.idle:
			set_state_run()
		states.run:
			if Parent.direction.x == 0:
				set_state_idle()
		states.jump:
			pass
		states.fall:
			pass
		states.dash:
			pass
		states.damaged:
			pass
		states.death:
			pass


func set_state_idle() -> void:
	set_state(states.idle)
	SpriteNode.play("idle")


func set_state_run() -> void:
	if Parent.direction.x != 0:
		set_state(states.run)
		SpriteNode.play("run")



















