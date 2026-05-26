getgenv().RAYFIELD_SECURE = true
getgenv().RAYFIELD_ASSET_ID = 138361542409015


--Создание ГУИ
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
   Name = "BLEBIK SCRIPT",
   LoadingTitle = "blebik script",
   LoadingSubtitle = "made by blebik",
   ConfigurationSaving = { Enabled = false },
   Theme = "Ocean"
})
Rayfield:Notify({
   Title = "BLEBIK SCRIPT",
   Duration = 2
})


--Табы
local MovementTab = Window:CreateTab("Movement 😎")
local SBTab = Window:CreateTab("Slap Battles 👍")
local MiscTab = Window:CreateTab("Other")
local SRTab = Window:CreateTab("Slap Royale")
local RivalsTab = Window:CreateTab("Rivals")
--Сервисы
local input = game:GetService("UserInputService")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local char = plr.Character
local Mouse = plr:GetMouse()
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
--Переменные
local selectedPlayer = nil
local platform = false
local targetCD = false
local autoFlick = false
local esp = false
local notify = false
local EspUpdCd = 3
local triggerBot = false
local onlyHeads = false
local HandCD = false
local AIM_ASSIST_RANGE = 250
local AIM_ASSIST_FOV = 360
local SMOOTHNESS = 1   -- чем меньше — тем сильнее
local items = {
    ["Bomb"] = Color3.fromRGB(26, 25, 25), 
    ["Bull's essence"] = Color3.fromRGB(77, 29, 0), 
    ["True Power"] = Color3.fromRGB(168, 12, 12),
    ["Potion of Strength"] = Color3.fromRGB(156, 23, 3), 
    ["Frog Potion"] = Color3.fromRGB(3, 72, 156), 
    ["Bandage"] = Color3.fromRGB(247, 89, 89),
    ["Lightining Potion"] = Color3.fromRGB(255, 255, 61),
    ["Speed Potion"] = Color3.fromRGB(255, 255, 61),
    ["Gravitation Shard"] = Color3.fromRGB(107, 16, 130),
    ["Boba"] = Color3.fromRGB(255, 211, 189),
    ["Apple"] = Color3.fromRGB(66, 245, 138),
    ["Forcefield Crystal"] = Color3.fromRGB(16, 107, 98),
    ["Sphere of fury"] = Color3.fromRGB(189, 66, 0),
    ["First Aid Kit"] = Color3.fromRGB(30, 247, 59),
    ["Cube of Ice"] = Color3.fromRGB(19, 240, 232),
    ["Tomahawk"] = Color3.fromRGB(109, 115, 115),
    ["Healing Potion"] = Color3.fromRGB(240, 98, 221),

}
local aimAssist = false
local youInRagdoll = false
local targetName =  nil
local ignorePlayers = {}
local skipFlick = false
local SlapAuraHitbox = 25
local codes = {
   ["http://www.roblox.com/asset/?id=9648755440"] = "8", --1
   ["http://www.roblox.com/asset/?id=9648765536"] = "2", --2
   ["http://www.roblox.com/asset/?id=9648723237"] = "3",--3
   ["http://www.roblox.com/asset/?id=9648718450"] = "6",--4
   ["http://www.roblox.com/asset/?id=9648769161"] = "4",--5
   ["http://www.roblox.com/asset/?id=9648730082"] = "6",--6
   ["http://www.roblox.com/asset/?id=9648734698"] = "2",--7
   ["http://www.roblox.com/asset/?id=9648712563"] = "2",--8
   ["http://www.roblox.com/asset/?id=9648742013"] = "7",--9
   ["http://www.roblox.com/asset/?id=9648745618"] = "3",--10
   ["http://www.roblox.com/asset/?id=9648715920"] = "6",--11
   ["http://www.roblox.com/asset/?id=9648752438"] = "2",--12
   ["http://www.roblox.com/asset/?id=9648749145"] = "8",--13
   ["http://www.roblox.com/asset/?id=9648759883"] = "9",--14
   ["http://www.roblox.com/asset/?id=9648738553"] = "8",--15
    
}
local ItemESP = false
local camera = Workspace.CurrentCamera
local function getPlayers()
   local t={}
   for _,v in pairs(Players:GetPlayers()) do
      if v~=lp then table.insert(t,v.Name) end
   end
   return t
