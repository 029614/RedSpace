extends Node2D


var control = false

var player_name:String
var player_id:int
var player_money:int
var player_combat_rating:int
var player_govt_relationships = {} #Each government gets a value between -100 and 100
var ship = null

# ------ Player Config ------ #
var ZOOM_SENSITIVITY = 1

onready var player_camera = $Camera2D
onready var ship_slot = $Ship
onready var player_gui = $UILayer/PlayerGui

# ----- stuff ----- #
var target_planet = null
var target_ship = null
var _over_planet = null

# Called when the node enters the scene tree for the first time.
func _ready():
    if control == true:
        $Camera2D.make_current()
    
    player_gui.map.create_map()
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    
    if control == true:
        
        if ship != null:
            get_input(delta)
            global_position = ship.global_position
            ship.position = Vector2(0,0)
            rpc_unreliable("move", ship.global_position, ship.rotation, player_id)


func get_input(delta):
    if Input.is_action_pressed("ui_up"):
        ship.set_movement_state('is_thrusting')
    else:
        ship.set_movement_state('idle')
    
    if Input.is_action_pressed("ui_left"):
        ship.rotation -= ship.rotation_speed*delta
    if Input.is_action_pressed("ui_right"):
        ship.rotation += ship.rotation_speed*delta
    
    if Input.is_action_just_released("zoom_in"):
        $Camera2D.zoom -= Vector2(.1,.1)*ZOOM_SENSITIVITY
    if Input.is_action_just_released("zoom_out"):
        $Camera2D.zoom += Vector2(.1,.1)*ZOOM_SENSITIVITY
    if Input.is_action_just_pressed("land"):
        var p = Game.get_closest_planet(ship.global_position)
        if target_planet == null:
            print('target planet is null')
            target_planet(p)
        elif target_planet != null and Game.get_closest_planet(ship.global_position) != p:
            p = Game.get_closest_planet(ship.global_position)
            print('found new closest planet')
            target_planet(p)
        elif target_planet != null and Game.get_closest_planet(ship.global_position) == p:
            print('closest planet is still original')
            if _over_planet != null and _over_planet == p:
                land(p)


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


func target_planet(planet):
    target_planet = planet
    $UILayer/PlayerGui/NavTarget.target_planet(target_planet)


func land(planet):
    #set_physics_process(false)
    #ship_slot.hide()
    print('landing complete!')


func destruct():
    pass


func disable():
    pass



