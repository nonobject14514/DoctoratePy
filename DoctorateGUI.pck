GDPC                  @                                                                         P   res://.godot/exported/133200997/export-116b49875b8ab82103b4492c7aee954c-rune.scn0q            ��XM��NK��D���    X   res://.godot/exported/133200997/export-58d13476aa771dc77970f0f472967d80-game_data.scn   �      w      gil@�ݷr&Q�;�    T   res://.godot/exported/133200997/export-88151ca06ce9bf1a56c406af6c1e7e00-relayer.scn �      k      !.�7��8=旸�Bz    X   res://.godot/exported/133200997/export-c9e1ea6367165e7c5c56e7f76bf05724-config_data.scn �      }      u�f?�@=��feMZ�    P   res://.godot/exported/133200997/export-cdd813ab38d3bd8e260b860aae2a8731-main.scn        JP      �2�y��g�Ｏ��p    D   res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex�v      �      ��n��b�o	����W_    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex`�      ^      2��r3��MgB�[79       res://.godot/uid_cache.bin  `�      �       ly��Gڔ����g~        res://ConfigData/config_data.gd         �      �3w�y���(wK�    (   res://ConfigData/config_data.tscn.remap 0�      h       =�	|?�z�@�h       res://GameData/game_data.gd 0      �      �C�'�5��on��WZ6F    $   res://GameData/game_data.tscn.remap ��      f       �A�6�|��/u��O(�       res://Main/main.gd  `      �      Uhf��'WV�7we\       res://Main/main.tscn.remap  �      a       =�cgY.��쀼��"h       res://Main/rune.gd  pp      �       y������or
��Wr�       res://Main/rune.tscn.remap  ��      a       �n.%}��U�,�4(�        res://Main/runes_container.gd   @v      4       ��?�Σܯ���eE̒       res://icon.ico  �      I      !"ع��W��][�o`q       res://icon.png  `�      �?      $�lv#>6�s;Dh�       res://icon.png.import   p�      �      P��iD]�sPM�`�vq       res://icon.svg.import   ��      B      �i�nw�ţ�7�Z�#       res://project.binaryP�      �      ��A�t��
����g�)       res://relayer.gd�      �      ��wVV��0Q�o��       res://relayer.tscn.remap�      d       �"��	/j�xQ�i       res://triangle.gdshader `�      q       �!�@�n���.H�N    extends Node

# Change your dev path in the exported property
@export var dev_path = "C:\\Users\\Logos\\DoctoratePy"

var BASE_PATH = OS.get_executable_path().get_base_dir() if not OS.is_debug_build() else dev_path
var CRISIS_PATH = BASE_PATH + "\\data\\crisis\\"
var START_PATH = BASE_PATH + "\\start.bat"
var CONFIG_PATH = BASE_PATH + "\\config\\config.json"

var crisis = {}
var crisis_dirty = true
var config = {}

var dirty = false:
	set(value):
		dirty = value
		if dirty and autosave:
			save_to_disk()
var autosave = false

func _ready():
	print(OS.get_executable_path())
	for f in DirAccess.get_files_at(CRISIS_PATH):
		if "json" in f:
			var file = FileAccess.open(CRISIS_PATH + f, FileAccess.READ)
			crisis[f.substr(0, len(f)-5)] = JSON.parse_string(file.get_as_text())
	var file = FileAccess.open(CONFIG_PATH, FileAccess.READ)
	config = JSON.parse_string(file.get_as_text())

func save_to_disk():
	for c in crisis.keys():
		var file = FileAccess.open(CRISIS_PATH + c + ".json", FileAccess.WRITE)
		file.store_string(JSON.stringify(crisis[c], "\t"))
	var file = FileAccess.open(CONFIG_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(config, "\t"))
	dirty = false
�G�^�G���PRSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script     res://ConfigData/config_data.gd ��������      local://PackedScene_52yhq          PackedScene          	         names "         ConfigData    script    Node    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRC��extends Node

const BASE_URL := "https://raw.githubusercontent.com/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata"
const SKIN_TABLE_URL := BASE_URL + "/excel/skin_table.json"
const CHARACTER_TABLE_URL := BASE_URL + "/excel/character_table.json"
const BATTLEEQUIP_TABLE_URL := BASE_URL + "/excel/battle_equip_table.json"
const STAGE_TABLE_URL := BASE_URL + "/excel/stage_table.json"

var skin_table := {}
var character_table := {}
var battle_equip_table := {}
var stage_table := {}
var rune_stage_table := {}

func _ready():
	# Get Game Tables
	var urls := [SKIN_TABLE_URL, CHARACTER_TABLE_URL, BATTLEEQUIP_TABLE_URL, STAGE_TABLE_URL]
	var dicts := ["skin_table", "character_table", "battle_equip_table", "stage_table"]
	for i in range(len(dicts)):
		var http := HTTPRequest.new()
		add_child(http)
		http.connect("request_completed", _http_request_completed.bind(dicts[i]))
		http.accept_gzip = false
		
		var error := http.request(urls[i])
		if error != OK:
			push_error("Error creating request for " + urls[i] + ": " + error)

signal skin_table_loaded()
signal character_table_loaded()
signal battle_equip_table_loaded()
signal stage_table_loaded()
signal rune_stage_table_loaded()

func _http_request_completed(result, response_code, headers, body : PackedByteArray, dict_to_update : String):
	set(dict_to_update, JSON.parse_string(body.get_string_from_ascii()))
	emit_signal(dict_to_update + "_loaded")
	print(dict_to_update + " loaded.")
r�)):�N�RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://GameData/game_data.gd ��������      local://PackedScene_dhb8w          PackedScene          	         names "      	   GameData    script    Node    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRC����%n�extends Control

func _ready():
	add_child(preload("res://relayer.tscn").instantiate())
	$TabContainer.current_tab = 2

#---------------------------------------------------------------------------
#
#---------------------------------------------------------------------------

func _on_start_pressed():
	ConfigData.save_to_disk()
	OS.shell_open(ConfigData.START_PATH)

@onready var cc_list : ItemList = $"TabContainer/Crisis/Left/ItemList"
func _process_cc_list():
	if ConfigData.crisis_dirty:
		cc_list.clear()
		cc_list.add_item("none")
		for c in ConfigData.crisis.keys():
			cc_list.add_item(c)
		ConfigData.crisis_dirty = false
		var idx = ([null] + ConfigData.crisis.keys()).find(ConfigData.config["crisisConfig"]["selectedCrisis"])
		cc_list.select(idx)
		_on_item_list_item_selected(idx)
		ConfigData.dirty = false

@onready var no_cc = $"TabContainer/Crisis/NoCC"
@onready var cc_body = $"TabContainer/Crisis/Right"
@onready var cc_season : OptionButton = $"TabContainer/Crisis/Right/Info/VBoxContainer/Season/OptionButton"
@onready var cc_name : LineEdit = $"TabContainer/Crisis/Right/Info/VBoxContainer/StageName/LineEdit"
@onready var cc_code : LineEdit = $"TabContainer/Crisis/Right/Info/VBoxContainer/StageCode/LineEdit"
@onready var cc_level : LineEdit = $"TabContainer/Crisis/Right/Info/VBoxContainer/StageId/LineEdit"
@onready var cc_map : OptionButton = $"TabContainer/Crisis/Right/Info/VBoxContainer/MapId/OptionButton"
@onready var cc_loading : OptionButton = $"TabContainer/Crisis/Right/Info/VBoxContainer/LoadingId/OptionButton"
@onready var cc_description : TextEdit = $"TabContainer/Crisis/Right/Info/VBoxContainer/Description/TextEdit"

func _on_item_list_item_selected(idx):
	ConfigData.config["crisisConfig"]["selectedCrisis"] = null if idx == 0 else cc_list.get_item_text(idx)
	ConfigData.dirty = true
	
	if idx == 0:
		no_cc.visible = true
		cc_body.visible = false
		return
	no_cc.visible = false
	cc_body.visible = true
	var cc : Dictionary = ConfigData.crisis[ConfigData.crisis.keys()[idx-1]]
	
	cc_season.select(cc["data"]["seasonInfo"][0]["seasonId"].substr(12,2).to_int())
	cc_name.text = cc["data"]["seasonInfo"][0]["stages"].values()[0]["name"]
	cc_code.text = cc["data"]["seasonInfo"][0]["stages"].values()[0]["code"]
	cc_description.text = cc["data"]["seasonInfo"][0]["stages"].values()[0]["description"]
	cc_level.text = cc["data"]["seasonInfo"][0]["stages"].values()[0]["mapId"]

func _ready_crisis_info():
	cc_season.clear()
	for i in range(11):
		cc_season.add_item("CC#"+str(i))
	GameData.connect("stage_table_loaded", _apply_loaded_stage_info)

func _apply_loaded_stage_info():
	# TODO
	return
	for s in GameData.stage_table["stages"].values():
		cc_level.add_item(s["code"])

@onready var save_button : Button = $TopRight/Save
@onready var autosave : CheckBox = $TopRight/Save/Autosave

func _process_save_button():
	save_button.toggle_mode = autosave.button_pressed
	save_button.button_pressed = autosave.button_pressed
	save_button.modulate = Color.LIGHT_CORAL if ConfigData.dirty else Color.WHITE

func _on_autosave_pressed():
	ConfigData.autosave = autosave.button_pressed
	if autosave.button_pressed:
		ConfigData.dirty = true

