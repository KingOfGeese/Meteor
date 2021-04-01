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
-- Include the graphic lib

local function Getserver()
    if (engine.GetServerIP() == "loopback") then return "127.0.0.1" 
    elseif (engine.GetServerIP() == nil) then return "Main Menu"
    else return engine.GetServerIP();        
    end
end
local function Round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function DrawWatermark() 
    local ScreenX, ScreenY = draw.GetScreenSize();
    local Localplayer, LocalplayerIndex, LocalplayerVALID = entities.GetLocalPlayer(), client.GetLocalPlayerIndex(), false;
    if (Localplayer ~= nil) then LocalplayerVALID = true; end

    local Latency = LocalplayerVALID and 
        tostring(entities.GetPlayerResources():GetPropInt("m_iPing", LocalplayerIndex)) 
        or "0";

    local Velocity = LocalplayerVALID and 
        Round(math.sqrt(Localplayer:GetPropFloat("localdata", "m_vecVelocity[0]") ^ 2 + Localplayer:GetPropFloat("localdata", "m_vecVelocity[1]") ^ 2), 0)
        or "0";

    local WatermarkSTRING = "Graphic Lib Demo | Velocity " .. Velocity .. " | Server " .. Getserver() .. " | Latency " .. Latency;
    local Width = Render:StringSize(WatermarkSTRING).width + 5; -- Leaving the font nil will make the lib use the default font...
    local X, Y = (ScreenX) - Width - 5, 5

    Render:GradientRectangle(X - 1, Y - 1, Width + 1, 22, false, Color.Pink, Color.Purple);
    Render:Rectangle(X, Y, Width, 20, 1, Color:New(15, 15, 15, 255));
    Render:String   (X + 2, Y + 5, WatermarkSTRING, true, false);
end
callbacks.Register("Draw", DrawWatermark);
