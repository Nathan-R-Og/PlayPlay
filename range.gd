extends Node3D
var time = 0.0
var dayColor = {
	"top": Color("#006edf"),
	"horizon": Color("#006edf"),
	"bottom": Color.SADDLE_BROWN,
	
	
}
var nightColor = {
	"top": Color.BLACK,
	"horizon": Color.BLACK,
	"bottom": Color.GRAY,
	
}

func _process(delta):
	time += delta * 3000
	var minutes = time / 60.0
	var hours = minutes / 60.0
	var ranger = wrapf(hours / 24.0, 0, 1)
	$Sun.rotation_degrees.x = 90 + (ranger * 360)
	$Moon.rotation_degrees.x = -90 + (ranger * 360)
	var scalar = ((sin((ranger * 2 * PI) - deg_to_rad(90))) / 2.0) + .5
	var mat = $Env.environment.sky.sky_material
	mat.sky_top_color = cOutput(scalar, dayColor.top, nightColor.top)
	mat.sky_horizon_color = cOutput(scalar, dayColor.horizon, nightColor.horizon)
	var what = cOutput(scalar, dayColor.bottom, nightColor.bottom)
	mat.ground_bottom_color = what
	mat.ground_horizon_color = cOutput(scalar, dayColor.horizon, nightColor.horizon)

func cOutput(range, color1, color2):
	var s = Gradient.new()
	s.set_color(1, color1)
	s.set_color(0, color2)
	return s.sample(range)
