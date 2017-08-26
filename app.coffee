# Import file "framer-budget"
sketch = Framer.Importer.load("imported/framer-budget@2x", scale: 1)
Utils.globalLayers sketch

Framer.Extras.Hints.enable()
Framer.Device.deviceType = "apple-iphone-7-plus-silver"
layerA = new BackgroundLayer
	backgroundColor: "rgba(255,255,255,0)"


flow = new FlowComponent
flow.footer = nav
flow.header = header
flow.showNext(home_screen)

budget.onTap ->
	flow.showNext(budget_screen)

flow.scroll.contentInset =
	bottom: 0

button_add.z = 9999
food_expanded.opacity = 0
budget_charts.x = 500
linked_accounts.x = 500

# Create circle indicators
circleParent = new Layer
	parent: budget_bg
	backgroundColor: null
	x: 174

layers = []
for i in [1..3]
	circle = layers[i] = new Layer
		size: 10
		borderRadius: 5
		backgroundColor: "#D8D8D8"
		x: i * 16
		z: 999
		y: 328
		parent: circleParent
		name: "circle#{i}"

layers[1].backgroundColor = "#81B532"

# Default time for animations
animateTime = 0.15

# Animate a layer's height
animateHeight = (layer, heightY) ->
	layer.animate
		height: layer.height + heightY
		options:
			time: animateTime

# Animate a layer's Y position
animateY = (layer, layerY) ->
	layer.animate
		y: layer.y + layerY
		options:
			time: animateTime

# Animate a layer's opacity
animateOpacity = (layer, layerOpacity) ->
	layer.animate
		opacity: layer.opacity + layerOpacity
		options:
			time: animateTime - .05

# Animate a layer's x position
animateX = (layer, layerX) ->
	layer.animate
		x: layer.x + layerX
		options:
			time: animateTime + .2

# Animate a layer's width
animateWidth = (layer, layerWidth) ->
	layer.animate
		width: layer.width + layerWidth
		options:
			time: animateTime + 0.6
			delay: 0.15

# Food row event handler
food.onTap ->
	animateHeight(budget_bg, 108)
	animateY(budget_lower, 100)
	animateY(food_divider, 100)
	animateOpacity(food_expanded, 1)
	for i in layers[1..3]
		animateY(i, 102)
	
	if budget_bg.height > 400
		animateHeight(budget_bg, -108)
		animateY(budget_lower, -100)
		animateY(food_divider, -100)
		animateOpacity(food_expanded, -1)
		for i in layers[1..3]
			animateY(i, -102)

budget_bg.onSwipeLeftEnd ->
	if budget_content.x < 0
		layers[2].backgroundColor = "#D8D8D8"
		layers[3].backgroundColor = "#81B532"
		animateX(budget_charts, -400)
		animateX(linked_accounts, -480)

	else
		layers[1].backgroundColor = "#D8D8D8"
		layers[2].backgroundColor = "#81B532"
		animateX(budget_charts, -480)
		animateX(budget_content, -400)
		animateWidth(line_one_progress, 200)
		animateWidth(line_two_progress, 240)
		animateWidth(line_three_progress, 130)