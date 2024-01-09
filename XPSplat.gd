extends Sprite2D

var splatType = [
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat00.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat01.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat02.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat03.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat04.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat05.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat06.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat07.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat08.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat09.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat10.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat11.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat12.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat13.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat14.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat15.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat16.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat17.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat18.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat19.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat20.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat21.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat22.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat23.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat24.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat25.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat26.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat27.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat28.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat29.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat30.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat31.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat32.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat33.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat34.png",
	"res://.godot/addons/kenneypacks/splat/PNG/Default (256px)/splat35.png"
]

func _ready():
	var splat = splatType[randi() % splatType.size()] 
	texture = load(splat)
