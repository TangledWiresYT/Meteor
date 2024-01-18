extends Area2D

var speed = 50
var random = RandomNumberGenerator.new()
var screen_size
var randomX
var randomY
var spawnLocation:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_parent().get_parent().get_viewport_rect().size
	random.randomize()
	randomX = randf_range(-1, 1)
	randomY = randf_range(-1, 1)
	if spawnLocation == Vector2.ZERO:
		spawnLocation.x = randf_range(0, screen_size.x)
		spawnLocation.y = randf_range(0, screen_size.y)
	self.position = spawnLocation
	self.rotation = randi_range(-180, 180)

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass

func _physics_process(delta):
	position += Vector2(randomX, randomY) * speed * delta
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	get_tree().reload_current_scene()

func _on_area_entered(area):
	var score = get_node("../../UserInterface/ScoreLabel")
	score.score += 1
	queue_free()
	area.queue_free()

func setSpawnLocation(location):
	spawnLocation = location
