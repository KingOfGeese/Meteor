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
local SetX, SetY = false, false;

local WatermarkOUTLINE = Render.Rectangle:Create(0, 0, 100, 22);
local WatermarkBACKGROUND = Render.Rectangle:Create(0, 0, 100, 20);
local WatermarkSTRING = Render.String:Create(0, 0, "Something Went Really Wrong...");
local X, Y = 0, 0;

local function DrawWatermark() 
    local Localplayer, LocalplayerIndex, LocalplayerVALID = entities.GetLocalPlayer(), client.GetLocalPlayerIndex(), false;
    if (Localplayer ~= nil) then LocalplayerVALID = true; end

    local Latency = LocalplayerVALID and 
        tostring(entities.GetPlayerResources():GetPropInt("m_iPing", LocalplayerIndex)) 
        or "0";

    local Velocity = LocalplayerVALID and 
        Round(math.sqrt(Localplayer:GetPropFloat("localdata", "m_vecVelocity[0]") ^ 2 + Localplayer:GetPropFloat("localdata", "m_vecVelocity[1]") ^ 2), 0)
        or "0";

    local String2Calc = "Meteor LIB Example | Velocity " .. Velocity .. " | Server " .. Getserver() .. " | Latency " .. Latency;
    WatermarkSTRING.s = String2Calc;
    local StringSIZE = WatermarkSTRING:Size().width + 5;
    if (not SetX and not SetY) then
        X, Y = (ScreenX) - StringSIZE - 5, 5;
        SetX, SetY = true, true;
    end

    if (not WatermarkOUTLINE:IsClicked()) then 
        WatermarkOUTLINE.x = X - 1;
        WatermarkOUTLINE.y = Y - 1;
        WatermarkOUTLINE.w = StringSIZE + 1;
    
        WatermarkBACKGROUND.x = WatermarkOUTLINE.x + 1;
        WatermarkBACKGROUND.y = WatermarkOUTLINE.y + 1;
        WatermarkBACKGROUND.w = StringSIZE;
    
        WatermarkSTRING.x = WatermarkBACKGROUND.x + 2;
        WatermarkSTRING.y = WatermarkBACKGROUND.y + 5;
    else 
        X = WatermarkOUTLINE.x;
        Y = WatermarkOUTLINE.y;

        WatermarkBACKGROUND.x = WatermarkOUTLINE.x + 1;
        WatermarkBACKGROUND.y = WatermarkOUTLINE.y + 1;
        WatermarkBACKGROUND.w = StringSIZE;

        WatermarkSTRING.x = WatermarkBACKGROUND.x + 2;
        WatermarkSTRING.y = WatermarkBACKGROUND.y + 5;
    end

    WatermarkOUTLINE:Draw(5, { false --[[ Vertical or not ]] }, Color.Purple, Color.Blue);
    WatermarkBACKGROUND:Draw(1, { false --[[ No need for this but what ever ]] }, Color:New(15, 15, 15, 255));
    WatermarkSTRING:Draw(true, false); -- [[ Using no font / color will use the defaults... ]]

    WatermarkOUTLINE:HandleDrag(); -- Only need the drag for the gradient; due to it being the largest rectangle being drawn.
end
callbacks.Register("Draw", DrawWatermark);
