extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	DiscordRPC.app_id = 1332642844766371963
	DiscordRPC.details = "Playing FishyFish!"
	DiscordRPC.state = "in the bubble"
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.refresh()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