end

if game.Workspace:FindFirstChild("Shipments") then
local CratesService = game.Workspace.Shipments.Crates
CratesService.ChildAdded:Connect(function(object)
      local highlight = Instance.new("Highlight")
      highlight.OutlineColor = Color3.fromRGB(181, 63, 5)
      highlight.FillColor = Color3.fromRGB(59, 20, 1)
      highlight.Parent = object    
end)
local MeteorService = game.Workspace.Shipments.Instances
MeteorService.ChildAdded:Connect(function(object)
   Rayfield:Notify({
   Title = "METEOR SPAWNED",
   Content="где то появился метеорит",
   Duration = 5
   })
   local highlight2 = Instance.new("Highlight")
   highlight2.OutlineColor = Color3.fromRGB(181, 63, 5)
   highlight2.FillColor = Color3.fromRGB(59, 20, 1)
   highlight2.Parent = object
end)
end

if game.Workspace:FindFirstChild("Items") then
local ItemService = game.Workspace.Items
ItemService.ChildAdded:Connect(function(object)
   if ItemESP then
      local color = items[object.Name]
      if not object:FindFirstChild("Highlight") then
         if not color then
            color = Color3.fromRGB(168, 12, 12) 
         end
         local highlight = Instance.new("Highlight")
         highlight.OutlineColor = color
         highlight.FillColor = color
         highlight.FillTransparency = 0.3
         highlight.Parent = object
         if not object:FindFirstChild("ItemESP") then
             local billboard = Instance.new("BillboardGui")
         billboard.Name = "ItemESP"
         billboard.Parent = object
         billboard.Size = UDim2.new(0, 200, 0, 50)
         billboard.StudsOffset = Vector3.new(0, 2, 0)
         billboard.AlwaysOnTop = true

         local label = Instance.new("TextLabel")
         label.Parent = billboard
         label.Size = UDim2.new(1, 0, 1, 0)
         label.BackgroundTransparency = 1

         label.Text = object.Name
         label.TextColor3 = color
         label.TextStrokeTransparency = 0
         label.TextScaled = false
         label.TextSize = 18
         label.Font = Enum.Font.SourceSansBold
         end
      end   
   end   
      if notify then
      Rayfield:Notify({
      Title = "ITEM SPAWNED",
      Content = object.Name.. " has spawned",
      Duration = 1
      })
      end  
end)
end





local Dropdown = MiscTab:CreateDropdown({
   Name="Select Player",
   Options=getPlayers(),
   Callback=function(opt)
      local name = typeof(opt)=="table" and opt[1] or opt
      targetName = name
   end
})

MiscTab:CreateButton({
   Name="Refresh 🔄",
   Callback=function()
      Dropdown:Refresh(getPlayers())
   end
})

MiscTab:CreateButton({
   Name="tool's childs",
   Callback=function()
      local obj = plr.Character:FindFirstChildOfClass("Tool")
      for i,v in pairs(obj:GetChildren()) do
         print("name: " .. v.Name)
         print("type:".. v.ClassName)
      end
   end
})


MiscTab:CreateToggle({
   Name="Tp player",
   CurrentValue=false,
   Callback=function(v)
      if v then
         if Players:FindFirstChild(targetName).Character then
            local anotherChar = Players:FindFirstChild(targetName).Character
            savepos = plr.Character:FindFirstChild("Right Arm").Position
            plr.Character:FindFirstChild("Right Arm").Position = anotherChar.HumanoidRootPart.Position
            print(plr.Character:FindFirstChild("Right Arm").Position)
         end
      else
         if savepos then
            plr.Character:FindFirstChild("Right Arm").Position = savepos
            savepos = nil
         else
         plr.Character:FindFirstChild("Right Arm").Position = plr.Character.Torso.Position
         end
      end
   end
})


