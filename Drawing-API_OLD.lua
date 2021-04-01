-- https://github.com/BigGoosie/Aimware-Luas

Render = Render or {};
Render.Outline = function(X, Y, Width, Height, Colour) 
	draw.Color(Colour);
	draw.OutlinedRect(X, Y, X + Width, Y + Height);
end
Render.OutlineRounded = function(X, Y, Width, Height, Radius, Rounding, Colour)
	draw.Color(Colour);
	draw.RoundedRect(X, Y, X + Width, Y + Height, Radius, Rounding[1], Rounding[2], Rounding[3], Rounding[4]);
end
Render.OutlineCircle = function(X, Y, Radius, Colour)
    if (Colour == nil) then Colour = { 255, 255, 255, 255 }; end
 
    draw.Color(Colour[1], Colour[2], Colour[3], Colour[4]);
    draw.OutlinedCircle(X, Y, Radius);
end

Render.Rectangle = function(X, Y, Width, Height, Colour)
    if (Colour == nil) then Colour = {255, 255, 255, 255}; end

	draw.Color(Colour[1], Colour[2], Colour[3], Colour[4]);
	draw.FilledRect(X, Y, X + Width, Y + Height);
end
Render.RectangleShadow = function(X, Y, Width, Height, Radius, Colour)
    if (Colour == nil) then Colour = {255, 255, 255, 255}; end

	draw.Color(Colour[1], Colour[2], Colour[3], Colour[4]);
	draw.ShadowRect(X, Y, X + Width, Y + Height, Radius);
end
Render.RectangleRounded = function(X, Y, Width, Height, Radius, Rounding, Colour)
    if (Rounding == nil) then Rounding = {5, 5, 5, 5}; end
    if (Colour == nil) then Colour = {255, 255, 255, 255}; end

	draw.Color(Colour[1], Colour[2], Colour[3], Colour[4]);
    draw.RoundedRectFill(X, Y, X + Width, Y + Height, Radius, Rounding[1], Rounding[2], Rounding[3], Rounding[4]);
end

Render.Gradient = function(X, Y, Width, Height, Vertical, ColourStarting, ColourEnding)
	local R, G, B = ColourEnding[1], ColourEnding[2], ColourEnding[3];
	Render.Rectangle(X, Y, Width, Height, ColourStarting);

	if (Vertical == true) then
		for Index = 1, Height do
			local A = Index / Height * 255;
			Render.Rectangle(X, Y + Index, Width, 1, { R, G, B, A });
		end
	else 
		for Index = 1, Width do
			local A = Index / Width * 255;
			Render.Rectangle(X + Index, Y, 1, Height, { R, G, B, A });
		end
	end
end

local DefaultFONT = draw.CreateFont("verdana.ttf", 15, 100); 
Render.String = function(X, Y, String, Shadow, Centered, Colour, Font)
    local DrawingFONT = Font;
    local StringSIZE = draw.GetTextSize(String);
    if (Font == nil or DrawingFONT == nil) then Font = DefaultFONT end
    if (Shadow == nil) then Shadow = false; end if (Centered == nil) then Centered = false; end
    if (Colour == nil) then Colour = { 255, 255, 255, 255 }; end
 
    draw.Color(Colour[1], Colour[2], Colour[3], Colour[4]);
    draw.SetFont(DrawingFONT);

    if (Shadow == true and Centered == true) then
        draw.TextShadow(X - (StringSIZE / 2), Y, String);
    end
    if (Shadow == true and Centered == false) then
        draw.TextShadow(X, Y, String); 
    end
    if (Shadow == false and Centered == true) then
        draw.Text(X - (StringSIZE / 2), Y, String); 
    end
    if (Shadow == false and Centered == false) then
        draw.Text(X, Y, String);
    end
end

Render.Circle = function(X, Y, Radius, Colour)
    if (Colour == nil) then Colour = { 255, 255, 255, 255 }; end
 
    draw.Color(Colour[1], Colour[2], Colour[3], Colour[4]);
    draw.FilledCircle(X, Y, Radius);
end

Colours = Colours or {};

Colours.HexToRGBA = function(Hexcode)
    Hexcode = Hexcode:gsub("#","")
    return tonumber("0x".. Hexcode:sub(1,2)), tonumber("0x".. Hexcode:sub(3,4)), tonumber("0x".. Hexcode:sub(5,6)), tonumber("0x".. Hexcode:sub(7,8))
end

Colours.White = { 255, 255, 255, 255 };
Colours.Black = { 0, 0, 0, 255 };
Colours.Red = { 255, 0, 0, 255 };
Colours.Orange = { 255, 125, 0, 255 };
Colours.Green = { 0, 255, 0, 255 }; 
Colours.Blue = { 0, 0, 255, 255 };
Colours.Pink = { 255, 0, 255, 255 };
Colours.Purple = { 127, 0, 255, 255 };
