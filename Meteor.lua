-- https://github.com/BigGoosie/Meteor
-- Refer to the wiki if you want to learn; It will be hard to learn from the code considering its compact.

-- Private function to set the color with a failsafe.
local function SetColor(color)
    if (color == nil) then
        draw.Color(255, 255, 255, 255);
    else
        draw.Color(color.r, color.g, color.b, color.a);
    end
end

local function inArea(Mouse_X, Mouse_Y, Object_X, Object_Y, Object_Width, Object_Height) 
    if (Mouse_X >= Object_X and Mouse_X <= Object_Width) then 
        if (Mouse_Y >= Object_Y and Mouse_Y <= Object_Height) then 
            return true 
        else 
            return false 
        end 
    else 
        return false 
    end 
end

local function Area(x1, y1, x2, y2, x3, y3)
    return Math.abs((x1*(y2-y3) + x2*(y3-y1)+ x3*(y1-y2))/2.0);
end

-- Render function
Render = {
    -- #region Defaults
        DefaultFont = draw.CreateFont("verdana", 15, 100),
    -- #endregion Defaults

    -- #region Globals

    -- #endregion Globals

    -- #region Geometry

        Rectangle = {
            x = 0;
            y = 0;
            w = 0;
            h = 0;

            dragging_offsetx = 0;
            dragging_offsety = 0;
            dragging = false;
        
            Create = function(self, x, y, w, h)
                local o = {};
                setmetatable(o, self);
                self.__index = self;
        
                o.x = x;
                o.y = y;
                o.w = w;
                o.h = h;
        
                return o;
            end,

            Draw = function(self, type, additions, color, ending)
                SetColor(color);
                if (type == 1) then
                    draw.FilledRect(self.x, self.y, self.x + self.w, self.y + self.h); 
                elseif (type == 2) then
                    draw.ShadowRect(self.x, self.y, self.x + self.w, self.y + self.h, additions[1]); 
                elseif (type == 3) then
                    draw.RoundedRect(self.x, self.y, self.x + self.w, self.y + self.h, additions[1], additions[2], additions[3], additions[4], additions[5]);
                elseif (type == 4) then
                    draw.RoundedRectFill(self.x, self.y, self.x + self.w, self.y + self.h, additions[1], additions[2], additions[3], additions[4], additions[5]);
                elseif (type == 5) then 
                    local r, g, b = ending.r, ending.g, ending.b;
                    local width, height = self.x + self.w, self.y + self.h;
                    draw.FilledRect(self.x, self.y, width, height); 
                    
                    if (additions[1]) then
                        for i=1, self.h do
                            local a = i / self.h * 255;
                            SetColor({ r=r, g=g, b=b, a=a })
                            draw.FilledRect(self.x, self.y + i, width, self.y + i + 1); 
                        end
                    else 
                        for i=1, self.w do
                            local a = i / self.w * 255;
                            SetColor({ r=r, g=g, b=b, a=a })
                            draw.FilledRect(self.x + i, self.y, self.x + i + 1, self.y + self.h); 
                        end
                    end
                else
                    draw.OutlinedRect(self.x, self.y, self.x + self.w, self.y + self.h); 
                end
            end,
        
            IsClicked = function(self)
                local mousex, mousey = input.GetMousePos(); 
                if (inArea(mousex, mousey, self.x, self.y, self.x + self.w, self.y + self.h) and input.IsButtonDown(1)) then
                    return true;
                else 
                    return false;
                end
            end,
            IsHovered = function(self)
                local mousex, mousey = input.GetMousePos(); 
                if (inArea(mousex, mousey, self.x, self.y, self.x + self.w, self.y + self.h)) then
                    return true;
                else 
                    return false;
                end
            end,
            HandleDrag = function(self)
                local mousex, mousey = input.GetMousePos(); 

                if (self.dragging and not input.IsButtonDown(1)) then
                    self.dragging = false;
                    self.dragging_offsetx = 0;
                    self.dragging_offsety = 0;
                end     

                if (self.dragging == true) then
                    self.x = mousex - self.dragging_offsetx;
                    self.y = mousey - self.dragging_offsety;
                    return;
                end
    
                if (inArea(mousex, mousey, self.x, self.y, self.x + self.w, self.y + self.h) and input.IsButtonDown(1)) then
                    self.dragging = true;
                    self.dragging_offsetx = mousex - self.x;
                    self.dragging_offsety = mousey - self.y;
                    return;
                end
            end,
        },

        Circle = {
            x = 0;
            y = 0;
            r = 0;

            dragging_offsetx = 0;
            dragging_offsety = 0;
            dragging = false;
        
            Create = function(self, x, y, r)
                local o = {};
                setmetatable(o, self);
                self.__index = self;
        
                o.x = x;
                o.y = y;
                o.r = r;
        
                return o;
            end,

            Draw = function(self, filled, color)
                SetColor(color);
                if (filled) then
                    draw.FilledCircle(self.x, self.y, self.r); 
                else
                    draw.OutlinedCircle(self.x, self.y, self.r); 
                end
            end,

            IsClicked = function(self)
                local dist = math.sqrt((self.x - mousex)^2 + (self.y - mousey)^2);

                if (math.abs(dist) <= self.r and input.IsButtonDown(1)) then
                    return true;
                else 
                    return false;
                end
            end,
            IsHovered = function(self) 
                local dist = math.sqrt((self.x - mousex)^2 + (self.y - mousey)^2);

                if (math.abs(dist) <= self.r) then
                    return true;
                else 
                    return false;
                end
            end,
            HandleDrag = function(self)
                local mousex, mousey = input.GetMousePos(); 

                local dist = math.sqrt((self.x - mousex)^2 + (self.y - mousey)^2);
                
                if (self.dragging and not input.IsButtonDown(1)) then
                    self.dragging = false;
                    self.dragging_offsetx = 0;
                    self.dragging_offsety = 0;
                end     

                if (self.dragging == true) then
                    self.x = mousex - self.dragging_offsetx;
                    self.y = mousey - self.dragging_offsety;
                    return;
                end

                if (math.abs(dist) <= self.r and input.IsButtonDown(1)) then
                    self.dragging = true;
                    self.dragging_offsetx = mousex - self.x;
                    self.dragging_offsety = mousey - self.y;
                    return;
                end
            end,
        },

        Triangle = {
            x = 0;
            y = 0;
            x1 = 0;
            y1 = 0;
            x2 = 0;
            y2 = 0;

            dragging_offsetx = 0;
            dragging_offsety = 0;
            dragging = false;
        
            Create = function(self, x, y, x1, y1, x2, y2)
                local o = {};
                setmetatable(o, self);
                self.__index = self;
        
                o.x = x;
                o.y = y;
                o.x1 = x1;
                o.y1 = y1;
                o.x2 = x2;
                o.y2 = y2;
        
                return o;
            end,

            Draw = function(self, color)
                SetColor(color);
                draw.Triangle(self.x, self.y, self.x1, self.y1, self.x2, self.y2); 
            end,

            --[[HandleDrag = function(self)
                local CenterX = (self.x + self.x1 + self.x3) / 3;
                local CenterY = (self.y + self.y1 + self.y3) / 3;

                local Area1 = Area(CenterX, CenterY, self.x1, self.y1, self.x2, self.y2);
                local Area2 = Area(CenterX, CenterY, self.x1, self.y1, self.x2, self.y2);
                local Area3 = Area(self.x, self.y, CenterX, CenterY, self.x2, self.y2);
                local Area4 = Area(self.x, self.y, self.x1, self.y1, CenterX, CenterY);
            end,]]
        },

        Line = {
            x = 0;
            y = 0;
            l = 0;
            a = 0;

            dragging_offsetx = 0;
            dragging_offsety = 0;
            dragging = false;
        
            Create = function(self, x, y, l, a)
                local o = {};
                setmetatable(o, self);
                self.__index = self;
        
                o.x = x;
                o.y = y;
                o.l = l;
                o.a = a;
        
                return o;
            end,

            Draw = function(self, color)
                SetColor(color);
                draw.Line(self.x, self.y, self.x + self.l, self.y + self.a); 
            end,
        },

        String = {
            x = 0;
            y = 0;
            s = 0;

            dragging_offsetx = 0;
            dragging_offsety = 0;
            dragging = false;
        
            Create = function(self, x, y, s)
                local o = {};
                setmetatable(o, self);
                self.__index = self;
        
                o.x = x;
                o.y = y;
                o.s = s;
        
                return o;
            end,

            Size = function(self, s, font)
                draw.SetFont(font ~= nil and font or Render.DefaultFont);
                local x, y = draw.GetTextSize(s ~= nil and s or self.s);
                return { width = x, height = y };
            end,

            Draw = function(self, shadow, centered, font, color)
                SetColor(color);
                draw.SetFont(font ~= nil and font or Render.DefaultFont);
                local stringSizeX, stringSizeY = draw.GetTextSize(self.s);
                shadowed = shadowed ~= nil and shadowed or false;
                centered = centered ~= nil and centered or false;

                if (centered) then
                    if (shadowed) then
                        draw.TextShadow(self.x - (stringSizeX * 0.5), y, self.s);
                    else
                        draw.Text(self.x - (stringSizeX * 0.5), y, self.s);
                    end
                else
                    if (shadowed) then
                        draw.TextShadow(self.x, self.y, self.s);
                    else
                        draw.Text(self.x, self.y, self.s); 
                    end
                end
            end,
        },

    -- #endregion Geometry
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
