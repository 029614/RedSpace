extends Control


onready var chat_log = $VBoxContainer/RichTextLabel
onready var input_label = $VBoxContainer/HBoxContainer/Label
onready var input_field = $VBoxContainer/HBoxContainer/LineEdit



var groups = [
    {'name':'Global', 'color':'#ffffff'},
    {'name':'System', 'color':'#edbd00'},
    {'name':'Party', 'color':'#30f74f'},
    {'name':'Whisper', 'color':'#00ede8'},
   ]

var group_index = 0
var player_name = 'Test'
var input_focus = false

func _input(event):
    if event is InputEventKey:
        if event.is_action_released("T"):
            input_field.grab_focus()


func _on_LineEdit_text_entered(new_text):
    input_field.release_focus()
    var message_info = {
        'message':new_text,
        'color':groups[group_index]['color'],
        'username':Game.player_name,
        'group':groups[group_index]['name']
       }
    add_message(message_info)
    rpc("add_message", message_info)
    input_field.text = ''


remote func add_message(message_info):
    chat_log.bbcode_text += '\n'
    chat_log.bbcode_text += '[color= ' + message_info['color'] + ']'
    chat_log.bbcode_text += message_info['group'] + '/' + message_info['username'] + ': '
    chat_log.bbcode_text += message_info['message']
    #chat_log.bbcode_text += '\n' + '[color=' + groups[group_index]['color'] + ']' + groups[group_index]['name'] + '/' + username + ': ' + text


func _on_OptionButton_item_selected(id):
    group_index = id







