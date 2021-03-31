-- https://github.com/BigGoosie/Aimware-Luas

-- Private function to set the color with a failsafe.
local function SetColor(color)
    if (color == nil) then
        draw.Color(255, 255, 255, 255);
    else
        draw.Color(color.r, color.g, color.b, color.a);
    end
end

-- Render function
Render = {
    -- Default font
    DefaultFont = draw.CreateFont("verdana", 15, 100),

    --#region Geometry

    -- Draws a rectangle.
    -- Available types: 1 = Filled, 2 = Shadowed, others = Default
    Rectangle = function(self, x, y, width, height, type, color)
        SetColor(color);

        if (type == 1) then
            draw.FilledRect(x, y, x+width, y+height);
        elseif (type == 2) then
            draw.ShadowRect(x, y, x+width, y+height);
        else
            draw.OutlinedRect(x, y, x+width, y+height);
        end
    end,

    -- Draws a rounded rectangle.
    -- Takes radius and a 4 length table with rounding values.
    RoundedRectangle = function(self, x, y, width, height, radius, rounding, filled, color)
        if (rounding == nil) then rounding = {5, 5, 5, 5}; end
        SetColor(color);

        if (not filled) then
            draw.RoundedRect(x, y, x+width, y+height, radius, rounding[1], rounding[2], rounding[3], rounding[4]);
        else
            draw.RoundedRectFill(x, y, x+width, y+height, radius, rounding[1], rounding[2], rounding[3], rounding[4]);
        end
    end,

    -- Draws a gradient rectangle, can be vertically gradiented.
    GradientRectangle = function(self, x, y, width, height, vertical, colorStart, colorEnd)
        local r, g, b = colorEnd.r, colorEnd.g, colorEnd.b;
        self:Rectangle(x, y, width, height, colorStart);

        if (vertical) then
            for i=1, height do
                local a = i / height * 255;
                self:Rectangle(x, y + i, width, 1, {r=r, g=g, b=b, a=a})
            end
        else
            for i=1, width do
                local a = i / width * 255;
                self:Rectangle(x + i, y, 1, height, {r=r, g=g, b=b, a=a})
            end
        end
    end,

    -- Draws a circle.
    Circle = function(self, x, y, radius, filled, color)
        SetColor(color);

        if (filled) then
            draw.FilledCircle(x, y, radius);
        else
            draw.OutlinedCircle(x, y, radius);
        end
    end,

    --#endregion Geometry

    --#region Other

    String = function(self, x, y, string, shadowed, centered, font, color)
        SetColor(color);
        draw.SetFont(font ~= nil and font or self.DefaultFont);
        local stringSizeX, stringSizeY = draw.GetTextSize();

        shadowed = shadowed ~= nil and shadowed or false;
        centered = centered ~= nil and centered or false;

        if (centered) then
            if (shadowed) then
                draw.TextShadow(x - (stringSizeX * 0.5), y - (stringSizeY * 0.5), string)
            else
                draw.Text(x - (stringSizeX * 0.5), y - (stringSizeY * 0.5), string)
            end
        else
            if (shadowed) then
                draw.TextShadow(x, y, string)
            else
                draw.Text(x, y, string)
            end
        end
    end

    --#endregion Other
}

-- Color struct definition.
Color = {
    r=0,
    g=0,
    b=0,
    a=0,

    -- Create a new color from RGBA values.
    New = function(self, r, g, b, a)
        local newColor = {};
        setmetatable(newColor, self);
        self.__index = self;
        newColor.r = r;
        newColor.g = g;
        newColor.b = b;
        newColor.a = a;
        return newColor;
    end,

    -- Create a new color from a hex string.
    NewFromHex = function(self, hexcode)
        hexcode = hexcode:gsub("#","")
        hexcode = hexcode:gsub("0x","")
        local r = tonumber("0x".. hexcode:sub(1,2));
        local g = tonumber("0x".. hexcode:sub(3,4));
        local b = tonumber("0x".. hexcode:sub(5,6));
        local a = tonumber("0x".. hexcode:sub(7,8));
        return self:New(r, g, b, a);
    end,

    -- Get color inbetween two colors based on percentage from 0-1.
    Inbetween = function(self, color, percent)
        if percent > 1 then
            percent = 1;
        elseif percent < 0 then
            percent = 0;
        end

        local newColor = self:New(0, 0, 0, 0);
        newColor.r = self.r-(self.r-color.r)*percent;
        newColor.g = self.g-(self.g-color.g)*percent;
        newColor.b = self.b-(self.b-color.b)*percent;
        newColor.a = self.a-(self.a-color.a)*percent;
        return newColor;
    end
}

-- Default color definitions.
Color.White = Color:New(255, 255, 255, 255);
Color.Black = Color:New(0, 0, 0, 255);
Color.Red = Color:New(255, 0, 0, 255);
Color.Orange = Color:New(255, 125, 0, 255);
Color.Green = Color:New(0, 255, 0, 255);
Color.Blue = Color:New(0, 0, 255, 255);
Color.Pink = Color:New(255, 0, 255, 255);
Color.Purple = Color:New(127, 0, 255, 255);