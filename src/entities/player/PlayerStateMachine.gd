extends StateMachine

const COYOTE_JUMP_TIME : float = 0.1

var is_holding_egg : bool = false
var was_on_floor : bool = false

onready var Parent : Player = self.get_parent()
onready var SpriteNode : AnimatedSprite = Parent.get_node("AnimatedSprite")
onready var CoyoteTimer : Timer = $CoyoteTimer

func _ready():
# warning-ignore:return_value_discarded
	HitPoints.connect("on_player_take_damage", self, "set_state_stunlock")
	CoyoteTimer.wait_time = COYOTE_JUMP_TIME
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("dash")
	add_state("stunlock")
	add_state("death")
	set_state_idle()


func _physics_process(delta) -> void:
	was_on_floor = Parent.is_on_floor()
	
	if state == states.idle or state == states.run or state == states.fall or state == states.dash:
		Parent.calculate_direction_x()
		SpriteNode.flip_sprite(Parent.direction)
		
		if SpriteNode.flip_h:
			Parent.facing_direction = -1
		else:
			Parent.facing_direction = 1
	
	Parent.calculate_friction()
	Parent.calculate_acceleration()
	Parent.calculate_velocity_x(delta, Parent.direction)
	
	if CoyoteTimer.is_stopped():
		Parent.apply_gravity(delta)
	
	Parent.move()
	check_states()


func check_states() -> void:
	match state:
		states.idle:
			set_state_run()
			set_state_jump()
		states.run:
			set_state_jump()
			
			if Parent.direction.x == 0:
				set_state_idle()
			
			if !Parent.is_on_floor() and was_on_floor:
				CoyoteTimer.start()
				Parent.velocity.y = 0
		states.jump:
			set_state_fall()
		states.fall:
			if Parent.is_on_floor():
				if Parent.direction.x == 0:
					set_state_idle()
					Parent.velocity.x = 0
				else:
					set_state_run()
		states.dash:
			pass
		states.stunlock:
			set_state_fall()
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


func set_state_jump() -> void:
	if InputHandler.is_jump_pressed():
		if (Parent.is_on_floor() or !CoyoteTimer.is_stopped()) and !Parent.is_holding_egg:
			Parent.activate_jump()
			set_state(states.jump)
			Parent.friction = 0
			SpriteNode.play("jump")


func set_state_fall() -> void:
	if Parent.velocity.y > 0:
		Parent.gravity = Parent.BASE_GRAVITY
		set_state(states.fall)
		SpriteNode.play("fall")


func set_state_stunlock() -> void:
	set_state(states.stunlock)
	Parent.activate_stunlock_jump()














