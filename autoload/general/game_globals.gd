extends Node

#region Variables
var _global_vars := {
	"time": "08:00 AM",
	"fame": 0,
	"days": 1,
	"money": 0,
	"name": "",
}
var _stock := {
	"Hartroot": 10
}

var event_check := {
	"tutorial" = false
}
#endregion


#region Physics layers
const world_collision_layer: int = 1
const shakeables_collision_layer: int = 16
const interactables_collision_layer: int = 32
const playing_cards_collision_layer: int = 256
#endregion

#region General helpers
## Example with lambda -> Utilities.delay_func(func(): print("test"), 1.5)
## Example with arguments -> Utilities.delay_func(print_text.bind("test"), 2.0)
func delay_func(callable: Callable, time: float, deferred: bool = true):
	if callable.is_valid():
		await get_tree().create_timer(time).timeout
		
		if deferred:
			callable.call_deferred()
		else:
			callable.call()

## Example of use: await GameGlobals.wait(1.5)
func wait(seconds:float = 1.0):
	return get_tree().create_timer(seconds).timeout

func get_global_variable(key: String):
	if _global_vars.has(key):
		return _global_vars[key]
	else:
		push_warning("The key %s does not exist within the Global Variables" % key)

func set_global_variable(key: String, value) -> void:
	_global_vars[key] = value

func get_stock() -> Dictionary:
	return _stock

func get_stock_count(item: String) -> int:
	if _stock.has(item):
		return _stock[item]
	else:
		push_warning("The item %s does not exist within the stock" % item)
		return 0

func add_stock(item: String, value: int) -> void:
	if _stock.has(item):
		if _stock[item] == 999 or _stock[item] + value >= 999:
			pass
		else:
			_stock[item] += value
	else:
		_stock[item] = value
#endregion