func _on_save_pressed():
	ConfigData.save_to_disk()

func _on_cc_season_item_selected(index):
	var cc = ConfigData.crisis[ConfigData.config["crisisConfig"]["selectedCrisis"]]
	cc["data"]["seasonInfo"][0]["seasonId"] = "rune_season_" + str(index) + "_1"
	ConfigData.dirty = true
	cc["data"]["seasonInfo"][0]["stages"].values()[0]["code"]

func _on_cc_code_text_changed(new_text):
	var cc = ConfigData.crisis[ConfigData.config["crisisConfig"]["selectedCrisis"]]
	cc["data"]["seasonInfo"][0]["stages"].values()[0]["code"] = new_text
	ConfigData.dirty = true

func _on_cc_stage_name_text_changed(new_text):
	var cc = ConfigData.crisis[ConfigData.config["crisisConfig"]["selectedCrisis"]]
	cc["data"]["seasonInfo"][0]["stages"].values()[0]["name"] = new_text
	ConfigData.dirty = true

func _on_cc_level_id_text_changed(new_text):
	var cc = ConfigData.crisis[ConfigData.config["crisisConfig"]["selectedCrisis"]]
	cc["data"]["seasonInfo"][0]["stages"].values()[0]["mapId"] = new_text
	cc["data"]["seasonInfo"][0]["stages"].values()[0]["levelId"] = "Obt/Rune/level_" + new_text
	ConfigData.dirty = true
� C�5����&?�RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name    line_spacing    font 
   font_size    font_color    outline_size    outline_color    shadow_size    shadow_color    shadow_offset    script    shader 	   _bundled       Script    res://Main/main.gd ��������   Shader    res://triangle.gdshader ��������
   Texture2D    res://icon.svg �
