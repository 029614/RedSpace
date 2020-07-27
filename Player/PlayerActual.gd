extends Node2D


var control = false

var player_name:String = "Player"
var player_id:int
var player_money:int
var player_combat_rating:int
var player_govt_relationships = {} #Each government gets a value between -100 and 100
var ship = null
var ship_scale = Vector2()
var test_var = 'Fucking fuck shit ass!'

var target_player_info = {}

# ------ Player Config ------ #
var ZOOM_SENSITIVITY = 1

onready var player_camera = $Camera2D
onready var ship_slot = $Ship
onready var player_gui = $UILayer/PlayerGui

# ----- stuff ----- #
var target_planet = null
var target_ship = null
var _over_planet = null
var flight_conditions = ['_in_flight', '_is_landing', '_is_landed', '_is_launching']
var flight_status = '_in_flight' # '_in_flight, _is_landing, _is_landed, _is_launching'

# Called when the node enters the scene tree for the first time.
func _ready():
    Signals.connect("launch_player", self, "launch")
    if control == true:
        $Camera2D.make_current()
    
    player_gui.map.create_map()
    ship_scale = ship.scale
    $UILayer/PlayerGui/StarMap.createMap()
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    
    if control == true:
        
        if ship != null:
            if flight_status == '_in_flight':
                get_input(delta)
                global_position = ship.global_position
                ship.position = Vector2(0,0)
            rpc_unreliable("move", ship.global_position, ship.rotation, player_id)
            
            if flight_status == '_is_landing':
                if ship.scale > Vector2(0.04,0.04):
                    ship.scale -= Vector2(0.02,0.02)
                else:
                    flight_status = flight_conditions[2]
                    ship.scale = ship_scale
                    land(target_planet)


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
            targetPlanet(p)
        elif target_planet != null and p != target_planet:
            p = Game.get_closest_planet(ship.global_position)
            targetPlanet(p)
        elif target_planet != null and p == target_planet:
            if _over_planet != null and _over_planet == p:
                if ship.speed < 25:
                    flight_status = flight_conditions[1]
                    target_planet = p
                else:
                    print('You are moving too fast to land!')
    
    if Input.is_action_just_pressed("target_closest"):
        target_ship = Game.get_closest_ship(ship_slot.get_child(0).global_position,ship_slot.get_child(0))
        var player_info = rpc_id(target_ship.get_parent().get_parent().player_id, "get_player_info", player_id)
        


func _input(event):
    if event.is_action_pressed("primary_action"):
        if flight_status == '_is_landed':
            launch()
    if event.is_action_pressed("Map"):
        if $UILayer/PlayerGui/StarMap.is_visible():
            $UILayer/PlayerGui/StarMap.hide()
        else:
            $UILayer/PlayerGui/StarMap.show()
            


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


func targetPlanet(planet):
    target_planet = planet
    player_gui.nav_target.targetPlanet(target_planet)


func land(planet):
    ship_slot.hide()
    ship.velocity = Vector2(0,0)
    $UILayer/PlayerGui/PlanetInterface.create_menu(planet)
    $UILayer/PlayerGui/PlanetInterface.popup_centered()
    rpc("land_broadcast", player_id)
    set_physics_process(false)
    

remote func land_broadcast(pid):
    var root = get_parent()
    var pnode = root.get_node(str(pid))
    pnode.set_physics_process(false)
    pnode.ship_slot.hide()
    pnode.ship.velocity = Vector2(0,0)


func launch():
    if control == true:
        set_physics_process(true)
        ship_slot.show()
        flight_status = flight_conditions[0]
        target_planet = null
        player_gui.nav_target.targetPlanet(target_planet)
        $UILayer/PlayerGui/PlanetInterface.hide()
        rpc("launch_broadcast", player_id)


remote func launch_broadcast(pid):
    var root = get_parent()
    var pnode = root.get_node(str(pid))
    pnode.set_physics_process(true)
    pnode.ship_slot.show()
    


func destruct():
    pass


func disable():
    pass


remote func get_player_info(sender_id):
    var info = {
        'name':player_name,
        'id':player_id,
        'combat':player_combat_rating
       }
    rpc_id(get_tree().get_rpc_sender_id(), 'target_with_info', info)

remote func target_with_info(info):
    $UILayer/PlayerGui/RCon/ComTarget.target(target_ship, info)

