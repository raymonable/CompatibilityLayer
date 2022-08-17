# CompatibilityLayer
Work in progress compatibility script for executors

### How do I use it?

Here's an example that should help:
```lua
local Compatibility = loadstring(game:HttpGet("https://raw.githubusercontent.com/raymonable/CompatibilityLayer/main/compatibility.lua")).new()
Compatibility("print(getsynasset('test.png'))") -- Would work on every executor that supports workspace loading
```
