//var iamges = Array();
var gridSize = 24;
var ticksPerMove = 24;
var msPerTick = 42;
var textColor = "rgb(200,200,200)";
var textBackground = "rgb(0,0,0)";

function Game(g, ships)
{
	this.g = g;
	this.ships = ships;
	this.move = 0;
	this.tick = 0;	
}

Game.prototype.direction = {
	N: 0,
	NE: Math.PI/4,
	E: Math.PI/2,
	SE: 3*Math.PI/4,
	S: Math.PI,
	SW: 5*Math.PI/4,
	W: 3*Math.PI/2,
	NW: 7*Math.PI/4,
};

Game.prototype.reset = function()
{
	this.move = 0;
	this.tick = 0;
}

Game.prototype.drawFrame = function()
{
	this.animationEnd = true;
	if(this.tick != 0)
	{this.animationEnd = false;}
	
	this.drawMap();
	
	for(ship in this.ships)
	{
		if(this.ships[ship]['Moves'] && this.ships[ship]['Moves'][this.move])
		{
			this.animationEnd = false;
			this.animateShip(this.ships[ship])
		} else {
			this.drawShip(this.ships[ship]);
		}
	}
	
	this.tick++;
	if(this.tick > ticksPerMove)
	{
		this.tick = 0;
		this.move++;
	}
	
	if(!this.animationEnd)
	{
		var myThis = this;
		setTimeout(function() {myThis.drawFrame();}, msPerTick); 
	}
};

Game.prototype.drawMap = function()
{
	this.g.drawImage(images['Map'],0,0);

	this.g.fillStyle = "rgb(200,200,200)";
	for(var x = 0; x<32; x++)
	{
		for(var y = 0; y<32; y++)
		{
			this.g.beginPath();
			this.g.arc(x*24+12,y*24+12,2,0,2*Math.PI);
			this.g.fill();
		}
	}
};

Game.prototype.animateShip = function(ship)
{
	var image = images[ship['Type']];
	
	this.g.save();
	if(ship['Moves'] && ship['Moves'][this.move] && ship['Moves'][this.move]['Type'] == 'Move')
	{
		var dx = ship['Moves'][this.move]['X'] - ship['X'];
		var dy = ship['Moves'][this.move]['Y'] - ship['Y'];
		this.g.translate((ship['X'] + dx*(this.tick/ticksPerMove) + 0.5) * gridSize, 
						 (ship['Y'] + dy*(this.tick/ticksPerMove) + 0.5) * gridSize);
		if(this.tick == ticksPerMove)
		{
			ship['X'] = ship['Moves'][this.move]['X'];
			ship['Y'] = ship['Moves'][this.move]['Y'];
		}
	} else {
		this.g.translate((ship['X'] + 0.5) * gridSize, (ship['Y'] + 0.5) * gridSize);
	}
	
	this.g.fillStyle = textBackground;
	var info = this.g.measureText(ship['Name']);
	this.g.fillRect(-12, -20, info.width+4, 12);
	
	this.g.fillStyle = textColor;
	this.g.fillText(ship['Name'], -10, -10);
	
	if(ship['Moves'] && ship['Moves'][this.move] && ship['Moves'][this.move]['Type'] == 'Fire')
	{
		var dx = ship['Moves'][this.move]['X'] - ship['X'];
		var dy = ship['Moves'][this.move]['Y'] - ship['Y'];
		
		this.g.fillStyle = "rgb(255,0,0)";
		this.g.beginPath();
		this.g.arc(dx * (this.tick/ticksPerMove) * gridSize, dy * (this.tick/ticksPerMove) * gridSize, 2, 0, 2*Math.PI);
		this.g.fill();
	}
	
	if(ship['Moves'] && ship['Moves'][this.move] && ship['Moves'][this.move]['Type'] == 'Turn')
	{
		var dd = this.direction[ship['Moves'][this.move]['D']] - this.direction[ship['D']];
		if(dd>Math.PI)
		{ dd = dd - 2*Math.PI; }
		
		this.g.rotate(this.direction[ship['D']] + dd*(this.tick/ticksPerMove));
		if(this.tick == ticksPerMove)
		{
			ship['D'] = ship['Moves'][this.move]['D'];
		}
	} else {
		this.g.rotate(this.direction[ship['D']]);
	}
	this.g.drawImage(image,-image.width/2, -image.width/2);
	
	this.g.restore();
}

Game.prototype.drawShip = function(ship)
{
	var image = images[ship['Type']];
	
	this.g.save();
	
	this.g.translate((ship['X'] + 0.5) * gridSize, (ship['Y'] + 0.5) * gridSize);

	this.g.fillStyle = textBackground;
	var info = this.g.measureText(ship['Name']);
	this.g.fillRect(-12, -20, info.width+4, 12);

	this.g.fillStyle = textColor;	
	this.g.fillText(ship['Name'], -10, -10);
	
	this.g.rotate(this.direction[ship['D']]);
	this.g.drawImage(image,-image.width/2, -image.width/2);
	this.g.restore();
}
