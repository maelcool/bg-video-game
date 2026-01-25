extends ColorRect


var positionOne: Vector2 = Vector2(20,30)
var positionTwo: Vector2 = Vector2(20,30)
var colorOfDraw: Color = Color.BLACK
var widthOfDraw: int = 4


func _draw()->void:
	print("DRAWN")
	draw_line(positionOne,positionTwo,colorOfDraw,widthOfDraw)
