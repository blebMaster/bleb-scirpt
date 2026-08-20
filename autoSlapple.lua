local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")

function inArena()
   if not plr.Character then
      task.wait(1)
      inArena()
      return
   end
   if not plr.Character:FindFirstChild("isInArena") then
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
function tp()
    
 local placeId = game.PlaceId
    local options = Instance.new("TeleportOptions")
    
    local success, result = pcall(function()
        return TeleportService:Teleport(placeId, plr, options)
    end)
    
    if not success then
        warn("Ошибка телепортации: " .. tostring(result))
    end
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
   tp()
end


sborslapov()
