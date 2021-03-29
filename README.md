# Drawing API
Using the Drawing API as a library
```lua
-- WIP Docs soon
```

Using it as a internal file
You will need to include the file via copy and pasting it inside of the file that is using the Drawing API
```lua
local Font = draw.CreateFont("Verdana", 15, 100);
local DrawingTEST = function()
    Render.Outline(0, 0, 15, 15, {255, 255, 255, 255});

    Render.Rectangle(0, 20, 15, 15, {255, 255, 255, 255});
    Render.RectangleShadow(20, 0, 15, 15, 10, {255, 255, 255, 255});
    Render.RectangleRounded(20, 20, 15, 15, 5, {5, 5, 5, 5}, {255, 255, 255, 255});

    Render.Gradient(40, 0, 15, 15, false, {255, 255, 255, 255}, {0, 0, 0, 0});

    Render.String(200, 100, "Not-Centered | No Shadow", false, false, {255, 255, 255, 255}, Font);
    Render.String(200, 200, "Not-Centered | Shadow", false, true, {255, 255, 255, 255}, Font);

    Render.String(200, 300, "Centered | No Shadow", true, false, {255, 255, 255, 255}, Font);
    Render.String(200, 400, "Centered | Shadow", true, true, {255, 255, 255, 255}, Font);
end
callbacks.Register("Draw", "DrawingTEST", DrawingTEST);
```
This is the correct way to use the Drawing API.
This is also the better way to maintain good FPS

```lua
local DrawingTEST = function()
    Render.Outline(0, 0, 15, 15, {255, 255, 255, 255});

    Render.Rectangle(0, 20, 15, 15, {255, 255, 255, 255});
    Render.RectangleShadow(20, 0, 15, 15, 10, {255, 255, 255, 255});
    Render.RectangleRounded(20, 20, 15, 15, 5, {5, 5, 5, 5}, {255, 255, 255, 255});

    Render.Gradient(40, 0, 15, 15, false, {255, 255, 255, 255}, {0, 0, 0, 0});

    Render.String(200, 100, "Not-Centered | No Shadow", false, false, {255, 255, 255, 255}, draw.CreateFont("Verdana", 15, 100));
    Render.String(200, 200, "Not-Centered | Shadow", false, true, {255, 255, 255, 255}, draw.CreateFont("Verdana", 15, 100));

    Render.String(200, 300, "Centered | No Shadow", true, false, {255, 255, 255, 255}, draw.CreateFont("Verdana", 15, 100));
    Render.String(200, 400, "Centered | Shadow", true, true, {255, 255, 255, 255}, draw.CreateFont("Verdana", 15, 100));
end
callbacks.Register("Draw", "DrawingTEST", DrawingTEST);
```
This is how you lose fps, re-defining the font will cause fps drops.

Its a really simple libray to use if you need anymore assistence please make a ticket.