--Функции В ГУИ
MovementTab:CreateSlider({
   Name = "Speed",
   Range = {10, 50},
   Increment = 1,
   CurrentValue = 20,
   Callback = function(v)
      local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
      if hum then hum.WalkSpeed = v end
   end,
})
MovementTab:CreateButton({
   Name="+1 Speed",
   Callback=function()
        addSpeed()
   end
})
MovementTab:CreateToggle({
   Name = "NoClip 👻",
   CurrentValue = false,
   Callback = function(v)
      _G.noclip = v
      game:GetService("RunService").Stepped:Connect(function()
         if _G.noclip and plr.Character then
            for _,p in pairs(plr.Character:GetDescendants()) do
               if p:IsA("BasePart") then p.CanCollide=false end
            end
         end
      end)
   end,
})
MovementTab:CreateButton({
   Name="-1 Speed",
   Callback=function()
        remSpeed()
   end
})



SBTab:CreateToggle({
   Name="ESP",
   CurrentValue=false,
   Callback=function(a)
      esp = a
      for _,v in pairs(Players:GetPlayers()) do
         if v~=plr and v.Character then
            if esp then
               if not v.Character:FindFirstChild("Highlight") then
                  Instance.new("Highlight",v.Character)
               end
            else
               local h=v.Character:FindFirstChild("Highlight")
               if h then h:Destroy() end
            end
         end
      end
   end
})
SBTab:CreateSlider({
   Name = "Esp Update Cooldown ",
   Range = {1, 20},
   Increment = 1,
   CurrentValue = 10,
   Callback = function(v)
      EspUpdCd = v
   end,
})
SBTab:CreateToggle({
   Name="AntiVoid Platform ",
   CurrentValue=false,
   Callback=function(v)
      if not v then
            local p = game.Workspace:FindFirstChild("plat")
            if p then
            p:Destroy()
            end
        else
        local plat = Instance.new("Part")
            plat.Position = Vector3.new(0,-15,0)
            plat.Size = Vector3.new(2000,0.5,2000)
            plat.CanCollide = true
            plat.Anchored = true
            plat.Transparency = 0.5
            plat.Parent = game.Workspace
            plat.Name = "plat"
        end    
   end
})





SBTab:CreateButton({
   Name="Tp to Center of Map",
   Callback=function()
        tp()
   end
})


MiscTab:CreateButton({
   Name="Character",
   Callback=function()
        for i,v in pairs(plr.Character:GetChildren()) do
         print("Name: "..v.Name) 
        end
   end
})





SBTab:CreateToggle({
   Name="AutoFlick ",
   CurrentValue=false,
   Callback=function(v)
       autoFlick = not autoFlick
   end
})

SRTab:CreateToggle({
   Name="Item ESP",
   CurrentValue=false,
   Callback=function(a)
      ItemESP = a
      ItemESPFunc(ItemESP)
   end
})
SRTab:CreateButton({
   Name="spiderMan",
   Callback=function()
       local stairs = game.Workspace.Map.FiestaFarm.Model
       local hrp = plr.Character.HumanoidRootPart
       stairs:PivotTo(hrp.CFrame * CFrame.new(0, 0, -5))
   end
})

SRTab:CreateButton({
   Name="Tp Code",
   Callback=function()
      game.Workspace.Map.CodeBrick.Position = plr.Character.HumanoidRootPart.Position
   end
})
SRTab:CreateButton({
   Name="Auto Code",
   Callback=function()
      Rayfield:Notify({
   Title ="Code",
   Content=AutoCode(),
   Duration = 5
})
   end
})
SRTab:CreateToggle({
   Name="Notify ",
   CurrentValue=false,
   Callback=function(v)
       notify = v
   end
})

SRTab:CreateToggle({
   Name="Auto Slap ",
   CurrentValue=false,
   Callback=function(v)
       if v then
         setupCharacter()
      else
         if plr.Character:FindFirstChild("ItemDetector") then
         plr.Character.ItemDetector:Destroy()
         end
      end
   end
})

SRTab:CreateToggle({
   Name="Auto Slap 1.1 ",
   CurrentValue=false,
   Callback=function(v)
      if v then
         setupCharacter2()
      else
         if plr.Character:FindFirstChild("ItemDetector") then
         plr.Character.ItemDetector:Destroy()
         end
      end
   end
})


