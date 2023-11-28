extends Camera3D
@export var guy:Pet=null 

func _process(delta):
	look_at(guy.position)
	
