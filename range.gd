extends WorldEnvironment
class_name DayNight
@export var dayColor = {
	"top": Color("#006edf"),
	"horizon": Color("#006edf"),
	"bottom": Color.SADDLE_BROWN,
}
@export var nightColor = {
	"top": Color.BLACK,
	"horizon": Color.BLACK,
	"bottom": Color.GRAY,
}

func _process(delta):
	
	var ranger = wrapf(get_tree().current_scene.hours / 24.0, 0, 1)
	
	var SUN = get_node("Sun")
	var MOON = get_node("Moon")
	
	SUN.rotation_degrees.x = 90 + (ranger * 360)
	MOON.rotation_degrees.x = -90 + (ranger * 360)
	var scalar = ((sin((ranger * 2 * PI) - deg_to_rad(90))) / 2.0) + .5
	
	var mat = environment.sky.sky_material
	mat.sky_top_color = cOutput(scalar, dayColor.top, nightColor.top)
	mat.sky_horizon_color = cOutput(scalar, dayColor.horizon, nightColor.horizon)
	mat.ground_horizon_color = cOutput(scalar, dayColor.horizon, nightColor.horizon)
	mat.ground_bottom_color = cOutput(scalar, dayColor.bottom, nightColor.bottom)

func cOutput(range, color1, color2):
	var s = Gradient.new()
	s.set_color(1, color1)
	s.set_color(0, color2)
	return s.sample(range)
