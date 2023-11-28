extends CanvasLayer
class_name Pet_Game_UI
var twelveHour = true

var dateSplit = "/"
var dateOrder="MM/DD/YYYY"

## Reorders a date according to a passed date order.
## To use, pass the input date, the splitter you plan to use, the new order, and the old order of values.
func dateReorder(date, splitter, newOrder, oldOrder = "YMD"):
	var oSplitter = "/"
	for i in date.length():
		if !date[i].is_valid_int():
			oSplitter = date[i]
			break
	
	
	
	var wrapper = Array(date.split(oSplitter))
	var y = 0
	var m = 0
	var d = 0
	
	for i in oldOrder.length():
		match oldOrder[i]:
			"D": d = str(int(wrapper[i]))#day
			"M": m = str(int(wrapper[i]))#month
			"Y": y = str(int(wrapper[i]))#year
	
		
	
	wrapper = []
	for i in newOrder.split("/"):
		var use = -1
		match i[0]:
			"D": use = d#day
			"M": use = m#month
			"Y": use = y#year
		#pad_zero throws a fuck ton errors; using this instead
		while use.length() < i.length(): use = "0"+use
		wrapper.append(use)
	return splitter.join(wrapper)

func _process(delta):
	var parse = Time.get_datetime_string_from_unix_time(get_tree().current_scene.useTime).split("T")
	
	var raw = parse.duplicate()
	
	
	var newDate = dateReorder(parse[0], dateSplit, dateOrder)
	
	var wrapper = Array(parse[1].split(":"))
	if twelveHour: wrapper.insert(0, str(wrapi(int(wrapper.pop_front()), 1, 13)) )
	var newTime = ":".join(wrapper)
	
	$Time.text = str(newDate+"\n"+newTime)
	
	
	$Dial.rotation_degrees = (get_tree().current_scene.hours / 24.0) * 360
	
	