SRTab:CreateToggle({
   Name="Slap Aura ",
   CurrentValue=false,
   Callback=function(v)
      if v then
         setupCharacter3()
      else
         if plr.Character:FindFirstChild("ItemDetector") then
         plr.Character.ItemDetector:Destroy()
         end
      end
   end
})


SRTab:CreateSlider({
   Name = "Slap Aura Hitbox",
   Range = {10, 50},
   Increment = 1,
   CurrentValue = 25,
   Callback = function(v)
      if plr.Character:FindFirstChild("ItemDetector") then
         plr.Character.ItemDetector.Size = Vector3.new(v, 5, v)
      end
   end,
})

SRTab:CreateToggle({ 
   Name="Skip Flick ",
   CurrentValue=false,
   Callback=function(v)
       skipFlick = v
   end
})

RivalsTab:CreateToggle({
   Name="Triger Bot",
   CurrentValue=false,
   Callback=function(a)
      triggerBot = a
   end
})

RivalsTab:CreateToggle({
   Name="Aim Assist",
   CurrentValue=false,
   Callback=function(a)
      aimAssist = a
   end
})
RivalsTab:CreateToggle({
   Name="Only heads",
   CurrentValue=false,
   Callback=function(a)
      onlyHeads = a
   end
})


--Функции

function setupCharacter()
local hrp = plr.Character:WaitForChild("HumanoidRootPart")
local detector = Instance.new("Part")
detector.Name = "ItemDetector"
detector.Size = Vector3.new(11, 5, 11)
detector.Transparency = 0.8
detector.CanCollide = false
detector.Anchored = false
detector.Massless = true
detector.Parent = plr.Character
detector.CFrame = hrp.CFrame
local weld = Instance.new("Weld")
weld.Part0 = detector
weld.Part1 = hrp
weld.Parent = detector
   detector.Touched:Connect(function(hit)
       if not hit.Parent:FindFirstChildOfClass("Humanoid") or hit.Parent.Name == "Crate" or hit.ClassName == "Tool" then return end
         if ignorePlayers[hit.Parent] or youInRagdoll then return end
         if plr.Character:FindFirstChild("FakePart Right Arm") then youInragdoll() return end
         if hit.Parent:FindFirstChild("FakePart Right Arm")  then addToIgnore(hit.Parent) return end
         if targetCD == true or not toolActivate() then return end
         if not skipFlick then
         task.wait(0.1)
         end
         local root = plr.Character:FindFirstChild("HumanoidRootPart")
         plr.Character.Humanoid.AutoRotate = false
         local targetRoot = hit.Parent:FindFirstChild("Head")
         if not root or not targetRoot then return end
         root.CFrame = CFrame.new(root.Position, Vector3.new(targetRoot.Position.X, root.Position.Y, targetRoot.Position.Z))
         targetCD = true
         task.wait(0.2)
         plr.Character.Humanoid.AutoRotate = true
         task.wait(0.7)
         targetCD = false
   end)
end



function setupCharacter2()
local hrp = plr.Character:WaitForChild("HumanoidRootPart")
local detector = Instance.new("Part")
detector.Name = "ItemDetector"
detector.Size = Vector3.new(11, 5, 11)
detector.Transparency = 0.7
detector.CanCollide = false
detector.Anchored = false
detector.Massless = true
detector.Parent = plr.Character
detector.CFrame = hrp.CFrame
local weld = Instance.new("Weld")
weld.Part0 = detector
weld.Part1 = hrp
weld.Parent = detector
   detector.Touched:Connect(function(hit)
       slap(hit)
   end)
end


function setupCharacter3()
local hrp = plr.Character:WaitForChild("HumanoidRootPart")
local detector = Instance.new("Part")
detector.Name = "ItemDetector"
detector.Size = Vector3.new(SlapAuraHitbox, 5, SlapAuraHitbox)
detector.Transparency = 0.7
detector.CanCollide = false
detector.Anchored = false
detector.Massless = true
detector.Parent = plr.Character
detector.CFrame = hrp.CFrame
local weld = Instance.new("Weld")
weld.Part0 = detector
weld.Part1 = hrp
weld.Parent = detector
   detector.Touched:Connect(function(hit)
         kilka(hit)
   end)
