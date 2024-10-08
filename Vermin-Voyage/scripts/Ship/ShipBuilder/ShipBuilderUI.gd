extends CanvasLayer
class_name ShipBuilderUI

@onready var costText: Label
@onready var weightText: Label
@onready var areaText: Label

func _ready():
	costText = $GridContainer/Cost
	weightText = $GridContainer/Weight
	areaText = $GridContainer/Area

func SetText(cost, weight, area):
	costText.text = str(cost)
	weightText.text = str(weight)
	areaText.text = str(area)
