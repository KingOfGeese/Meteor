# Introduction
Including the library so it has a use;
Copy this snipet of code
```lua
local Library_INSTALLED = false;
local Library_REWRITE = false;
file.Enumerate(function(filename)
    if filename == "Libraries/Meteor.lua" then
        Library_REWRITE = true;
        Library_INSTALLED = true;
    end;
end)
if not Library_INSTALLED or Library_REWRITE then
    local body = http.Get("https://raw.githubusercontent.com/BigGoosie/Meteor/main/Meteor.lua");
    file.Write("Libraries/Meteor.lua", body);
end
RunScript("Libraries/Meteor.lua");
```
Paste it on the first line; you will only need to do this once

### Want to learn how to code in this library? Well take a look at the wiki!