end


function kilka(hit) 
   if not hit.Parent:FindFirstChildOfClass("Humanoid") or hit.Parent.Name == "Crate" or hit.ClassName == "Tool" then return end
         if not toolChecker() then return end
         if ignorePlayers[hit.Parent] or youInRagdoll then return end
         if plr.Character:FindFirstChild("FakePart Right Arm") then youInragdoll() return end
         if hit.Parent:FindFirstChild("FakePart Right Arm")  then addToIgnore(hit.Parent) return end
         if targetCD == true then return end
         local anotherChar = hit.Parent
         VirtualInputManager:SendMouseButtonEvent(950,550,0,true,game,0)
         task.wait(0.1)
         for i,v in pairs( plr.Character:FindFirstChildOfClass("Tool"):GetChildren()) do
         print(v.Name)
         end
         local glove = plr.Character:FindFirstChildOfClass("Tool").Glove
         glove.Position = anotherChar.HumanoidRootPart.Position 
         VirtualInputManager:SendMouseButtonEvent(950,550,0,false,game,0)
         targetCD = true
         task.wait(0.3)
         glove.Position = plr.Character:FindFirstChild("Right Arm").Position
         task.wait(0.6)
         targetCD = false
end

function slap(hit)
if not hit.Parent:FindFirstChildOfClass("Humanoid") or hit.Parent.Name == "Crate" or hit.ClassName == "Tool" then return end
         if not toolChecker() then return end
         if ignorePlayers[hit.Parent] or youInRagdoll then return end
         if plr.Character:FindFirstChild("FakePart Right Arm") then youInragdoll() return end
         if hit.Parent:FindFirstChild("FakePart Right Arm")  then addToIgnore(hit.Parent) return end
         if targetCD == true then return end
         VirtualInputManager:SendMouseButtonEvent(950,550,0,true,game,0)
         print(hit.ClassName)
         if not skipFlick then
         task.wait(0.1)
         end
         VirtualInputManager:SendMouseButtonEvent(950,550,0,false,game,0)
         local root = plr.Character:FindFirstChild("HumanoidRootPart")
         print("расстояние рутов" .. tostring(hit.Position.Y - root.Position.Y))
         if  (hit.Position.Y - root.Position.Y) < -1 then return end
         if (hit.Position.Y - root.Position.Y) > 2 then 
            HitLater()
         end
         plr.Character.Humanoid.AutoRotate = false
         local targetRoot = hit.Parent:FindFirstChild("Head")
         if not root or not targetRoot then
         plr.Character.Humanoid.AutoRotate = true
         return 
          end
         root.CFrame = CFrame.new(root.Position, Vector3.new(targetRoot.Position.X, root.Position.Y, targetRoot.Position.Z))
         targetCD = true
         task.wait(0.2)
         plr.Character.Humanoid.AutoRotate = true
         task.wait(0.7)
         targetCD = false
end

function HitLater(obj)
   while (obj.Position.Y - root.Position.Y) > 2 do
      if (obj.Position.Y - root.Position.Y) > 5 then return end
      task.wait(0.01)
   end       
   slap(obj)
end

function toolChecker()
local tool = plr.Character:FindFirstChildOfClass("Tool")
if not tool or tool.Name == "Glider" then return end
return true
end

function youInragdoll()
   youInRagdoll = true
   while plr.Character:FindFirstChild("FakePart Right Arm") do
   if plr.Character.Humanoid.Health <= 0 then
   break
   end
   task.wait(0.1)
   end
   task.wait(0.3)
   youInRagdoll = false

end
function addToIgnore(player)
   ignorePlayers[player] = true
   if player:FindFirstChild("Highlight") then
        player.Highlight.FillColor = Color3.fromRGB(36, 26, 235)
   end
   while player:FindFirstChild("FakePart Right Arm") do

   if player.Humanoid.Health <= 0 then
   break
   end
   task.wait(0.1)
   end
   task.wait(0.5)
   ignorePlayers[player] = nil
    if player:FindFirstChild("Highlight") then
      player.Highlight.FillColor = Color3.fromRGB(255, 0, 0)
   end
