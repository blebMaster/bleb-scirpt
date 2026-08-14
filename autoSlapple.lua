local Players = game:GetService("Players")
local plr = Players.LocalPlayer

function inArena()
   if not plr.Character:FindFirstChild("isInArena").Value then
      plr.Character:PivotTo(CFrame.new(-1210,328,4))
      task.wait(1)
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
   plr.Character.HumanoidRootPart.Anchored = true
   for i,slapple in pairs(game.Workspace.Arena.island5.Slapples:GetChildren()) do
     CollectSlapple(slapple)
   end
   plr.Character.HumanoidRootPart.Anchored = false
end


sborslapov()
