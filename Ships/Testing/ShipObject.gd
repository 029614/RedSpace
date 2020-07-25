extends KinematicBody2D

class_name ship_base

export var weight:int = 2000
export var thrust:int = 2500
export var rotation_speed:int = 1
export var top_speed:int = 10


var acceleration
var velocity = Vector2()

var movement_states = {
    'idle':true,
    'is_thrusting':false,
    'is_using_afterburner':false,
    'is_jumping':false,
    'is_disabled':false,
   }

var combat_states = {
    'idle':true,
    'is_firing_primary':false,
    'is_firing_secondary':false
   }

var shield_states = {
    'shields_up':true,
    'shields_low':false,
    'shields_down':false
   }

# Called when the node enters the scene tree for the first time.
func _ready():
    acceleration = thrust/weight
    start_up()


func _physics_process(delta):
    
        if get_movement_state() == 'is_thrusting':
            velocity += Vector2(1,0).rotated(rotation).normalized()*acceleration
        velocity = move_and_slide(velocity)
            


func start_up():
    get_parent().get_parent().ship = self
    

func get_combat_state():
    for x in range(combat_states.size()):
        if combat_states.values()[x] == true:
            return combat_states.keys()[x]

func set_combat_state(state:String):
    if combat_states.has(state):
        for prev_state in combat_states:
            if combat_states[prev_state] == true:
                combat_states[prev_state] = false
        
        combat_states[state] = true
    else:
        print('Combat State Error! State not found: ', state)
    

func get_movement_state():
    for x in range(movement_states.size()):
        if movement_states.values()[x] == true:
            return movement_states.keys()[x]

func set_movement_state(state:String):
    if movement_states.has(state):
        for prev_state in movement_states:
            if movement_states[prev_state] == true:
                movement_states[prev_state] = false
        
        movement_states[state] = true
    else:
        print('Movement State Error! State not found: ', state)


func get_shield_state():
    for x in range(shield_states.size()):
        if shield_states.values()[x] == true:
            return shield_states.keys()[x]

func set_shield_state(state:String):
    if shield_states.has(state):
        for prev_state in shield_states:
            if shield_states[prev_state] == true:
                shield_states[prev_state] = false
        
        shield_states[state] = true
    else:
        print('Shield State Error! State not found: ', state)













