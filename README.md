# Drawing API
Copy and paste this inside of your lua script at the first line.
```lua
local Library_INSTALLED = false;
local Library_REWRITE = false;
file.Enumerate(function(filename)
    if filename == "Libraries/RENDERLibrary.lua" then
        Library_REWRITE = true;
        Library_INSTALLED = true;
    end;
end)
if not Library_INSTALLED or Library_REWRITE then
    local body = http.Get("https://raw.githubusercontent.com/BigGoosie/Aimware-Libraries/main/Drawing-API-Refactored.lua");
    file.Write("Libraries/RENDERLibrary.lua", body);
end
RunScript("Libraries/RENDERLibrary.lua");
```
## Parameters