end

function toolActivate()
local tool = plr.Character:FindFirstChildOfClass("Tool")
   if tool  then
      if tool.Name == "Glider" then return end
      tool:Activate()
      return true
   else
   return nil
   end
end

function ItemESPFunc(v)
   for i, object in pairs(game.Workspace.Items:GetChildren()) do
   if v then
      local color = items[object.Name]
      if not object:FindFirstChild("Highlight") then
         if not color then
            color = Color3.fromRGB(168, 12, 12) 
         end
         local highlight = Instance.new("Highlight")
         highlight.OutlineColor = color
         highlight.FillColor = color
         highlight.FillTransparency = 0
         highlight.Parent = object
         if not object:FindFirstChild("ItemESP") then
         local billboard = Instance.new("BillboardGui")
         billboard.Name = "ItemESP"
         billboard.Parent = object
         billboard.Size = UDim2.new(0, 200, 0, 50)
         billboard.StudsOffset = Vector3.new(0, 2, 0)
         billboard.AlwaysOnTop = true
         local label = Instance.new("TextLabel")
         label.Parent = billboard
         label.Size = UDim2.new(1, 0, 1, 0)
         label.BackgroundTransparency = 1
         label.Text = object.Name
         label.TextColor3 = color
         label.TextStrokeTransparency = 0
         label.TextScaled = false
         label.TextSize = 18
         label.Font = Enum.Font.SourceSansBold
         end
      end  
   else
       if object:FindFirstChild("Highlight") then
         object.Highlight:Destroy()
       end
      if object:FindFirstChild("ItemESP") then 
         object.ItemESP:Destroy()
      end
   end   
   task.wait(0.05)  
   end
end



function append(str, suffix)
   if not suffix then
   return str .. "?"
   end
   return str .. suffix
end


function AutoCode()
res = ""
for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
   if v.ClassName == "ImageLabel" then
      print(codes[v.Image])
      res = append(res, codes[v.Image])
   end
end
print(res)
return res
end

function onInputBegan(input, gameProcessed)  
  if gameProcessed then return end 
    if input.KeyCode == Enum.KeyCode.Q then
        mouseTarget()
        Childrenoftarget(Mouse.Target)
   end
end

function plrPos()
    print("голова:".. tostring(plr.Character.Head.Position))
    print(tostring(plr.Character.Head.CFrame))
    print("ХРП:"..tostring(plr.Character.HumanoidRootPart.Position))
    print(tostring(plr.Character.HumanoidRootPart.CFrame))
    print("торсо:".. tostring(plr.Character.Torso.Position))
    print(tostring(plr.Character.Torso.CFrame))
end

print
function platformChangeStatus()
 platform = not platform
        if platform == false then
            local p = game.Workspace:FindFirstChild("plat")
            if p then
            p:Destroy()
            end
        else
        local plat = Instance.new("Part")
            plat.Position = Vector3.new(0,-15,0)
            plat.Size = Vector3.new(2000,0.5,2000)
            plat.CanCollide = true
            plat.Anchored = true
            plat.Transparency = 0.5
            plat.Parent = game.Workspace
            plat.Name = "plat"
        end    
end   


function tp()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(0,0,2.2)
end

function mouseTarget()
local target = Mouse.Target

  if target then
    print("Объект: " .. target.Name)
       print("Полное имя: " .. target:GetFullName())
       print("тип: " .. target.ClassName)
  else
  end
end  

function remSpeed()
plr.Character.Humanoid.WalkSpeed = plr.Character.Humanoid.WalkSpeed-1
end


