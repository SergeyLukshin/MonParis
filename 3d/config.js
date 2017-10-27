	Config = {
		"item": {
			"allow360X":true,
			"interaction": "mousemove", // "drag"
			"impetus": "true", //"false"
			"containerSelector": ".pro360",
			"autoplay": {"interval": 100, "bounce": false},//frame timeout
			"folder":"/500px/",
			"zoomfolder":"/1000px/",
			"file": function(x,y) {	return pad(72 * y + x, 3) + ".jpg"},	//"000" slice(-3)	
			"type": "rect",
			"startX":1,
			"minX": 1,
			"maxX": 73,
			"startY":0,
			"minY": 0,
			"maxY": 5,
			"width": 320,
			"height": 320,
			"zoomfactor": 3
		}
	}
