extends ProgressBar

@export var duration: int = 20

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Setup Timer
	timer = Timer.new()
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.timeout.connect(self.count_down)
	add_child(timer)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func count_down():
	if self.value > 0:
		self.value -= self.max_value / duration
	else:
		timer.stop()
		timer.queue_free()