��   Script    res://Main/runes_container.gd ��������   PackedScene    res://Main/rune.tscn �-K�y#      local://LabelSettings_cnmnw �         local://ShaderMaterial_24wcb          local://LabelSettings_bhlc2 2         local://PackedScene_ai4o6 \         LabelSettings          �            ShaderMaterial                         LabelSettings          �            PackedScene          	         names "   �      Main    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    focus_mode    script    Control    Background    color 
   ColorRect    TabContainer    Account    visible    offset_top    TODO    Panel    Label 	   modulate    offset_bottom 	   rotation    pivot_offset    text    label_settings    horizontal_alignment    vertical_alignment    Roster    Crisis    Left    offset_right 	   ItemList    offset_left    item_count    item_0/text    item_1/text    Right    anchor_left    Info    anchor_top    VBoxContainer    Season    custom_minimum_size    OptionButton 
   alignment 	   selected    popup/item_0/text    popup/item_0/id 
   StageCode 	   LineEdit 
   StageName    StageId    MapId 
   LoadingId    Load    Description 	   TextEdit    placeholder_text 
   wrap_mode    Risks    Icon 	   material    Icon2    ColorRect2    Icon3    ColorRect3 	   RuneInfo    Id    Risk    popup/item_1/text    popup/item_1/id    popup/item_2/text    popup/item_2/id    expand_icon    popup/item_0/icon    gutters_draw_line_numbers 	   CodeEdit    Runes    ScrollContainer    RunesContainer    columns    GridContainer    Rune    Rune2    Rune3    Rune4    Rune5    Rune6    Rune7    Rune8    Rune9    Rune10    Rune11    Rune12    Rune13    Rune14    Rune15    Rune16    Rune17    Rune18    Rune19    Rune20    Rune21    Rune22    Rune23    Rune24    Rune25    Rune26    Rune27    Rune28    Rune29    Rune30    Rune31    Rune32    Rune33    Rune34    Rune35    Rune36    Rune37    Rune38    Rune39    Rune40    Rune41    Rune42    Rune43    Rune44    Rune45    Rune46    Rune47    Rune48    Rune49    Rune50    Rune51    Rune52    Rune53    Rune54    Rune55    Rune56    Rune57    Rune58    Rune59    Rune60    Rune61    Rune62    Rune63    Rune64    Rune65    Rune66    Rune67    Rune68    Rune69    Rune70    Rune71    Rune72    Rune73    Rune74    Rune75    Rune76    Rune77    Rune78    Rune79    Rune80    Rune81    Rune82    Rune83    Rune84    Rune85    Rune86    Rune87    Rune88    Rune89    Rune90    Rune91    Rune92    Rune93    Rune94    Rune95    Rune96    Challenges    NoCC 	   TopRight $   theme_override_constants/separation    HBoxContainer    Save    Button 	   Autosave    tooltip_text 	   CheckBox    Start    _on_item_list_item_selected    item_selected    _on_cc_season_item_selected    _on_cc_code_text_changed    text_changed    _on_cc_stage_name_text_changed    _on_cc_level_id_text_changed    _on_save_pressed    pressed    _on_autosave_pressed    _on_start_pressed    	   variants    �                    �?                         ���>���>���>  �?            �A   ���>���>���>  �?     !C   �I�
     �C  �C      TODO              	         C      A     A      �      none       cc1      ��     D                   ?     ��     �C     �C
         @B     �C     @B     ��     �B     �A      Season            H�     ��     �A      CC#1      PB     �B      Code      p�      Barrenlands      �B     C      Name       Pyrite Gorge      C     LC      Level      PC     �C     �B      Map ID      0�      rune_03-01      �C     �C      Loading Pic    	   loading3 
         �C     �C     �B   �   A gorge covered in yellow sand that gives off a metallic sheen in the sunlight. Proceed with caution, for plunderers often lurk where the sun does not reach.       Stage description      �C     ��     �?��?���>  �?     �B     �B   ��~?��~?��~?  �?                  �I@
      A   A   �{?���>      �?     �B     C     @�     �@   ��O?    ��$>  �?     IC     ��     @A     ��      A     YC     *D    @D     ��     �C      ID
      ��      �      enemy_hirman_2       Risk      @�      1       2       3 
         �B     HC      Icon       �      B                      
         �B     �C   `   All [Rockbreaker] and [Rockbreaker Leader] gain +60% HP, +250 DEF and +40% ATK and Invisibility       Risk description      ��     �     $C   d  {
    "key": "enemy_attribute_mul",
    "selector": {
        "professionMask": 0,
        "buildableMask": 0,
        "charIdFilter": null,
        "enemyIdFilter": null,
        "skillIdFilter": null,
        "tileKeyFilter": null
    },
    "blackboard": [
        {
            "key": "enemy",
            "value": 0,
            "valueStr": "enemy_1048_hirman|enemy_1048_hirman_2"
        },
        {
            "key": "max_hp",
            "value": 1.6,
            "valueStr": null
        },
        {
            "key": "atk",
            "value": 1.4,
            "valueStr": null
        }
    ]
},
{
    "key": "enemy_attribute_add",
    "selector": {
        "professionMask": 0,
        "buildableMask": 0,
        "charIdFilter": null,
        "enemyIdFilter": null,
        "skillIdFilter": null,
        "tileKeyFilter": null
    },
    "blackboard": [
        {
            "key": "enemy",
            "value": 0,
            "valueStr": "enemy_1048_hirman|enemy_1048_hirman_2"
        },
        {
            "key": "def",
            "value": 250,
            "valueStr": null
        }
    ]
},
{
    "key": "enemy_dynamic_ability_new",
    "selector": {
        "professionMask": 0,
        "buildableMask": 0,
        "charIdFilter": null,
        "enemyIdFilter": null,
        "skillIdFilter": null,
        "tileKeyFilter": null
    },
    "blackboard": [
        {
            "key": "enemy",
            "value": 0,
            "valueStr": "enemy_1048_hirman|enemy_1048_hirman_2"
        },
        {
            "key": "key",
            "value": 0,
            "valueStr": "invisible"
        }
    ]
}      �B     ��    �E                              �B     C     C     �C     �C     �C     �C     �C     �C     �C     �C     D     D     D     D     )D     :D     ;D     KD     LD     \D     ]D     mD     nD     ~D     D    ��D     �D     �D    ��D    ��D     �D     �D    ��D    ��D     �D     �D    ��D    ��D     �D     �D    ��D    ��D     �D     �D    ��D    ��D     �D     �D    ��D    ��D     �D     �D    ��D    ��D     �D    �E    �E   ��)?��)?��)?  �?      No CC
Selected                �      
     �B         �C     �C   
        Save       B   	   Autosave      �?��7?��=  �?
     �B         �C      D   
   start.bat       node_count    �         nodes     W  ��������	       ����                                                                   
   ����                                                         ����                                            	      ����                                                                     ����                                                  ����      	                        
      
                                                              	      ����                                                                     ����                                                  ����      	                        
      
                                                              	      ����                                                        	       	      ����                                      
               ����                     !                                    "      #      $          	       	   %   ����                      &            !                                '   ����         (                                               )   )   ����	                     !                                               	   *   ����   +                                                 ����
         (               !      "      #            $                          ,   ,   ����      %   &      (                  !   &      '      (               -      "      .      /   )   0                 	   1   ����   +                      *            +                    ����
         (               !      "      #            ,                          2   2   ����      %   &      (                  !   &      -      (                  .   -                 	   3   ����   +                      /            0                    ����
         (               '      "      (            1                          2   2   ����      %   &      (                  !   &      -      (                  2   -                 	   4   ����   +                      3            4                    ����
         (               '      "      (            5                          2   2   ����      %   &      (                  !   &      -      (                  .   -                 	   5   ����         +                      6            7                    ����
         (               '      8      (            9                          ,   ,   ����      %   &      (                  !   :      '      (               -      "      .      /   ;   0                 	   6   ����         +                      <            =                 7   ����
         (               '      8      (            >                          ,   ,   ����      %   &      (                  !   :      '      (               -      "      .      /   ?   0                 	   8   ����   +   @                   6            A       !       9   9   ����                     !                     B                  C   :   D   ;                       ����	                     !   E                  F                   #       	   <   ����                                                        $       	   =   ����      G                !               H      I       %             ����      J   >   K      L   &      (                  !                                       M      N       $       	   ?   ����      O                !         P      H      Q       '             ����   >   K      L   &      (                  !   R            S                        M      N       '          @   ����   >   K      L   &      (                           (                        N       $       	   A   ����      T                !         Q      H      U       *             ����   >   K      L   &      (                  !   '      V      W                  M      N       *          @   ����   >   K      L   &      (                  !   S      V      #      W                  M      N       *          B   ����   >   K      L   &      (                  !   X      R      Y      S                  N       $          C   ����   !   (      Z      [      \       .       )   )   ����	                     !   (            ]                         /       	   D   ����   +                      ^              0             ����	         (               !      8      #            _             0       2   2   ����      %   &      (                  !   `      -      a      (                  b   -          /       	   E   ����   +                      *      ^      +       3             ����	         (               '      8      (            c             3       ,   ,   ����      %   &      (                  !   `      '      d      (               -      "       .      /   e   0      F   f   G      H   g   I          /       	   =   ����   +   h                   /      ^      i       6             ����	         (               '      8      (            j             6       ,   ,   ����      %   &      (                  !   `      k      d      l               -      J   m   "      .      /   n   K   o   0          /       	   8   ����   +   p                   4      ^      q       9       9   2   ����
                        a      S                  r   :   s   ;          .       M   9   ����      %   &      (                  !   t      u            v                  w   ;      L   m       $       O   N   ����                     !   x            y                   <       R   P   ����      z      i   Q   {      |       =       ���S   }         H       =       ���T   }      !   ~             =       ���U   }      !   �      i       =       ���V   }      !   4      �       =       ���W   }      !   �      �       =       ���X   }      !   �      �       =       ���Y   }      !   �      �       =       ���Z   }      !   �      �       =       ���[   }      !   �      �       =       ���\   }      !   �      �       =       ���]   }      !   [      �       =       ���^   }      !   �      �       =       ���_   }      !   �      �       =       ���`   }      !   �      �       =       ���a   }      !   �      �       =       ���b   }      !   �      �       =       ���c   }      !   �      �       =       ���d   }      !   �      �       =       ���e   }      !   �      �       =       ���f   }      !   �      �       =       ���g   }      !   �      �       =       ���h   }      !   �      �       =       ���i   }      !   �      �       =       ���j   }      !   �      �       =       ���k   }      !   �      �       =       ���l   }      !   �      �       =       ���m   }      !   �      �       =       ���n   }      !   �      �       =       ���o   }      !   �      �       =       ���p   }      !   �      �       =       ���q   }      !   �      �       =       ���r   }      !   �      z       =       ���s   }         ~      H             =       ���t   }      !   ~      ~                   =       ���u   }      !   �      ~      i             =       ���v   }      !   4      ~      �             =       ���w   }      !   �      ~      �             =       ���x   }      !   �      ~      �             =       ���y   }      !   �      ~      �             =       ���z   }      !   �      ~      �             =       ���{   }      !   �      ~      �             =       ���|   }      !   �      ~      �             =       ���}   }      !   [      ~      �             =       ���~   }      !   �      ~      �             =       ���   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      �             =       ����   }      !   �      ~      z             =       ����   }         �      H      i       =       ����   }      !   ~      �            i       =       ����   }      !   �      �      i      i       =       ����   }      !   4      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   [      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      �      i       =       ����   }      !   �      �      z      i       $             ����                                     �             ����      	                                                                         #       	   �   ����                         l      l       �             ����                                     �             ����      	                                                                         	       	   �   ����                &            !                      �             ����
      �                                    �      �                           �   �   ����         &            !   �               �   �   -          �       �   �   ����   +   �   !   �      �                        �       �       �   �   ����   !         �      �   �   �             �       �   �   ����      �   +   �   !   �      �                        �             conn_count             conns     0          �   �                 �   �                 �   �                 �   �                 �   �          �       �   �          �       �   �          �       �   �                node_paths              editable_instances              version             RSRC<�
�jLextends Control

@export var id = ""

func _process(delta):
	visible = id != ""
	modulate.a = 0 if id == "_placeholder" else 1
	$Button.disabled = not visible or id == "_placeholder"
��$��}E�RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Main/rune.gd ��������
   Texture2D    res://icon.svg �
��      local://PackedScene_4ausq 3         PackedScene          	         names "         Rune    custom_minimum_size    layout_mode    anchors_preset    offset_bottom    script    id    Control    Button    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    Icon    offset_left    offset_top    offset_right    mouse_filter    texture    ignore_texture_size    TextureRect    	   variants       
     �B  �B                  �B                s            �?           �@     ��                     node_count             nodes     C   ��������       ����                                                          ����         	      
                                    ����         	      
         	      	      
      
                                           conn_count              conns               node_paths              editable_instances              version             RSRC�extends GridContainer


func _process(delta):
	pass
�}�~���ie�GST2            ����                        �  RIFF�  WEBPVP8L�  /�����m��I�; ��)����c� ��Եm�V0wKL����55�hd�1g��I�����'�L�o�����xi&�<@k���X�r�~���ܺ����+�ؕOF^��n��6kg��=FNq��6[:ˍ����ً��۸HK�s�6g��c�i�gF��`��Ӹ9+2c����l�h�@�4#`�F�$�u����	��$��q�~����h���%ߣ�pn^�$��q6�"�e�~g�g��n�i0�gz�y��ȴq�D�m;&3m�1�iÏE���c�3�4H��j\]d�jbc��?�>ζ��9�i��g�:?(�[u�A��L�r�YP��z�HoY�(���ED<�ޤ�{��E��ޤ[2Vjk{Vॼ���I�4��B�x[
�)�tyP��ilX�^n���l_xE0���mIc�QQ>O֙p�ˍU�޽ �GE���� �BE���	��T�j+>���m\�۬�J�Fܼ,붭�2;��XT�_�}����/������/�\�<H�Wy���7��u����j�5�_'N���q�k)�t�~���|��b�ӯ[ �ұJ'�S�7Խ��j}�����#����xY���F�W��V�����p>����5^���罔��s>o�ٶ4M����K|[��֡�]c����l(�z{���M��|��C�*,�����s>++�N�n�4�ռtr�*�?����bzڑ�M�Ȉ��ms^���9���'f鹈��/�E�ғ�s�7�M7���x����ԕ3���պ���}y�q�� se�P��B�`*�h&��q8/m��]ԯ���1��/�F<���������������Z��Sݾ��������E�Q4��������<�I�u�ٓ6�j,�_D��1�<���/�R�"]�o�k�}#��4BX8��=qr?5�U�4���p�Ǎ4�>��_C��E���'iy���g]��͸{�V���1�=������`��#8~%�jZR>$;7�9�>���,��#y�_d����t�7���Q/Ŧ�;��RI2;������W�����#��%PW���rQ��2'I�No�3�z���0���
m?���.��
���~4�q��;?�5N����P��㗻ݍg_~4��1t���+��~�_���Ȼ�T�ԍ|&5��5J�k��9��# ���1�����x�U������=T��OS���{�����lk�k�Q)�(������t���wK�)��KYǚ��K�{:vM]ӌ�$jrp���a<�+�&Z���V�_��H3$Mpq������7����ل *�2�rk8��1ct8g*���������9�X��u����>y��B�S���L+�<'��#��@��4�(�Mm!���r��}�]R�F(2��U��4�r�"}�!���*ѫ
��?�G�'��Ӥ%?z�����5�=O��0<M�{)P�r�3RH.J�E{�$CI(!l9�okcI\J����TzP�v�P �mL'�\*$mt�9�x��*�3�~h�3^H���Ӓk�2�Ao�T��$ݫ�b�2�K!��w��N3^�i�CKJ�3:�0��F����\QQN�]��@�������S�G��X]����r�:��� ��7UE�5����3`�'(�O���{<9����q.j��@Vn�:@_�4�*�W�@�?�9GhC�%Ea����6�R���3=t�m���p��Ҍ��ɺ��#kz�M��ףp��3=z��	1��ܩofcX�Xg��f�����oB�P(�5��A�&D�9���3F��7i o��vG=�/?慬2�A$��A�Gb��D�B�oR��W2G�ۤ��8"���oe�#W#"�3��R[#R�B�q(6"bܡ�H#�mD$��I6	�fe/_�3"2�F4�*+`7�%ۤo1w0a���ff�޼O�-��!�-�W��/"����Vq�ad����H�Ty{�s��uY�����X.sP�޴;�Ko������Yn=�X���f4Aa��Z����ZX��Gͦ�9��|AGe-_�V��i�H8\�2�ո����!^�o��Ģ�<�?����Px�H���$�Fۆ9�֦�3L�x�:��F�~0M�nOt����0�����O��b������b��g�;i-@���ej' �j% �j#�ЖS�&�}�����#Y�헜gmN�axY���������j`�j�Ս�5���!�M�n�Bi�ukJ��\�P���-���&,Q��2R��m�q�^k@8��m�1�Ro��Q4��y��>׹-�K��y�� �i �Gn¹ �m��U�Ɲ�A�l�4p>ed2G��0��X�윅ZU�b������F9q���Ⱦ;0�p�ꀻLFv���Ja��dDr�O��V񋵗�Әw/�H�<ւw��5�(.�
�/�w�oS�[ǿ(Z>���k!��	�fA;�z�������l%旚k������NM%.#�����S-mD�4kl��q����?�Ǫ�7��&c�t��sR�D����~f �O������Cz���W���Ӣ%��ѝ��3�����g�~��ggf\r�4�C�@����lh�K^:�Bv�|s<cZ�8��\4ţm �9+9��G� �<jN@��i _�Ue��!�5Uq8�(~b\�2�(�`��=�����̷��?���'�羻ȗ.B�����ȧo(h�C@MT���^�!�-���i'��Oڜv��v0�;���\��چ���p&Q ��0���`L���H��9�h�30��I{#��I�N{���u��\A���]�/'cRA�wij�iH�8Ǽj�oiS�L���.2~TwE���Y��q����;4�ȑ�@5>.;)1;�u�h�������N�o���jXO�+�հ���8���A�s����0o���xg�^܍����|V����xhݜ�j��yM�z8r����i��#�������s=�������酹Wk�8���h�\X�WȺy��u�_�����n�gњ�E��8C�9!^P�+�!n��.���@Q��j}�#�R�C:,K�
<�z�Z�]�\i/�k���.�^L����M)�<"�:u���3A�r?�sxj��cI�q��KoW�y'\���w��!v�,�r��F�Mb�
	��}F��`Ȅ:�]���\,�g����Npe#����q��{3�����$�8Hʻc��!�7j�,xk��3*0�|��"���i���Ҋ�E5a�ȡ�xA�	��y�3�f���񣺩p-�oDd!MT�������ݢ�֗y{��rꢲT���}��i�����^��k1ڨ�̽u�"�8+VjR���QQBJO��*��T4���EYB�B�J*IGB��&j�/��*�V8(�$���*m��<�k��s)I<�`��rQ#nIz:���T�dvD>dk��w��~~�dH��K@��p����X�. r�!ˇ��} Qᝦ�(�dX�h' I�>Mϩ��s�r�c�[�o(����}��ѥv��f�h�9(�]�����b���}.�Vu�%˧p\���k�gެ�t��)`=c����6
