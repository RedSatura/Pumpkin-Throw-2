extends VBoxContainer

export var title_text = ""
export var description_text = ""

onready var title = $Title
onready var description = $Description

func _ready():
	ShopEventBus.connect("update_item_display", self, "update_display")

func update_display(tex):
	if tex != null:
		self.texture = tex
