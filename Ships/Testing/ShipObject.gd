extends KinematicBody2D

class_name ship_base

export var weight:int = 2000
export var thrust:int = 2500
export var rotation_speed:int = 1
export var top_speed:int = 10


var control = false
var player_id
var ready = false


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
    if control == true:
        $PlayerController.player_camera.make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
        
    
    var moveByX = 0
    var moveByY = 0
    
    if control == true:
        
        get_input(delta)
        if get_movement_state() == 'is_thrusting':
            velocity += Vector2(1,0).rotated(rotation).normalized()*acceleration
        
    #get_input(delta)
    #if get_movement_state() == 'is_thrusting':
    #    velocity += Vector2(1,0).rotated(rotation).normalized()*acceleration
    #    print(velocity)
        velocity = move_and_slide(velocity)
        rpc_unreliable("move", global_position, rotation, player_id)


func get_input(delta):
    if Input.is_action_pressed("ui_up"):
        set_movement_state('is_thrusting')
    else:
        set_movement_state('idle')
    
    if Input.is_action_pressed("ui_left"):
        rotation -= rotation_speed*delta
    if Input.is_action_pressed("ui_right"):
        rotation += rotation_speed*delta


remote func move(pos,rot,pid):
    var root = get_parent()
    var pnode = root.get_node(str(pid))
    pnode.global_position = pos
    pnode.rotation = rot


func thrust(condition:bool):
    if condition == true:
        pass # Thrust on
    if condition == false:
        pass # Thrust off


func destruct():
    pass


func disable():
    pass


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
    