�s�����3�OL�p|���˟y��甬��,�Q��+<�HU穭�B�m�7������&9��ipy��I��T���Ϩ�J(�N��R(�V��Z(�^��b(�f��j(�n��r(� �9?:4	miZ�,��ahE�Іơ̓~�z�v-�rM�n̓����YS�k�^�]P�AhM�ЖF�%�B;�V4mhZ�<��<�z-���&�;M�5T��(Ҿܘ�F���u.��^O��E4�-bs_����[F���>����H��J�94H|+���.��'���Ɣ9�_d��W !"K�@J<
`�<ڜ@3dU�rX�?�K� F�][R$1����m}���0@ꪃᏫ��8VTÿ�zjb�o;Tӎ����/XI}����*jd��Ў@��kNvq�2��-�f�=sզ�����|�rڕ�_zRX��ɉ��e��n%��iԕ40p��ܧ��ƥ��/��l��s(j\^ۜ�߼h]��P*3�*#3M�Y�����2�����?���?���������L�g2?��9�ϙ��i��,V�b3��ΐ�4DmIkC�޼jq^�9E�NI�3Y��i|&���?�  �s�@�
F����3][remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://f0py8syrphmi"
path="res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=["res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex"]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/bptc_ldr=0
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1
� ߡ�Qj�+�o��:GST2   �   �      ����               � �        &  RIFF  WEBPVP8L  /������!"2�H�l�m�l�H�Q/H^��޷������d��g�(9�$E�Z��ߓ���'3���ض�U�j��$�՜ʝI۶c��3� [���5v�ɶ�=�Ԯ�m���mG�����j�m�m�_�XV����r*snZ'eS�����]n�w�Z:G9�>B�m�It��R#�^�6��($Ɓm+q�h��6�4mb�h3O���$E�s����A*DV�:#�)��)�X/�x�>@\�0|�q��m֋�d�0ψ�t�!&����P2Z�z��QF+9ʿ�d0��VɬF�F� ���A�����j4BUHp�AI�r��ِ���27ݵ<�=g��9�1�e"e�{�(�(m�`Ec\]�%��nkFC��d���7<�
V�Lĩ>���Qo�<`�M�$x���jD�BfY3�37�W��%�ݠ�5�Au����WpeU+.v�mj��%' ��ħp�6S�� q��M�׌F�n��w�$$�VI��o�l��m)��Du!SZ��V@9ד]��b=�P3�D��bSU�9�B���zQmY�M~�M<��Er�8��F)�?@`�:7�=��1I]�������3�٭!'��Jn�GS���0&��;�bE�
�
5[I��=i�/��%�̘@�YYL���J�kKvX���S���	�ڊW_�溶�R���S��I��`��?֩�Z�T^]1��VsU#f���i��1�Ivh!9+�VZ�Mr�טP�~|"/���IK
g`��MK�����|CҴ�ZQs���fvƄ0e�NN�F-���FNG)��W�2�JN	��������ܕ����2
�~�y#cB���1�YϮ�h�9����m������v��`g����]1�)�F�^^]Rץ�f��Tk� s�SP�7L�_Y�x�ŤiC�X]��r�>e:	{Sm�ĒT��ubN����k�Yb�;��Eߝ�m�Us�q��1�(\�����Ӈ�b(�7�"�Yme�WY!-)�L���L�6ie��@�Z3D\?��\W�c"e���4��AǘH���L�`L�M��G$𩫅�W���FY�gL$NI�'������I]�r��ܜ��`W<ߛe6ߛ�I>v���W�!a��������M3���IV��]�yhBҴFlr�!8Մ�^Ҷ�㒸5����I#�I�ڦ���P2R���(�r�a߰z����G~����w�=C�2������C��{�hWl%��и���O������;0*��`��U��R��vw�� (7�T#�Ƨ�o7�
�xk͍\dq3a��	x p�ȥ�3>Wc�� �	��7�kI��9F}�ID
�B���
��v<�vjQ�:a�J�5L&�F�{l��Rh����I��F�鳁P�Nc�w:17��f}u}�Κu@��`� @�������8@`�
�1 ��j#`[�)�8`���vh�p� P���׷�>����"@<�����sv� ����"�Q@,�A��P8��dp{�B��r��X��3��n$�^ ��������^B9��n����0T�m�2�ka9!�2!���]
?p ZA$\S��~B�O ��;��-|��
{�V��:���o��D��D0\R��k����8��!�I�-���-<��/<JhN��W�1���(�#2:E(*�H���{��>��&!��$| �~�+\#��8�> �H??�	E#��VY���t7���> 6�"�&ZJ��p�C_j����	P:�~�G0 �J��$�M���@�Q��Yz��i��~q�1?�c��Bߝϟ�n�*������8j������p���ox���"w���r�yvz U\F8��<E��xz�i���qi����ȴ�ݷ-r`\�6����Y��q^�Lx�9���#���m����-F�F.-�a�;6��lE�Q��)�P�x�:-�_E�4~v��Z�����䷳�:�n��,㛵��m�=wz�Ξ;2-��[k~v��Ӹ_G�%*�i� ����{�%;����m��g�ez.3���{�����Kv���s �fZ!:� 4W��޵D��U��
(t}�]5�ݫ߉�~|z��أ�#%���ѝ܏x�D4�4^_�1�g���<��!����t�oV�lm�s(EK͕��K�����n���Ӌ���&�̝M�&rs�0��q��Z��GUo�]'G�X�E����;����=Ɲ�f��_0�ߝfw�!E����A[;���ڕ�^�W"���s5֚?�=�+9@��j������b���VZ^�ltp��f+����Z�6��j�`�L��Za�I��N�0W���Z����:g��WWjs�#�Y��"�k5m�_���sh\���F%p䬵�6������\h2lNs�V��#�t�� }�K���Kvzs�>9>�l�+�>��^�n����~Ěg���e~%�w6ɓ������y��h�DC���b�KG-�d��__'0�{�7����&��yFD�2j~�����ټ�_��0�#��y�9��P�?���������f�fj6͙��r�V�K�{[ͮ�;4)O/��az{�<><__����G����[�0���v��G?e��������:���١I���z�M�Wۋ�x���������u�/��]1=��s��E&�q�l�-P3�{�vI�}��f��}�~��r�r�k�8�{���υ����O�֌ӹ�/�>�}�t	��|���Úq&���ݟW����ᓟwk�9���c̊l��Ui�̸z��f��i���_�j�S-|��w�J�<LծT��-9�����I�®�6 *3��y�[�.Ԗ�K��J���<�ݿ��-t�J���E�63���1R��}Ғbꨝט�l?�#���ӴQ��.�S���U
v�&�3�&O���0�9-�O�kK��V_gn��k��U_k˂�4�9�v�I�:;�w&��Q�ҍ�
��fG��B��-����ÇpNk�sZM�s���*��g8��-���V`b����H���
3cU'0hR
�w�XŁ�K݊�MV]�} o�w�tJJ���$꜁x$��l$>�F�EF�޺�G�j�#�G�t�bjj�F�б��q:�`O�4�y�8`Av<�x`��&I[��'A�˚�5��KAn��jx ��=Kn@��t����)�9��=�ݷ�tI��d\�M�j�B�${��G����VX�V6��f�#��V�wk ��W�8�	����lCDZ���ϖ@���X��x�W�Utq�ii�D($�X��Z'8Ay@�s�<�x͡�PU"rB�Q�_�Q6  �Q[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://iknmvmv26u0r"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.svg"
dest_files=["res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/bptc_ldr=0
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1
svg/scale=1.0
editor/scale_with_editor_scale=false
editor/convert_colors_with_editor_theme=false
�����?*g�x�extends Node

# Relays ready, process and input to parent.
# Tracks parent's properties and notifies parent on update.


var last_state := {}
var on_process := []

func _ready():
	var on_ready_regex = RegEx.new()
	on_ready_regex.compile("^_ready_(.+)")
	var on_process_regex := RegEx.new()
	on_process_regex.compile("^_process_(.+)")
	var tracking_regex := RegEx.new()
	tracking_regex.compile("^_on_(.+)_changed")
	for fun in get_parent().get_method_list():
		var result := on_process_regex.search(fun["name"])
		if result:
			on_process.append(fun)
		result = on_ready_regex.search(fun["name"])
		if result:
			get_parent().call(fun["name"])
		result = tracking_regex.search(fun["name"])
		if result:
			var val = get_parent().get(result.strings[1])
			last_state[result.strings[1]] = val.hash() if (val is Array or val is Dictionary) else val


func _process(dt):
	for fun in on_process:
		if len(fun["args"]) == 1:
			get_parent().call(fun["name"], dt)
		else:
			get_parent().call(fun["name"])
		
	for prop in last_state.keys():
		var val = get_parent().get(prop)
		var new = val.hash() if (val is Array or val is Dictionary) else val
		if new != last_state[prop]:
			last_state[prop] = new
			get_parent().call("_on_" + prop + "_changed")
L��RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://relayer.gd ��������      local://PackedScene_xyl0t          PackedScene          	         names "         Relayer    script    Node    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRC�F{C�shader_type canvas_item;

void fragment() {
	if (!(abs(UV.x*2.-1.) + UV.y < 1.)) {
		COLOR = vec4(0,0,0,0);
	}
}
d�mES��3a�����c           3     �PNG

   IHDR         �{`�   orNTϢw�  �IDATx���M����k0H�I��5��<"�P�J�"ҥnI$C�y���}��L]%)�{S����J	��c0H���13���������8{�}��x�y�y���������w�w�+ #############o���̯�WE5B����C?��j��#H!�%m�ȃlE��D�/�'�;��,"m/R	  P#��[>�$��������i�? �z;����	�%�m)��D���W�g �!� �> ���oϑ�}�k�}������S*���>�����;���(:�����y� ������O��nkP� �6 qZU�L$���_����Н ���x� |�Dj*p-�C˦R����u5�?�0� /��5��u� �+ �㐦�y����w��C�>c�Q `����C�{U�,F� Y���WF
t�/�(�߫�����mF=����AՕ����^�����_���9�5	 ��_�ʝ����$��'��X�����p	�-�h���Y��,����䯂{����hFx��_������4!�v�q#������L ��Cn��d^�A��w�V$B�$���ڡ+���ѐ}�$ ��R�~���H�4e��)h�!���,V9�\�q��C؋MX����REb�H�`����ѷ��4��X�VI,�y�ɜ���Q¼�x=�LFA146g�i0�7�
V�o#�ޫ��R�n؛�1u|� ʊ;]���c8�7b��9~MX
u;,fNi�v�6T�<�l���@�}�U��5��*�k��K�����v��]V�٩���M�@�Ԣ1���{"���z�X�1n�qc��/$w|,���Q6�x�`m���6�n,�/$/�(��`�G7��K5f�O�v>*W��c7��O7 �Nⴁ�����=�@���G9K����tdG�0�'6�TH���^��1�t6F�N��bs�0L�ا��X��JC �X�Z����w��V�. Ͼ�
���6������Q�`Ao�]�����e�)Qx+"��\�"�`!�[#�U�`����D�ݍ�Vu�Zu�#��*��E�IEǿU�}��{ �1(�t	o�D4Y+��Z�|�go�	�_NR�s�j-�F�}��m, �������I��"_�<��n�ly�v�MW6I�l��<�����:�nH��*�_�5v�J����2�m�П7e��iC�*W��|������0�^i���`�y�nl�<����F}>N� s���4S�{�%ס����0lӛ���޻ظ�ȃ�
�r�;��+0Jg�v���t�y�^\�+Q	��#B��2Q/C;NF+�s��f&�k$�8O<��^,'H��x\�f��g��E�9��}�����]��Jʠ�1�K`�^�'����gO{F1�F�p��mT�R��RY$]���:V,����3���iĉqN����S��B	aA�3{��S޶��|�X�O �$a0�����Dm��3���p��e(��]ɕ%ӆ���D�(F��^	f���x�A����`t����Y�DB�"p�fYi{e���jy�Na�rH��7���З 0���X��`^�%�Gm���q��'	],�?�X~�� c��ej�ίCs��.Aeq6���a��n�Ѽ<50G��TV4k�������@��#(�?� 0.Ru��A`�.�@����a�����򶈮Ì�9:�C�X.gA��RZ;a T����m��!PtSI�B#��䗒�ӄPϟ�=�!�M=�bV8����R�v�0 j�SιG��F�"�n g`+��!��_
�F
�.�^���.$S��C�g�ZK	��l�	&�u��씰 �Aa{�QvH����8�|��g�����f襒�y��FcX�_Z	�N�fPMN^�N�#3���:��J�J�;���=#���ȫ��df��2���!(��䗮�mf9!$��.�C����֬����K6SNn��M�q�z*5<Nt���~3��y�en5�d�ߺ'0Xq�L������=���	�9�R�a���x/�.�4_ύ��µS��6$;�4b����q�� �>���#݆$�ޡ�>���IFS�J�7�V9�������DdB;���R42x�Q��F�T@9�ʇ�W�,�<�l�_�s�l��e*uӊXX�D �F���T�*���Z��)������g��2<[����!؂9l o�F�ʬ�W`}�:��;�a2fkV7hO��
{�/;� �_�<��X����t�e�*�$ � ���I~w�N��a�.߄H�G�l��r!�`�<����� ��3I�8��F$���OK��@!�n�JO%s��V(d�d�|���J��8��1Z��y��ݑ@Q!P�<���a��o<$���o,��a �Sx�0���pU�^���e�B,,_�.��>�Lһկ��1ٳw�p��g��O�^~B�W�U�8@�d�g8�<!��U?���B�$��5�B�-�Kg����-B���'��`:�cN���	���������Q�O8[�d܁��y�	����xMX�א�p��u����N���4p��@�	'��ن5~]�	�ȟ����������{�p1N�0��;�'א�X���,$O�I������ă��h�F��`-����Vt"�@c|�*�I��AH-����s�Wc>@����_�T�X���L�����0di$p���T ��9][��J!��4��%vq�;����5xL%�b!!�2���<�����E�}H���G��46�+m�t�Ct�`� �@"�rk��e�:�
������g�fztZ�=�VRP� �s�q�F����4����*V+�� c-��Q�;���~U4ΗVK�����Ο ��YE�dXo����:�D�� ��)��[ 6����V��R�o!p��a��bB � ��Ǌ&Y���n���-��8P�2Mص�U𪡌!B n 4�o�%�1� `���1B nA`�b`D==���	�� ��ؼ�
 ���\B�IS@����c��)@��!l!� p��)� HbM]�֡�+<B N ��fE#̗r��<�&6)�����VB� ��,\$h!�G��!	�,?�qӺZ
�_��\��JSH	G 0���3E IX�xr.:G�'�@+N�fs��+&�=�'&=9{IN�Uǻ���ZNI��A��$�@�؊�����6�N|"9��R�Zq��|_ �|�n7k!�$�z�V�� �Yg��~����R�� �ij��E`�t����<pS��r�$7�N`��T	S>�v4��E�;rD�7l�\�h����K!�8Ν7�2y0�FΘ�Fs���t��D���7-��>��k�\���E5W"�ҕ��m���
G�:���+1E�@�x��ȯ�����lz��9@�ҥw����3x?��v��]���Y��Z'l@�&��꘣����0��F+�.���C 4�=�@��;���z���~7N���I�mh �@���*�`������%v��:����A�N�%t�ZcVfN��Sy��������6W�zxJ^
�ʿJ��F�}*_Z�F:r��m?f�Kٕ��$0/���&zH9 �E1�B@����Ūĉ�W�u�@��G4^-a&na�A=�a��"6��@<����n�1t�f/��;P�#0/�<6tk8��Q�S��򐃝�	?e���êQ�~eAa���p��� ��[���ou�@E��(���M�%F@�L�/�T���f�{U�>Z��V�"��8Ep50)������7 ˲���&�Y�O� ��Mشe0_�����Ĝ��'W`���r1C�����!�`�⢨SF����՛����k.z��Y��Ɛ$�kb���$!��<� ���x��D��y؄��%��1G���Ri���!@���P�e�^�.�{���"�E��$?�/�	�(��
���2Ϡ�F;�6U,d�4/+%-�;���r�n��,�,��0�ɢ݉���%��%���	�95�{��?O�-��4~l��� p˱Ƥ�E���~9O�}�"`֊��J*-��(�� �#$�� �}� ��zh^xE�{��F�%�}�@D�o��;,����nF���5$�_�q8�����$�خ�wF���#�$�� �}� ��kH~#p;�[:�O��� ��>
��d$?�m�2(�/J~B��򧻲" �/H�^�1���r9�lB�� �5xs�9�	�˟�y"S=9��`$Έ�������Rl�����s�xF8�����,0�]���P+E/��<�p �T.����B�E �29�o���9r���#�@ΥNB6|	w ��uv����ؗ�A���ܫ+e��G �ڙ�E8h�w���#��@klѸ����������Vr�����"�z&��@M�FFaH�s؋E��n.�S#@�d�>��hf�2B�}�Xڞp6>��=`� !@� !@� !@� !@� !@� !@� !@� !@� !@� !@� !@� !@w!� �3� � �/_�/�'��Љ| �"@�������>F�;2e׏��+UI~�#@򓑑������E��2ݺ�v,    IEND�B`��D�Þ[remap]

path="res://.godot/exported/133200997/export-c9e1ea6367165e7c5c56e7f76bf05724-config_data.scn"
��%ޟp[remap]

path="res://.godot/exported/133200997/export-58d13476aa771dc77970f0f472967d80-game_data.scn"
X3"�!�1�[remap]

path="res://.godot/exported/133200997/export-cdd813ab38d3bd8e260b860aae2a8731-main.scn"
-%֗�T�QB�}��[remap]

path="res://.godot/exported/133200997/export-116b49875b8ab82103b4492c7aee954c-rune.scn"
�	tq� b��Ae�\[remap]

path="res://.godot/exported/133200997/export-88151ca06ce9bf1a56c406af6c1e7e00-relayer.scn"
x�A�Y��*�G�ȉPNG

   IHDR         �x��    IDATx^흍���FMώ�C"�C���q��x�!��/ύ���_�����H�*�$�^�,l���OjI��.@ � �#�`��a@ � �A ��   �	  4:]�     �@ ��� �.C �  �   @`A��N�! @  | �  � ��F���    > @ X� `A��e@ �  �   ,H ����2  @ �@ � $� X��t�  � �  @ @ ,ht�@ @ ����Ϸ���=���{�������u��B �@'�N�K�MA_��򻔟��C�[�J�&-  �I ��)��,M�:��� ئ4�@�(��kG
�O�4�_T4�����G@ X�  ��%�_J�^�O��k�[ k3�� �'� b����S�Ȣ� ƥ� @ 0����q��'oD ��{4� @ t6��+i�N�[�_�B֒#  �  :Y�{i¥C3>��w�R$  L@ �шi��O�&|'"��c�@ �@ t4��i�߫OD �xN��  0.@G�9N��z� �h_��  � ��u$�_H�;W� pL�� F%� �d����3@'�R-  �� �,�`�_{Ƒ���K�� �@ t�P:�W��y_ o@`P�����]5���@�
@ #@ 4�Z:�_�Y��w�'����:@ �@ 4�T��{%g `����:@ � @4�T��ګ�$�?n�=��   �A  J��S���FUވ xҨ.��   ��  ���_{��ږ�  �F ��b�G�ګ�2pݨ{T@ �@ 42X�ѿ�� �lK5� F$� h`���2���Aר� %� h`�� 6�+U@ � ��zF��# :ە�! �N �lA J����_<� h��  �F �h�N�� �J�� f � p�b���[Y �̱[@ @ 8Q����_�k}��u��@ c@ 8�+}�����?����H@ 3@ 8XU�k)��C���@����  � ��:.�Ӟ0�olO��  0+��e;O�3�ohK��  0;���;N�k/��7�%EA �� ������7�#�@ X� �����?H7�����  p� �,��	:O�k�%�??�RR@ � >@ l� S�ڃ'" n6v���  ��c������o7�5+G�n%H~@ @ l0z��m=_��`C�B X� ������?=��u+�?f�_OP7  �1	  *�>�����Կ����*�G@ ``�H����~z�����   `� �����������~@ @ d/���]�_ff�L��?�t)�� FN��WI�4#y�$��[P�@ @ d7�v�]K�g،$�  p� ������JF����  �� ��@��v����`��f�� @ @ �@���[��l�{��B � �@  (��R�ZW�����:F�[����  � ��3��ߵ����]@ ���Ŵ���`#m��'�@ ��@ $?���C�� ��e! @ V B2�>���}+�����)�  ��@:�O��w���OP��,@ �Xv ��|鍌���h?  �#�� $���|�]<��E�  0:��@:�G��_b<���P4��H� �������tG�V@ �XB ����!�� �L/ ұ��4�̀�����Kb@ ���
�4��S����L�Zg��63�  @ �� i����Mfn�0�A�  �^� ���1-(R  ��-����ou;n%H~@ _ ��)��#}/�)14݄  �E`�W i��������7���]	$ᭋkwl��[_U�~����߹���! �|C
����eY��礬$��
l�}���H��twͭ�ӭ�����T��T6�l��FC	���>?����� p+���+��M��.�{��m <1S6�B �CIB����;~"p-�����)���o���皫���������; PO � ��0�zK�ɂ@����7��[<[:�ߊЛ$nZUH=X�@H@�/r?�Z;q��v�i:���u�0+0��h�B	���w%��#��veA`D�j�D�!ȯh����{S��m��Z������}���_�bF`2��;M	t ���h��Ȧ*��F�O
ғtb)��n� ������_ʜ؟��� ��ו��`b�oo�g� ��\H�Z�J�e߈������:�	4 �=�	��&*����"\�%N�h~�����F�_g��6=r �. 䁤�} q�!�ǂ�pU�޻��֧1���N��h! �������\^�n����)�_�a�M��}p[���X��� Hӑ* ��ЩЇ|��-���=v%��a>+N�� G�P"͒���J��՞ ��3oV#S�E�1�'
rA {�@z@��Ȥ��1��ߧ�to��^i��V�/E��Z�!0O���tj����w���fk�MD�x�&|d���� Е��P�{��60i��#f�`��� ��ù����&����55��f`}�GJ��� �i�_W����]jo�p�f��O�{?m�R[��tG������f������/0�HEO�����&m��lu�>��f�*�S�{���͹o�����_��4�/)C_�0�y�͞���;/0��}�i�?��y����O\c;T�[�����iu$���_ţ��v�9!;1��pvʔ�$�'"�% �+�F<�Dr���������0]��?���ţ*�\i�ЕT�Z��z����$"s������G��!�{��z��[�rJ�z��&���h�����5�3l��yl�ʃ@t� ��^=��VG0#\�l�4��h��irX���=�vYk#R^x@�����.���egTP'm4�{�Z~�D�`N�	����f=@�{�f�� :e�k "^�-}��s{�l��);� ���U�ޟ�V�W��\������!��FZ0 �0�Y�-��f�j��w�����E��e4ȧ۹6��*2��}��"^���ܴk��뢼
��U��A�K �+ χX��6����r
ٚf�� �l5�Q��\���f��P-���ff�ې���� ����a@=.��Ԧn��р�u6zhm�*��m�g�7-zS�������j����`�$3c>M�	� ��ܤ:Uw��.迋�ǽ��Z�,��%g��y�h��03p<�X��� H"��H������:��x*�\�Fz[���-�*�"��3S��84XX��d��� H"@��y|��~��C
у;F~���_E�&�,O�S�*n=
���G��/hK�T<]8�ה3'�(rP�`�K�'�}�Y��=4
��?���N�kP���Hd�=E������ݿ�;��a�r�C��G��5�$�T Iȹ�i�Wgz���);���+�i]�r39�[�ht/PM{�������n���-p,��k�Z���Z�ӌ3bV��p �L�F1zx�e@��CF?[����^ʴ�~�j�K�z|��!�b�t��;� f�4*��@P�#��4Es���f�
]�9�{�c��ٰ)�8:q�  �O8�k{��%w$���?=�R�Y�r�U�b��=j��# �6��߄?E`�+b[��Ұ��G�;�i���d�3tV��A �G[�f��ɥ��%u&��U�]����`:����Y)*@;�mE�]����:��a��m���;��`�ߓ=@<���x!��:@��ా{���kvl�{��#� �g��-
�.��S�;�[��X�ǕM�:��, �,����:� ��A��V3z�,W&�����O&�S�f�k-ފ�?��&�C 
@KT�#�� D@�����3�'l`|�����I�  �}ζ��=��:$�u@&5���*���������p0��>�� `So�è��
�G3�oOcJ:���k �<�9I� � �Ng[D,}�Y#I��L�g@7~��g0'� c�)��Av�'��;i��(��Yw�G��T��G�,.f],(RF�f�kDz��Gv���;t] �����g�_�[o�����I�  ���[�6�bd�������h�Մ�~��3��(�N�� ����u���o\n*d[f����7ۊ;�C�W ��/p��姗�cv� >I�@ �5�MÌW��6jٕ�N�_���
���>@ �'i\���1k��ï�]ˍX��ڀ �h��� 
ؓ4.@\ۘ�,��Ł:r���`��� (�;��B �'yL��vqiU�}���@��	Bw�� ����$�K �6.-$�</�Q�G ��v��K!��$� �i�VS}L�8Ȝ�f ���wc�  
ؓ4.@\۸�,������q�ɱ=��9�R^�"�2 ˘���0PGV����C�WD�B�x�~�q8?-�E�E  1��n�J@^�b�N�_�L�����Ư� ���. ]�Ǫ4�P8C�t��h��&-���~C?
dq! ,(RFw��&�� y8��zlp�6�u�ʊo�:b/��0~#3T<7ؓ4.9�m��L�R���n��˶�;<(@��8K"q�%�Y�JW?dq�݂"e� � a����e�	�Ѡ��q�p��d�*]����tfKŭ��̋E�A �q\t]$(���� ����B4��$��Y����K0��7µ�ū�[��2����в[�����
c~R&� l��M3�6�ѕ[	~=
�_f����5�0���ژuiq�QG�&�Ǭ$����[�=	O�t��]�ْv������������	  �7�_�n$��5yح�~��_�����V�4I9�l5�O������k�#>o��OkAl?_(�/@_�C�dg ������ ���Z���xb��\�\R�����kA���i��M��'��u��������$��!� �c��-1~���_��ǲ8MOM��D�5�t&��PU�ꭎ&�盓#j+'?e�?�I9� ���̆���F'H�����/�Er@ 0���5��z ��ћ�T�<�\N�V���75t � � }�*���9��G�:�`���6�$wP�����,�U��e��v��t�.T�K]�W��_�;����1O�D ��5�x= ����Z������z�*����%%#� f�њc���oo�e��u��R�����/)1@ c��y �+�*�O���m�oק���O3x�&a�_J��C@ e���M+��|�ҋ�_J�<��،f�Qe�_�k�� `0�Emn�gW	��9�)�>WB��	-�I 0��b6�`k ���	��	H��?B�oS��h�Y .LK 0�i�w,�������8��������4b���Q� #Xi�6�Zc�~�����vw@�ꧾuሑS��Rt,�X���5�և��U��8�կ�(Wm2ĕΜP��������W�p	i@ ` �"�8�56�<'�`����xM�Ң���W��_+Uo"�m�$� ��IY�	�
 �����%�H��Gi�.������l?�u P)���G[��� ��yK�kۃ�B@?$�v�R࿔���E�����l��C ���� ����l��ׯZ����S���$5�מ*YB_���y[��<� `d��v�e�)b\�t&�F~�$8���^�����F[L������-K��@ �b)���S���ql)����^����{��鿕��C�l8��LF�� ����J�:C��������S��w��B����`���3���]���������$� �I��������.�ߟ��W,M �����<�<�k1�?�AhN?�~쩹� ���������� �`�!�����O���#[��5%� h���j�k��g���`г���  p���_��V������Z��O�4N�~ \��= \",���௫�o�~�������	a�l�  �%h�����/���7͍������.@� �� ��|�GtۏS���}�ۚ$� h���D�����;�tԯ'��>.@ �  I� ��D�ǣ����E�e2��:jw���Q��_W��ƻ�Q�z�ݛ �����|���WW����	��NAz!� �5�`�}���IE ���J�3@ �h�A�D�����>��+���i�8 ��j������"@W�����X�?�mOg�@ 3�
�!����D�N��H������S�>F � �`���@�?h�5�r�&ؚ�[i����������=��$�  �XR����t���Ӂ� ��OG��߻���=�L�($� (F�:���fz*_�;kv@�@?���L��65" 	! �� [	��$��� ����!� ��F�,�,L�!�ё�%� �%E�"�"\��͸( (%� (%F���g�&`& ��  �b�bdd8E��o�� s�( ~`F��o��~A� 7��u	  ֵ�i�	��8�pGLX� `-{������+A`M�5�n�k���܂�	�%E:@�$ RM��_�nkFD�V�� X�� ���V�F?���.��B�"1 p� 3 �D1��������y�(v+������	u uܖ�E�?�w����E����2�2^K�&��D����!@�<�yF������|� 6#� �&� �C� ��D�Y�:� p��� ୐��-�#6�%���) �	  ���$�?��A~/A�����ד�j�R.,,%�9="�!p�  �����/��}��B��4wl
��l�&D�f� �� z�|��u���_\�	�D�fClFH�B ��7�����������4�#��I�،� �� `rO��)]ԑ�����/��K�G��@jD�f� ��>����A \�\�?"�� �r 6#���	00�������ׯ�m����7Pʉ،�V&� ���i%����Nҥ^�h��͌،�V%� ��iq��+���=�D�6�InD�f��"��VO����������]�?"`� 6#���  ��ި�ŀ͏�����5�R�J �Y;���Q?��ll*�#6�!�B 0��Ӈy�}?��m�2�#6�!�@ 0���*���BD�f{#6#���	  �������4q�����N���)`f��֕�����7s����]�!�J Բi����G�ѐ����R�� ������9���>CD�fG@lFH�@ ��@����i7����3wUs�G�K�˪�e�n�ٓ�,e���kZlkE���ԓ@ 2p��#�����O��$(蟟��n��?�O�E�*��Ki���Q�"�-��FG��  YT��ο��~7R���I�����>�k��F�1@�[���rf�@x� &�@y%M���-/�k����*��@�+��}�h��{u!��#ʙ��	  �G��?��o�>�5�bL�G�x�  �IDAT�7�%�F�$YP΍I ��,����Ҍ�FM�������ƈ�r�C�3#B@ t6K�S�4��"#����|���G#�PΌG ��$靸��=/}ϯ+�uܝ����֔�q"��`��rf�@(�N�H��o��se����\�����Ί�3A�{"��9 � ��)$�����?��Uw	�Ki���B��F�3#B@ t0C���7ҭWѧ�ϡNz��
��si�PPΌ�N ���G�~|�/�_�W�]�P�=��rf�@W����W�O{̩p�sZ���D@���(gFt#� h��y����԰;M�J�T\4�PPΌ�B ������Ƴ����3EZ�"��(��(gF4'� h��q�G�>�=�����m�W��M�z���'� hdB�����O��������N_Md&�����3#�@ 4B�4��i��G�zcmp�¡. ��(gF4!� h��i����g����J��(��(gF�@ �#����KN��7��\o@���PΌp%� p���p	Tz���aUSo���丰2�	��Jw� ʙ�n nh?=���:�<��ָE\I��Z��Y" �^2D@93r@�� ��BV�Ot��;̰�4m{8-T=�P�a�����]���IG�W��k�γ �LD@����C�3#L	  Lq�-���i�5vc�UӼil�L@��?�ᰠjtd�A �H���?���Cr���%���t��rj��3#L  L0.�����$�?vl��E;��X�PNPΌ�L ��������w�V�[��Ѥ�E#rI}I�(gFl"� ؄�d����Vײ������r�;�C�F�3#�	  �ѝ�h|�/��3��5�������K�(gFT@ Ta;��x�������)E���j"" ׀_�!ʙ�� ���2�Jg�?������23y�d��r҈�rf�@@����; �����Xxe֚����N"D@93r@ �  UYB� z��mY�L���9�9��A�3#�  �0�'2 ����`��7"��5����� g�%0ܓ�@&���r�eA��I٨>'D�3#N@ 89����v��3D1Awb�(��{!��.$}T޼�|;�,	  ,i����[ ld̾�檤��rl��rf��A �0����5 ��9m���/-!�)#ʙ�_@ 88��(Ph����PhcI�(gF�!� ppc�+�B
�ݧ�[�F�P��'� p�� � (������'��Z�(�uJ�L@93r@�#��#nt�9!�R�� ��	��+���~�4�v�� 9*  *��d1 $}�S'i>~�2��-p| ZP� �(�"��9'� pr 	J�&�%a�L;	�+I�kf�s����p�w���M��:�kQ'�?��@�����\���~Ո�LC�Kf|?�j"��D�Z� �����{-E�0*������.F��.|j�Ƀ�aF��E�q�\�	�FG�S N�a<�杰���
w���Q=Gg^u�u����x� ��=�A��P�Z\,̠h� ��WF9�P�P͍�G  �\��0 m%� ���x�%�]2"��B�qCTs#� G��������</ ,��?o<�"��s��;"��ςjnd�G �����d!�c��]���-������j���u؍�S�Țѩ�ŧ\�}��c��#��#OIkKyp�^�Zw\�����u� 0��PD@��"�ё����������a3ճ-����
PǍgB5722���`����QMgW��3T1ƫ�������BԹ"��"����y������8w#t�#�\�����>�����SgQrE&� p��<��
��鵵�	�g3��,�x}��n� ��[k�O~5,,aE�� �����Pw�b��F�o%�?��"����]wi�w6�f�\n�\�f��� �L���,��t��}�_�4 ��˚D��#�r<  <��+�)PM�1�SPu[d���c��Ù�n����b5���  \d���i���c���mԅP�8�����ND@���������:���@#����<�����uۥ���O?�d��r����J;�(%�)�.:�@���Y�\-  ZP�� �`�gX_�G�Z7xKy��B�둿���t�ߩ>:��U��jl�ei�
6:�@�����=�?�G���dc}����R��ޑ �����Xb��Csǰ�;S� 6���`�̓�������8'��J�?�wm�Ͷ��f���� �����dU%�t�_8�W���~Í�9&+�4����w#h���
N_ijЯ�n$�\��-�|�	  �3,*�q@ۡ������P�l�t�(�e&>�:�i0�ޓ͇5�o
�?�p�P!pk��2�  �xmN�<�;4�M%�V��l�e��|+Z�,no��*g��7݃?K��M�עY�5f-�| /�'ʕ�Io���UO�: =u��ʉU�T j���:�Y0��~._�4�o�{pKw1~�F��;��E�Ʋ>�~O�~ȧ�������*�� ��sC�}Kg�ە�z]o)#J�Lh�/��ރ�����bn�G�6[�����4����5�Aa���t��>������ `�d`$B9g|�e����=x��ϭ�S�@)1����[��N_	�6ݭ��wm���<D�9B���X!����n� h �X�&�CmZ��&�Z�iFD�F\֖Q�/4�"�����}�����n�=h�R�>�z���䫧n���`�3�s�7z�ߌP�m�t����W��Za����S���p�����{�Rܧ����7޽�w�u?�ۛk�� ���@i՚[��UυS���#�V�_نY��khD@.�6�ܫ�"�Eς�:� ���h�u���$�AZ�&�&Gs�`����Ж��j�푈 O7(�PZ�����" ΀s�o��?Ԭ�K���<H(@�����;�\{��k���g��Y�!E� �_-������@ �g�,E�=�tW��*���~���|*����!��~�GB��ސh���7"`�lȚ�w�%	�;��q6�'>�`�tS�iQ���h׭��{���?������v2��q��Em]� �%�ʖ�� p����;�69j�aV�� D�ЪO[����k�zW>�� բHD�f�S�D�f�8Y���Z���������땎 l���S�ش���)����F���A�)�;��0vy�1P���-�-ɱn~����=�`���L��k�P"`��<9��� �@=�k<���B�2�
�� [�r�!D�$�_Y��~��'�+Ў������<�6v̬�}���ڱ�'�n,�;'�1�w�8�A^Q��.@d�h[��`D���~�EH�\�Bԙ_�]IN��W�s&�� 8x'��w�i]��Rυw]�˿��M��߂5"���pkuw0a�Wò�ν��B mU\zп��t��ڵ���)�#�n�YD������#^չ6��[����Q���c��A�et0k�k�%���:����$���ڀ1�N�/��?�e���UL��@S|ϣ�#�r! ��6/y��:��E~M>Y��h�"� �&&�jDv Թ��\ ���L���/z�eC�:�G��@0eE�1E,�u͏. \�p�:o�˅ ��6L��j@��('	j������7�4D@��"`�ெ{+ςgu$�)�E�CO��?��*`����[����:��:�QE�"�_z k���d.���E�Y�I;U������o���L��cM,��X,��s٬\�,L�&�ɥ��Q�����v�����czߋ��ruࣈ����>#���_sr! r(-�&=\T蚁�姢@�{�w��.����M?��o	���Pg��"`��b���f�B d�"�>�@�t.F�"��p�D�b����:�,ʅ (�Eb�E Pg��"`��g~<���J  Jh�@����^�_]c��u����Yl`3@�T��uj(�8V.�c{! �:D%���"��۽\�e�  �x�S@ԙP�-�"�o�W�Pώ��� "�ά��*n�*l6� 6)S@ԙPč�_��>1��)%B`
��:3"����0�&B ��tM Pg>D�In�:�2υ 0GJ��� "�Ξ�����u�����B!0D@�=w�����-�-C`.��:{">r#�׹�k.�+^
��\u�\\����=�1@`.��:{.*�u��$�	f*��\u�\L��ܤY.@3�T�� ���'}	�e��%5�v*��yv$��q"U[�����@�6)�:���C�iLIG Џ "�0{�?���� ��� ������4$�J �?�C`.��O�$���׳�0�e�:X]�;9�@ ## p���"���3��H ��A[ 0��D �"�]�+�EM7!Ѓ�*"���û�s+�V�� N�]��F%� �r��U�rB�� N4!�P�y���Oޝ"�{�|o o|&�@����F�|&��}єؓ �'}���E ��ޟ��LÔ� c
�u8� �����홆*�4�0{�!��3W" �Ih�!` ���B�g�D@H��(�C`� �ۻ	�ߞi� aMC� ��
@�w��=��%" B���A`"��o�{��KD �7��:2D �����L�(0��h$�!pB��݀�o�t� Ø��B`D ����{�C�� �\4��7��onw��9��
D �g3Z��>�@)n�!�D#! //���  ��h �F��� � �H4�'@�gJ�c@ �e/Z �@���	  �7!� J�Kh�vf���K�  �;�8�@ ����K��N@ �") 0&���v�վ �|)�L���� T�  �ih �� �+���#����?ؗN�-	  ZҦ.@���=������1"��q� -iS Є ���^��J�E�snY"�%m� �	����J����� h���  o{�'�?"�w� MqS �E��oO6#�#�7+�5A ^��d�?"�� M0S	 �E �?���:�{#my���"�#9InS ��H�#�!P��KF��D@�#%A D�m� �� x-^e3�(�0�! 2M� ��ு_���h�0�G" 1̈́ ���?}����\F���0��h" p��"S��D@��@4�*��0�o���������^�v+�� /���" *���C@�~��O�Mjm�� h����}�+A �"% �����:0��4�� 6|����@Ơ)��i�.%��I9u	���I�)�[�H$� b��e�֘��k�G��r�� Ø��B " t�ߣ�H����ɼ*�;�H$� b���������Z� hE�z  ��D ����8����8���7aʇ L�O������0�����<#R@ L$ ���� N���3`�� l�O��צ�n�����I��&���  "@�� 2�#,<7f��v�U��o:�#� sڕ^A`J�~`�����B �gSz�i	� ����ǀF��
���Q�.���<N�� l!����F0j�$�@ mr�����׽kA x�|@��� ���� S��R�v*� �<�T�Gl���y �m@  �BAg����B���4�'�L���?" �o#�D D�m� �	�o�)z�H�߳�����lC�'����<x𡾈�s" ֶ?����$�\J�w��� |D@G�,�P ���@<��O�" ޽r�E��6����lt�Y��[]o��WL?�ƍh�u�  긑F@��#i���\��5� �� �Ȁ�)	�x�� �	����K�*�/��%���.x��1-� �iZl ���,E\l(f���_~�L���DԳ�ʉ �"K��@wim�Ґˊ��%yt�����ށ,� �V�  �HR �@��W�Й����ߦ��w��O.c� c��C l�GV@`li��F�m�h��Xm�v�� �"��on@�@ K@�5;�/j�  �4D@?�# ���f@ ��>n� �ÝZ! @`� "��;  �3�F@ 8@ ��- myS  � �h��v��	� 2 2 $A @�@ �%���y�4�?cj�   �
��
hY �H
@ m	 �x# ��R2  @@<P��+�B ��!D�!�T��)%B ��D�-T�-OJ�   G� ;� ;��@  l # l8R
  4$����!%@ �@��m� ���� :@��G Գ#'   ��3���  @ D@�1 ���@ 	 ʌ� (�Ej@ L �o@>+RB �� yFB �q"  D p�X��H@ @�6`@����  �G p� χH@ �@6`P����  �O �5+@���� &��k<���L�! @�� "�/@��� '��d@���L�! @�� " P�5�   �)�.���  �XY  j<�<�  0�UE `�#�  PK`E� ���A ��TV��ܗ�@ ��+� �O!/  LG`� ��u�  l%��@ l��C ���f�)ݖNA ����E ��C(� �%0�@ L�t� ��( V�A9�  05��D `jw�s�  `I`&� ��ʂ   ��	�" ӻ*�   k3� ��WP  ,A`t� X�M�$  xY  <<�2! @`�� �2.JG! @����" ���@ KM  �rO:@ �F OO�l@ X�@#�������E l�G^@ ���"`s��&# p]@ ��'`� �H@ �����0� |�  �L�H����)�  �6� ��� �/! @ �T� ��� hdt��   T�� �@ hL s&�5�# ��  @ 3���B � :82�$�# :�j! @ f� �@ �L �|�z�i78
���! @ @ L`D� @ (%� (%Fz@ �� �.@ � J	  J���  0�F��   �R�Rb��   L@ 0��  @�� ���! @ @ L`D� @ (%� (%Fz@ �� �.@ � J	  J���  0�F��   �R�ΐ�i��?'    IEND�B`��X�   ��e�2�W!   res://ConfigData/config_data.tscn��ʘ#J   res://GameData/game_data.tscn�Y�B
I�   res://Main/main.tscn�-K�y#   res://Main/rune.tscnDW=U��   res://icon.png�
��   res://icon.svg-cq��	p   res://relayer.tscnȲ�VECFG      application/config/name         DoctorateGUI   application/run/main_scene         res://Main/main.tscn   application/config/features   "         4.0    Mobile  "   application/run/low_processor_mode            application/config/icon         res://icon.png  &   application/config/windows_native_icon         res://icon.ico     autoload/GameData(         *res://GameData/game_data.tscn     autoload/ConfigData,      "   *res://ConfigData/config_data.tscn     display/window/stretch/mode         canvas_items   display/window/stretch/aspect         expand  #   rendering/renderer/rendering_method         mobile  T�2D��hK