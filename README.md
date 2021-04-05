# Introduction
Including the library so it has a use;
Copy this snipet of code
```lua
local Library_INSTALLED = false;
local Library_REWRITE = false;
file.Enumerate(function(filename)
    if filename == "Libraries/GraphicLib.lua" then
        Library_REWRITE = true;
        Library_INSTALLED = true;
    end;
end)
if not Library_INSTALLED or Library_REWRITE then
    local body = http.Get("https://raw.githubusercontent.com/BigGoosie/Aimware-GraphicLib/main/GraphicLib.lua");
    file.Write("Libraries/GraphicLib.lua", body);
end
RunScript("Libraries/GraphicLib.lua");
```
Paste it on the first line; you will only need to do this once

## Rendering
In order to render something you will need to define it like:
```lua
local Rectangle = Render.Rectangle:Create(x, y, w, h);
callbacks.Register("Draw", function()
    --[[
        -- Type 1 = Filled Rectangle
        -- Type 2 = Shadow Rectangle
        -- Type 3 = Rounded Outline Rectangle
        -- Type 4 = Rounded Rectangle
        -- Type 5 = Gradient Rectangle
        -- Any other values = Outline Rectangle
        
        -- When using a type 1 rectangle you can set additions = nil or even additions = {};
        
        -- When using a type 2 rectangle it requires 
        -- additions in this format { radius };
        
        -- When using a type 3 or 4 rectangle it requires
        -- additions in this format { radius, TopLeft, TopRight, BottomLeft, BottomRight };
        
        -- When using a type 5 rectangle it requires
        -- additions in this format { vertical } and you must add a ending color;
    ]]
    
    Rectangle:Draw( type (0-5), additions, color, ending (gradient) );
end)
```
