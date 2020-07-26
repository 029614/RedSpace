extends Node

const DEFAULT_PORT = 4242
var CUSTOM_PORT = 4242
var CUSTOM_IP = "127.0.0.1"
var MAX_PEERS = 10
var players = {}


var player_name

var mode = ''
var use_custom = false
var scene


func _ready():
    get_tree().connect("network_peer_connected",self,"_player_connected")
    get_tree().connect("network_peer_disconnected",self,"_player_disconnected")
    get_tree().connect("connected_to_server",self,"_connected_ok")
    get_tree().connect("connection_failed",self,"_connected_fail")
    get_tree().connect("server_disconnected",self,"_server_disconnect")
    
    print(Game.import_stars())


func start_server():
    #player_name = 'Server'
    var host = NetworkedMultiplayerENet.new()
    
    var err
    if use_custom == false:
        err = host.create_server(DEFAULT_PORT, MAX_PEERS)
    else:
        err = host.create_server(CUSTOM_PORT, MAX_PEERS)
    
    if err!=OK:
        join_server()
        return
    
    get_tree().set_network_peer(host)
    spawn_player(1)


func join_server():
    #player_name = 'Client'
    var host = NetworkedMultiplayerENet.new()
    
    host.create_client(CUSTOM_IP, CUSTOM_PORT)
    get_tree().set_network_peer(host)


func _player_connected(id):
    pass


func _player_disconnected(id):
    unregister_player(id)
    rpc("unregister_player", id)


func _connected_ok():
    rpc_id(1, "user_ready", get_tree().get_network_unique_id(), player_name)  


func _server_disconnected():
    quit_game()


remote func user_ready(id, player_name):
    if get_tree().is_network_server():
        rpc_id(id, "register_in_game")


remote func register_in_game():
    rpc("register_new_player", get_tree().get_network_unique_id(), player_name)
    register_new_player(get_tree().get_network_unique_id(), player_name)


remote func register_new_player(id, new_name):
    if get_tree().is_network_server():
        rpc_id(id, "register_new_player", 1, player_name)
        
        for peer_id in players:
            rpc_id(id, "register_new_player", peer_id, players[peer_id])
    
    players[id] = new_name
    spawn_player(id)


remote func unregister_player(id):
    if get_node("/root/" + str(id)):
        get_node("/root/" + str(id)).queue_free()
    players.erase(id)


func spawn_player(id):
    var player_scene = load("res://Player/PlayerController.tscn")
    var player = player_scene.instance()
    
    player.set_name(str(id))
    
    if id == get_tree().get_network_unique_id():
        player.set_network_master(id)
        
        player.player_id = id
        Game.player_id = id
        Game.player_ref = player
        Game.player_name = player_name
        player.control = true
    
    $Players.add_child(player)
    #add_child(player)


func quit_game():
    get_tree().set_network_peer(null)
    players.clear()


func _on_buttonHost_pressed():
    mode = 'host'
    $MainMenu/PopupPanel/VBoxContainer/HBoxContainer.hide()
    $MainMenu/PopupPanel.popup_centered()


func _on_buttonJoin_pressed():
    mode = 'join'
    $MainMenu/PopupPanel.popup_centered()


func _on_IPEdit_text_changed(new_text):
    use_custom = true
    CUSTOM_IP = new_text


func _on_PortEdit_text_changed(new_text):
    use_custom = true
    CUSTOM_PORT = new_text


func _on_buttonConfirm_pressed():
    $MainMenu/VBoxContainer.hide()
    $MainMenu/PopupPanel.hide()
    if mode == 'host':
        start_server()
    elif mode == 'join':
        join_server()
    $World.create_scene(0)


func _on_NameEdit_text_changed(new_text):
    player_name = new_text
