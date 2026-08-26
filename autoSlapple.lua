local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")

function inArena()
   if not plr.Character then
      task.wait(1)
      inArena()
      return
   end
   if not plr.Character:FindFirstChild("isInArena") or plr.Character.Humanoid.Health == 0 then
      task.wait(1)
      inArena()
      return
   end
   if not plr.Character:FindFirstChild("isInArena").Value and not plr.Backpack:FindFirstChildOfClass("Tool") then
      plr.Character:PivotTo(CFrame.new(-1210,330,4))
      task.wait(1)
       if not plr.Character:FindFirstChild("isInArena").Value and not plr.Backpack:FindFirstChildOfClass("Tool") then 
            inArena()
       end
   end
end

function Serverhop()
   task.spawn(function()
   while task.wait(3) do
      local servers = {}
      local req = game:HttpGet("https://games.roblox.com/v1/games/"..tostring(game.PlaceId).."/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
      local body = game:GetService("HttpService"):JSONDecode(req)
      if body and body.data then
         for i, v in next, body.data do
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
               table.insert(servers, 1, v.id)
            end
         end
      end 
      if #servers > 0 then
          print("не тот же сервер")
         game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game:GetService("Players").LocalPlayer)
      else
         print("тот же сервер")
         game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
      end
   end
end)
end



function CollectSlapple(obj)
      inArena()
      if obj:FindFirstChildOfClass("MeshPart").Transparency == 1 then return end
      plr.Character:PivotTo(obj:FindFirstChildOfClass("MeshPart").CFrame)
      plr.Character.HumanoidRootPart.Anchored = true
      task.wait(0.2)
      plr.Character.HumanoidRootPart.Anchored = false
      task.wait(0.5)
      if obj:FindFirstChildOfClass("MeshPart").Transparency == 0 then
         CollectSlapple(obj)
      end
end
function sborslapov()
   for i,slapple in pairs(game.Workspace.Arena.island5.Slapples:GetChildren()) do
     CollectSlapple(slapple)
   end
   plr.Character.HumanoidRootPart.Anchored = false
   task.wait(2)
   Serverhop()
end


sborslapov()
