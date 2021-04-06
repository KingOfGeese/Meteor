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

local ScreenX, ScreenY = draw.GetScreenSize();

local WatermarkOUTLINE = Render.Rectangle:Create(0, 0, 100, 22);
local WatermarkBACKGROUND = Render.Rectangle:Create(0, 0, 100, 20);
local WatermarkSTRING = Render.String:Create(0, 0, "Something Went Really Wrong...");

local function DrawWatermark() 
    local Localplayer, LocalplayerIndex, LocalplayerVALID = entities.GetLocalPlayer(), client.GetLocalPlayerIndex(), false;
    if (Localplayer ~= nil) then LocalplayerVALID = true; end

    local Latency = LocalplayerVALID and 
        tostring(entities.GetPlayerResources():GetPropInt("m_iPing", LocalplayerIndex)) 
        or "0";

    local Velocity = LocalplayerVALID and 
        Round(math.sqrt(Localplayer:GetPropFloat("localdata", "m_vecVelocity[0]") ^ 2 + Localplayer:GetPropFloat("localdata", "m_vecVelocity[1]") ^ 2), 0)
        or "0";

    local col1 = Color:New(gui.GetValue("esp.visualTab.mainCol1"));
    local col2 = Color:New(gui.GetValue("esp.visualTab.mainCol2"));
    local String2Calc = "nxzUI v4 [DEV] | Velocity " .. Velocity .. " | Server " .. Getserver() .. " | Latency " .. Latency;
    WatermarkSTRING.s = String2Calc;
    local StringSIZE = WatermarkSTRING:Size().width + 5;
    local X, Y = (ScreenX) - StringSIZE - 5, 5

    WatermarkOUTLINE.x = X - 1;
    WatermarkOUTLINE.y = Y - 1;
    WatermarkOUTLINE.w = StringSIZE + 1;

    WatermarkBACKGROUND.x = X;
    WatermarkBACKGROUND.y = Y;
    WatermarkBACKGROUND.w = StringSIZE;

    WatermarkSTRING.x = X + 2;
    WatermarkSTRING.y = Y + 5;

    WatermarkOUTLINE:Draw(5, { false --[[ Vertical or not ]] }, col1, col2);
    WatermarkBACKGROUND:Draw(1, { false --[[ No need for this but what ever ]] }, Color:New(15, 15, 15, 255));
    WatermarkSTRING:Draw(true, false); -- [[ Using no font / color will use the defaults... ]]

    --[[
        WatermarkOUTLINE:HandleDrag();
        WatermarkBACKGROUND:HandleDrag();
        
    ]] -- Won't work because the x and y are always being redefined, will fix it on the 8th. I have planning shit to do; for the 7th
end
callbacks.Register("Draw", DrawWatermark);