Mouse.Button1Down:Connect(function()
if targetCD == true or autoFlick == false then return end
local closest = getNearestPlayer()
if not closest then return end
if ignorePlayers[closest] or youInRagdoll then return end
if plr.Character:FindFirstChild("FakePart Right Arm") then youInragdoll() return end
if closest:FindFirstChild("FakePart Right Arm")  then addToIgnore(closest) return end
task.wait(0.1)
local root = plr.Character:FindFirstChild("Head")
plr.Character.Humanoid.AutoRotate = false
    local targetRoot = closest:FindFirstChild("Head")
    if not root or not targetRoot then return end
    root.CFrame = CFrame.new(root.Position, Vector3.new(targetRoot.Position.X, root.Position.Y, targetRoot.Position.Z))
    targetCD = true
    task.wait(0.2)
    plr.Character.Humanoid.AutoRotate = true
    task.wait(0.7)
    targetCD = false
end)
function getNearestPlayer()
    local character = plr.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    local root = character.HumanoidRootPart
    local closest = nil
   for _, other in pairs(game.Players:GetChildren()) do
      if other ~= plr and other.Character and other.Character:FindFirstChild("HumanoidRootPart") then
         local dist = (other.Character.HumanoidRootPart.Position - root.Position).Magnitude
         if dist > 15 then
            continue
         end
         closest = other
      end
   end
if closest then
return closest.Character
end
end

function getNearestPlayer2()
    local character = plr.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    local root = character.HumanoidRootPart
    local closest = nil
   for _, other in pairs(game.Players:GetChildren()) do
      if other ~= plr and other.Character and other.Character:FindFirstChild("HumanoidRootPart") then
         local dist = (other.Character.HumanoidRootPart.Position - root.Position).Magnitude
         if dist > 35 then
            continue
         end
         closest = other
      end
   end
if closest then
return closest.Character
end
end

function addSpeed()
plr.Character.Humanoid.WalkSpeed = plr.Character.Humanoid.WalkSpeed+1
end

input.InputBegan:Connect(onInputBegan)

function espUpd()
   while task.wait(EspUpdCd) do
      if esp then
         for _,v in pairs(Players:GetPlayers()) do
            if v~=plr and v.Character then
               if not v.Character:FindFirstChild("Highlight") then
                  Instance.new("Highlight",v.Character)
               end
            end   
         end   
      end
   end   
end   


function Childrenoftarget(v) 
for i,a in pairs(v:GetChildren()) do
print("children name: ".. a.Name)
print("Children Full name: ".. a:GetFullName())
print("Children Class: ".. a.ClassName)
end
end

function shoot()
VirtualInputManager:SendMouseButtonEvent(900,500,0,true,game,0)
task.wait(0.01)
VirtualInputManager:SendMouseButtonEvent(900,500,0,false,game,0)
end


local function getTargetRoot()
    if not targetName or targetName == "" then return nil end
    
    local targetPlayer = Players:FindFirstChild(targetName)
    if not targetPlayer then return nil end
    
    local character = targetPlayer.Character
    if not character then return nil end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    
    if humanoid and humanoid.Health > 0 and root then
        return root
    end
    return nil
end


RunService.RenderStepped:Connect(function()
if aimAssist then
  local targetRoot = getTargetRoot()
    if targetRoot then
        local currentCFrame = camera.CFrame
        local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetRoot.Position)
        
        camera.CFrame = currentCFrame:Lerp(targetCFrame, SMOOTHNESS)
        
        if head and head:FindFirstChild("Neck") then
            local neck = head.Neck
            
            local headPos = head.Position
            local lookDirection = (targetRoot.Position - headPos).Unit
            
            local targetHeadCFrame = CFrame.lookAt(headPos, headPos + lookDirection)
         
            neck.C0 = neck.C0:Lerp(
                CFrame.new(neck.C0.Position) * targetHeadCFrame.Rotation, 
                SMOOTHNESS * 1.8  
            )
        end
    end
end    
if not triggerBot then return end
local target = Mouse.Target
if not target then return end  
if onlyHeads then
   if target.Name == "Head" or target.Name == "HitboxHead" or target.Name == "HitboxHeadSmall"then
      shoot()
      return
	end
else
   if target.Parent:FindFirstChild("HumanoidRootPart") then
      shoot()
      return
   end
end
end)
delay(5,espUpd())


print("готов к работе")