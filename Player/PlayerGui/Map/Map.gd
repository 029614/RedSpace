extends Control


onready var map_center = Game.player_ref.global_position
var map_info
var players_in_system = Game.get_ships_in_system()
var ships_being_tracked = []
onready var map_correction = $Panel.rect_size/2
var map_scale = 0.1
var radar_range = 1000


func _ready():
    Signals.connect("update_ships_in_system", self, "update_ship_list")
    $Panel/Sprite.position = map_correction


func _physics_process(delta):
    for player in players_in_system:
        if player != Game.player_ref:
            if player.ship.global_position.distance_to(Game.player_ref.ship.global_position) <= radar_range:
                var _is_tracked = false
                for track in ships_being_tracked:
                    if track.ship_ref == player.ship:
                        _is_tracked = true
                        track.position = player.ship.global_position*map_scale
                        track.rotation = player.ship.rotation
                if _is_tracked == false:
                    print('tracking target')
                    track(player.ship)
            else:
                for track in ships_being_tracked:
                    if track.ship_ref == player.ship:
                        print('ceasing to track target')
                        unTrack(track)
                    
    $Panel/Bodies.position = (Game.player_ref.global_position/10*-1) + map_correction
    $Panel/Ships.position = (Game.player_ref.global_position/10*-1) + map_correction
    $Panel/Sprite.rotation = Game.player_ref.ship.rotation


func track(ship):
    print('instancing new tracking icon')
    var track = load("res://Player/PlayerGui/Map/ShipTrack.tscn")
    var newt = track.instance()
    newt.ship_ref = ship
    ships_being_tracked.append(newt)
    $Panel/Ships.add_child(newt)
    newt.global_position = ship.global_position*map_scale
    newt.rotation = ship.rotation


func unTrack(track):
    ships_being_tracked.erase(track)
    track.queue_free()


func update_ship_list(ship_list):
    players_in_system = ship_list


func create_map():
    for p in Game.starmap.values():
        if p['id'] == Game.current_system:
            map_info = p['planets']
    for p in map_info.values():
        var s = Sprite.new()
        s.set_texture(load("res://Icons/MapPlanetIcon.png"))
        s.set_scale(Vector2(.05,.05))
        s.global_position = p['pos']*map_scale
        $Panel/Bodies.add_child(s)
