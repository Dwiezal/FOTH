extends Area2D

var splatType = [
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat00.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat01.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat02.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat03.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat04.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat05.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat06.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat07.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat08.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat09.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat10.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat11.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat12.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat13.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat14.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat15.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat16.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat17.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat18.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat19.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat20.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat21.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat22.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat23.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat24.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat25.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat26.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat27.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat28.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat29.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat30.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat31.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat32.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat33.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat34.png",
	"res://addons/kenneypacks/splat/PNG/Default (256px)/splat35.png"
]

var exp_stored := 0

func _ready():
	var splat = splatType[randi() % splatType.size()] 
	$XPSplat.texture = load(splat)

func mobulate(xp):
	# modulate based on mob
	var XPColor = Color(0.0, 0.0, 0.0)
	if xp >= 1000:
		XPColor = Color(1.0, 0.0 ,1.0)
	elif xp >= 100:
		XPColor = Color(1.0, 1.0, 0.0)
	elif xp >= 10:
		XPColor = Color(0.0, 1.0, 1.0)
	elif xp >= 1:
		XPColor = Color(0.0, 1.0, 0.5)
	modulate = XPColor
	modulate.a = 0.69
	exp_stored += xp
