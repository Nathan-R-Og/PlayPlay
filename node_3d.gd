extends Node3D
var time = 0.0
var realTime = false
var miliseconds
var seconds = 0.0
var minutes = 0.0
var hours = 0.0
var useTime = 0.0
func _process(delta):
	var localTime = Time.get_unix_time_from_system() + (Time.get_time_zone_from_system().bias * 60)
	if realTime: useTime = localTime
	else:
		time += delta * 3000
		useTime = time
	miliseconds = useTime - floor(useTime)
	seconds = fmod(useTime, 60)
	minutes = useTime / 60.0
	hours = minutes / 60.0
