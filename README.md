# Drawing API
Copy and paste this inside of your lua script at the first line.
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
    local body = http.Get("https://raw.githubusercontent.com/BigGoosie/Aimware-Libraries/main/GraphicLib.lua");
    file.Write("Libraries/GraphicLib.lua", body);
end
RunScript("Libraries/GraphicLib.lua");
```
## Parameters
Rendering should be done through a context call, for example: `Render:Rectangle(Parameters)`
The self argument mustn't be passed as lua already does this using the contextual call.

### Render:Rectangle Parameters
`X`     : Top left corner's X coordinate.\
`Y`     : Top left corner's Y coordinate.\
`Width` : The width of the rectangle.\
`Height`: The height of the rectangle.\
`Type`  : The type of rectangle that will be drawn; 1 = Filled, 2 = Shadow, Others = The default outline.\
`Color` : The color object is created when using `Color:New(R, G, B, A)` Or `Color:NewFromHex(HEX)` Or `Color.White:Inbetween(Color.Black, 0.5)`.

### Render:RoundedRectangle Parameters
`X`       : Top left corner's X coordinate.\
`Y`       : Top left corner's Y coordinate.\
`Width`   : The width of the rounded rectangle.\
`Height`  : The height of the rounded rectangle.\
`Radius`  : How round the corners are.\
`Rounding`: Must be called like { Top Left Corner, Top Right Corner, Bottom Left Corner, Botton Right Corner }.\
`Filled`  : If the value is true then the rectangle will be filled instead of the default outline.\
`Color`   : The color object is created when using `Color:New(R, G, B, A)` Or `Color:NewFromHex(HEX)` Or `Color.White:Inbetween(Color.Black, 0.5)`.

### Render:GradientRectangle Parameters
`X`             : Top left corner's X coordinate.\
`Y`             : Top left corner's Y coordinate.\
`Width`         : The width of the rounded rectangle.\
`Height`        : The height of the rounded rectangle.\
`Vertical`      : The direction that the gradient is facing.\
`Color Starting`: The starting color object is created when using `Color:New(R, G, B, A)` Or `Color:NewFromHex(HEX)` Or `Color.White:Inbetween(Color.Black, 0.5)`.
`Color Ending`  : The ending color object is created when using `Color:New(R, G, B, A)` Or `Color:NewFromHex(HEX)` Or `Color.White:Inbetween(Color.Black, 0.5)`.\

### Render:Circle Parameters
`X`     : Center X coordinate.\
`Y`     : Center Y coordinate.\
`Radius`: The size / radius of the circle.\
`Filled`: If the value is true then the circle will be filled instead of the default outline.\
`Color` : The color object is created when using `Color:New(R, G, B, A)` Or `Color:NewFromHex(HEX)` Or `Color.White:Inbetween(Color.Black, 0.5)`.

### Render:Line Parameters
`X`     : Top left corner's X coordinate.\
`Y`     : Top left corner's Y coordinate.\
`Length`: How long the line will be.\
`Angle` : The angle of the line. An example: 0 will be straight whilst 180 will be down.\
`Color` : The color object is created when using `Color:New(R, G, B, A)` Or `Color:NewFromHex(HEX)` Or `Color.White:Inbetween(Color.Black, 0.5)`.

### Render:String Parameters
`X`       : Top left corner's X coordinate.\
`Y`       : Top left corner's Y coordinate.\
`String`  : How long the line will be.\
`Shadow`  : If the value is true then the text will have and outline instead of having no outline.\
`Centered`: Setting this will make the X and Y be the center of the text.\
`Font`    : If the value is true then the font will be applied to the text whilst if the font value is null then the font will be the default font.\
`Color`   : The color object is created when using `Color:New(R, G, B, A)` Or `Color:NewFromHex(HEX)` Or `Color.White:Inbetween(Color.Black, 0.5)`.

### Render:String Parameters
`String`: The string that will be calculated in size.\
`Font`  : If the value is null then the font will be replaced with the default font.

## View the WIKI For more
### The WIKI is still under construction. Please wait
