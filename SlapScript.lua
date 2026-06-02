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
local MovementTab = Window:CreateTab("All games")
local SBTab = Window:CreateTab("Slap Battles")
local FriendsTab = Window:CreateTab("Friends")
local SRTab = Window:CreateTab("Slap Royale")
local RivalsTab = Window:CreateTab("Rivals")
local MiscTab = Window:CreateTab("Other")
--Services
local input = game:GetService("UserInputService")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local char = plr.Character
local Mouse = plr:GetMouse()
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
--variables
local selectedPlayer = nil
local platform = false --AntiVoid Platform
local targetCD = false
local autoFlick = false
local esp = false
local notify = false -- SR Items Notify
local EspUpdCd = 3
local triggerBot = false
local onlyHeads = false
local AIM_ASSIST_RANGE = 250
local AIM_ASSIST_FOV = 180
local SMOOTHNESS = 1  --Aim Assist Strengh
local FriendEspColor = Color3.fromRGB(66, 245, 87) 
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
local healItems = {"Apple","Bandage","First Aid Kit","Healing Potion"}
local Permsitems = {"Bull's essence","Frog Potion","Speed Potion","Boba","Potion of Strength"}
local SpeedStrengh = 15
local friends = {"drsygdgdhsj", "Stars3323","dimonraina","bleb_master"}
local FriendRem = nil
local speedsUsed = false
local aimAssist = false
local youInRagdoll = false
local targetName =  nil
local ignorePlayers = {}
local skipFlick = false
local SlapAuraHitbox = 20
local AimtargetPlayer = nil
local FriendAdd = nil
local AutoHeal = false
local hpHeal = 20
local AutoPerms = false
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
local Colors = {
    Power = Color3.fromRGB(255, 60, 60),  
    Speed = Color3.fromRGB(60, 255, 100),  
    Jump  = Color3.fromRGB(80, 180, 255)   
}
local slapAura = false
local ItemESP = false
local camera = Workspace.CurrentCamera
local humanoidForHeal = nil
local SRStats = false


function getPlayers()
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
humanoidForHeal = plr.Character:FindFirstChildOfClass("Humanoid")

local ItemService = game.Workspace.Items
ItemService.ChildAdded:Connect(function(object)
   task.spawn(function()
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
end)
humanoidForHeal.HealthChanged:Connect(function(health)
if not AutoHeal then return end
   if health <= 0 then return end
        if health <= hpHeal then
         useHealingItem()
        end
    end)
end



--GUI Functions
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



MovementTab:CreateToggle({
   Name="ESP",
   CurrentValue=false,
   Callback=function(a)
      esp = a
      for _,v in pairs(Players:GetPlayers()) do
         if v~=plr and v.Character then
            if esp then
               if not v.Character:FindFirstChild("Highlight") then
                  Instance.new("Highlight",v.Character)
                  isFriend = table.find(friends,v.Name)
                  if isFriend then
                  v.Character.Highlight.FillColor = FriendEspColor
                  end
               end
            else
               local h=v.Character:FindFirstChild("Highlight")
               if h then h:Destroy() end
            end
         end
      end
   end
})
MovementTab:CreateSlider({
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
      for i,v in pairs(plr.Character.Head.Nametag.Labels:GetChildren()) do
         print("Name: "..v.Name) 
         print(v.ClassName)
      end
   end
})
MiscTab:CreateButton({
   Name="HideName",  
   Callback=function()
      plr.Character.Head.Nametag.Labels.TopLabel.Text = "Tencell"
   end
})



SBTab:CreateToggle({
   Name="AutoFlick ",
   CurrentValue=false,
   Callback=function(v)
       autoFlick = not autoFlick
   end
})
SBTab:CreateToggle({ 
   Name="Skip Flick ",
   CurrentValue=false,
   Callback=function(v)
       skipFlick = v
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
SRTab:CreateToggle({
   Name="Players stats ",
   CurrentValue=false,
   Callback=function(v)
         SRStats = v
         if v then
            for i,v in pairs(Players:GetChildren()) do 
               createBillboard(v)
            end
         else
            for i,v in pairs(Players:GetChildren()) do 
               if v.Character.Head:FindFirstChild("StatsGui") then
               v.Character.Head:FindFirstChild("StatsGui"):Destroy()
               end
            end
         end
   end
})
SRTab:CreateButton({
   Name="spiderMan",
   Callback=function()
       local childs = game.Workspace.Map.FiestaFarm:GetChildren()
       local stairs = childs[32]:Clone()
       local hrp = plr.Character.HumanoidRootPart
       stairs:PivotTo(hrp.CFrame * CFrame.new(0, 0, -10))


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


SRTab:CreateDivider()

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
        slapAura = v
   end
})


SRTab:CreateSlider({
   Name = "Slap Aura Hitbox",
   Range = {10, 30},
   Increment = 1,
   CurrentValue = 20,
   Callback = function(v)
      if plr.Character:FindFirstChild("ItemDetector") then
         plr.Character.ItemDetector.Size = Vector3.new(v, 5, v)
      end
      SlapAuraHitbox = v
   end,
})

SRTab:CreateDivider()

SRTab:CreateSlider({
   Name = "Speed Strengh",
   Range = {5, 30},
   Increment = 1,
   CurrentValue = SpeedStrengh,
   Callback = function(v)
      SpeedStrengh = v
   end,
})


SRTab:CreateButton({
   Name="+speed",
   Callback=function()
         local leg = plr.Character:FindFirstChild("Right Leg")
         local leg2 = plr.Character:FindFirstChild("Left Leg")
         leg.Position = leg2.Position + (leg2.CFrame.RightVector * SpeedStrengh)
         speedsUsed = true
   end
})
SRTab:CreateButton({
   Name="Speed reset",
   Callback=function()
      if speedsUsed then
         local object1 = plr.Character:FindFirstChild("Right Leg")
         local object2 = plr.Character:FindFirstChild("Left Leg")
         object1.Position = object2.Position + (object2.CFrame.RightVector * 1)
         test = false
      end
   end
})

SRTab:CreateDivider()

SRTab:CreateToggle({
   Name="Auto Heal ",
   CurrentValue=AutoHeal,
   Callback=function(v)
      AutoHeal = v
      if v then
         if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
         if plr.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then return end
            if plr.Character:FindFirstChildOfClass("Humanoid").Health <= hpHeal then
               useHealingItem()
            end
         end   
      end    
   end
})

SRTab:CreateSlider({
   Name = "Auto Heal Minimum",
   Range = {10, 50},
   Increment = 1,
   CurrentValue = hpHeal,
   Callback = function(v)
      hpHeal  = v
   end,
})


SRTab:CreateToggle({
   Name="Auto Perms",
   CurrentValue=AutoPerms,
   Callback=function(v)
      AutoPerms = v
      if v then
         for index, tool in pairs(plr.Backpack:GetChildren()) do
            for i,v in pairs(Permsitems) do
               if v == tool.Name then
                  if not AutoPerms then return end
                  humanoidForHeal:EquipTool(tool)
                  task.wait(0.1)
                  toolActivate()
               end
            end
            task.wait(0.2)
         end
         plr.Backpack.ChildAdded:Connect(onItemAdded)
      end    
   end
})


RivalsTab:CreateToggle({
   Name="Triger Bot",
   CurrentValue=false,
   Callback=function(a)
      triggerBot = a
   end
})
RivalsTab:CreateDropdown({
   Name="Select Player",
   Options=getPlayers(),
   Callback=function(opt)
      local name = typeof(opt)=="table" and opt[1] or opt
      AimtargetPlayer = name
   end
})
RivalsTab:CreateToggle({
   Name="Aim Assist",
   CurrentValue=false,
   Callback=function(a)
      aimAssist = a
      plr.Character:FindFirstChildOfClass("Humanoid").AutoRotate = a
   end
})

RivalsTab:CreateSlider({
   Name = "AIM ASSIST FOV",
   Range = {25, 180},
   Increment = 1,
   CurrentValue = AIM_ASSIST_FOV ,
   Callback = function(v)
      AIM_ASSIST_FOV = v
   end,
})

RivalsTab:CreateSlider({
   Name = "AIM ASSIST STRENGH",
   Range = {0.1, 1},
   Increment = 0.05,
   CurrentValue = SMOOTHNESS ,
   Callback = function(v)
      SMOOTHNESS = v
   end,
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
         local isFound = table.find(friends, hit.Parent.Name)
         if isFound then return end
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


local lastCheck = 0

RunService.Heartbeat:Connect(function()
    if not slapAura then return end
    if tick() - lastCheck < 0.1 then return end  -- проверяем ~10 раз в секунду
    lastCheck = tick()

    if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end
    if not toolChecker() then return end
    if youInRagdoll then return end

    local myRoot = plr.Character.HumanoidRootPart
    local myPos = myRoot.Position

    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer == plr then continue end
        if ignorePlayers[otherPlayer.Character] then continue end

        local char = otherPlayer.Character
        if not char then continue end

        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")

        if not hum or not root then continue end
        if hum.Health <= 0 then continue end

        local distance = (root.Position - myPos).Magnitude
        if distance <= SlapAuraHitbox  then
            kilka(otherPlayer.Character.HumanoidRootPart)
            break 
        end
    end
end)


function kilka(hit)
    local targetChar = hit and hit.Parent
    if not targetChar then return end
    if not targetChar:FindFirstChildOfClass("Humanoid") or targetChar.Name == "Crate" then return end
    if not toolChecker() then return end
    if ignorePlayers[targetChar] or youInRagdoll then return end
    if plr.Character:FindFirstChild("FakePart Right Arm") then youInragdoll() return end
    if targetChar:FindFirstChild("FakePart Right Arm") then addToIgnore(targetChar) return end
    if targetCD then return end
    local myRoot = plr.Character:FindFirstChild("HumanoidRootPart")
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    if not myRoot or not targetRoot then return end
    targetCD = true
    local tool = plr.Character:FindFirstChildOfClass("Tool")
    if not tool then targetCD = false return end

    local glove = tool:FindFirstChild("Glove")
    if not glove then targetCD = false return end
    glove.Position = targetChar.Head.Position 
    task.wait(0.1)
   mouse1press()
    for i = 1,25 do
      glove.Position = targetChar.Head.Position 
      if targetChar:FindFirstChild("FakePart Right Arm") or (targetRoot.Position - myRoot.Position).Magnitude > 20 then break end
      task.wait(0.02)
    end
    glove.Position = tool.Handle.Position + (tool.Handle.CFrame.UpVector * 2)
    task.wait(0.10)
    if targetChar:FindFirstChild("FakePart Right Arm") then
        addToIgnore(targetChar)
    else
      Rayfield:Notify({
      Title = "Slap Aura Miss",
      Content = "Slap Aura make a photo",
      Duration = 1
      })
    end
   targetCD = false

end


function slap(hit)
if not hit.Parent:FindFirstChildOfClass("Humanoid") or hit.Parent.Name == "Crate" or hit.ClassName == "Tool" then return end
         if not toolChecker() then return end
         if ignorePlayers[hit.Parent] or youInRagdoll then return end
         if plr.Character:FindFirstChild("FakePart Right Arm") then youInragdoll() return end
         if hit.Parent:FindFirstChild("FakePart Right Arm")  then addToIgnore(hit.Parent) return end
         if targetCD == true then return end
         local isFound = table.find(friends, hit.Parent.Name)
         if isFound then return end
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
   task.spawn(function()
      ignorePlayers[player] = true
      
      if player:FindFirstChild("Highlight") then
           player.Highlight.FillColor = Color3.fromRGB(36, 26, 235)
      end
      
      while player:FindFirstChild("FakePart Right Arm") do
          if player.Humanoid.Health <= 0 then
              break
          end
          task.wait(0.01)
      end
      
      task.wait(0.2)
      ignorePlayers[player] = nil
      
      if player:FindFirstChild("Highlight") then
         player.Highlight.FillColor = Color3.fromRGB(255, 0, 0)
      end
   end)
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
local closest = getNearestPlayer(15)
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
function getNearestPlayer(maxRadius)
    local character = plr.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    local root = character.HumanoidRootPart
    local closest = nil
   for _, other in pairs(Players:GetChildren()) do
      if other ~= plr and other.Character and other.Character:FindFirstChild("HumanoidRootPart") then
         local dist = (other.Character.HumanoidRootPart.Position - root.Position).Magnitude
         if dist > maxRadius then
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
                  isFriend = table.find(friends,v.Name)
                  if isFriend then
                  v.Character.Highlight.FillColor = FriendEspColor
                  end
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




local function getTargetRoot()
    if not AimtargetPlayer or AimtargetPlayer == "" then return nil end
    
    local targetPlayer = Players:FindFirstChild(AimtargetPlayer)
    if not targetPlayer then return nil end
    
    local character = targetPlayer.Character
    if not character then return nil end
    local humanoid = character:FindFirstChild("Humanoid")
    local root = nil
    if onlyHeads then
    root = character:FindFirstChild("Head")
    else
    root = character:FindFirstChild("HumanoidRootPart")
    end 
    if humanoid and humanoid.Health > 0 and root then
        return root
    end
 
    return nil
end

RunService.RenderStepped:Connect(function()
   if aimAssist then
        local targetRoot = getTargetRoot()
      if targetRoot and plr.Character then
         local char = plr.Character
         local head = char:FindFirstChild("Head")
         local humanoid = char:FindFirstChild("Humanoid")
         local currentCFrame = camera.CFrame
         local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetRoot.Position)
         camera.CFrame = currentCFrame:Lerp(targetCFrame, SMOOTHNESS)

         if head and head:FindFirstChild("Neck") then
            local neck = head.Neck
            print("голова повернута")
            local headPos = head.Position
            local lookDirection = (targetRoot.Position - headPos).Unit
                
            local targetHeadCFrame = CFrame.lookAt(headPos, headPos + lookDirection)
            neck.C0 = neck.C0:Lerp(
                  CFrame.new(neck.C0.Position) * targetHeadCFrame.Rotation, 
                  SMOOTHNESS * 1.6
            )
         end
      end         
   end  
if not triggerBot then return end
local target = Mouse.Target
if not target then return end
local isFriend = table.find(friends,target.Parent.Name)
if isFriend then return end    
if onlyHeads then
   if target.Name == "Head" or target.Name == "HitboxHead" then
      mouse1click()
      return
	end
else
   if target.Parent:FindFirstChild("HumanoidRootPart") then
      mouse1click()
      return
   end
end
end)

function updateStats(player)
    local char = player.Character
    if not char then return end
    if not char:FindFirstChild("Head") then return end
    local labels = char.Head:FindFirstChild("StatsGui")
    if not labels then createBillboard(player) return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end
    local speed = humanoid.WalkSpeed or "?"
    local power = char:GetAttribute("Power") or "?"
    local jump =  humanoid.JumpPower or "?"
    labels.SpeedLabel.Text = "Speed: " .. tostring(speed)
    labels.PowerLabel.Text = "Power: " .. tostring(power)
    labels.JumpLabel.Text  = "Jump: " .. tostring(jump)
end








function createBillboard(player)
    local head = player.Character and player.Character:FindFirstChild("Head")
    if not head then return end

    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "StatsGui"
    Billboard.Adornee = head
    Billboard.AlwaysOnTop = true
    Billboard.Size = UDim2.new(15, 0, 10, 0) 
    Billboard.StudsOffset = Vector3.new(0, 6.5, 0)
    Billboard.MaxDistance = 500                   
    Billboard.LightInfluence = 0
    Billboard.Parent = head

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Name = "NameLabel"
    NameLabel.Size = UDim2.new(1, 0, 0.25, 0)
    NameLabel.Position = UDim2.new(0, 0, 0, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = player.Name
    NameLabel.TextColor3 = Color3.new(1,1,1)
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextStrokeTransparency = 0.3
    NameLabel.TextStrokeColor3 = Color3.new(0,0,0)
    NameLabel.TextScaled = true
    NameLabel.Parent = Billboard


    local SpeedLabel = Instance.new("TextLabel")
    SpeedLabel.Name = "SpeedLabel"
    SpeedLabel.Size = UDim2.new(1, 0, 0.25, 0)
    SpeedLabel.Position = UDim2.new(0, 0, 0.25, 0)
    SpeedLabel.BackgroundTransparency = 1
    SpeedLabel.TextColor3 = Colors.Speed
    SpeedLabel.Font = Enum.Font.GothamSemibold
    SpeedLabel.TextStrokeTransparency = 0.4
    SpeedLabel.TextStrokeColor3 = Color3.new(0,0,0)
    SpeedLabel.TextScaled = true 
    SpeedLabel.Parent = Billboard


    local PowerLabel = Instance.new("TextLabel")
    PowerLabel.Name = "PowerLabel"
    PowerLabel.Size = UDim2.new(1, 0, 0.25, 0)
    PowerLabel.Position = UDim2.new(0, 0, 0.50, 0)
    PowerLabel.BackgroundTransparency = 1
    PowerLabel.TextColor3 = Colors.Power
    PowerLabel.Font = Enum.Font.GothamSemibold
    PowerLabel.TextStrokeTransparency = 0.4
    PowerLabel.TextStrokeColor3 = Color3.new(0,0,0)
    PowerLabel.TextScaled = true 
    PowerLabel.Parent = Billboard


    local JumpLabel = Instance.new("TextLabel")
    JumpLabel.Name = "JumpLabel"
    JumpLabel.Size = UDim2.new(1, 0, 0.25, 0)
    JumpLabel.Position = UDim2.new(0, 0, 0.75, 0)
    JumpLabel.BackgroundTransparency = 1
    JumpLabel.TextColor3 = Colors.Jump
    JumpLabel.Font = Enum.Font.GothamSemibold
    JumpLabel.TextStrokeTransparency = 0.4
    JumpLabel.TextStrokeColor3 = Color3.new(0,0,0)
    JumpLabel.TextScaled = true 
    JumpLabel.Parent = Billboard

    updateStats(player)
end

function getBestHealItem()
   for i,v in pairs(healItems) do
      print(i)
      print(v)
      for index, tool in pairs(plr.Backpack:GetChildren()) do
         if v == tool.Name then
            print("Найден ", v)
            return tool
         end
      end
      print(v," Не найден в инвентаре")
   end
   print("Не найденно хила")
end



function onItemAdded(item)
   if not AutoPerms then return end
   task.wait(0.2)
   print("получен предмет", item.Name)
   for i,v in pairs(Permsitems) do
      if v == item.Name then
         if not AutoPerms then print("не включен ") return end
            humanoidForHeal:EquipTool(item)
            task.wait(0.1)
            toolActivate()
      end 

   end

end


FriendsTab:CreateDropdown({
   Name="Select Player to add",
   Options=getPlayers(),
   Callback=function(opt)
      local name = typeof(opt)=="table" and opt[1] or opt
      FriendAdd = name
   end
})

FriendsTab:CreateButton({
   Name="Add Friend",
   Callback=function()
      if FriendAdd then
         table.insert(friends,FriendAdd)
            if Players:FindFirstChild(FriendAdd).Character and Players:FindFirstChild(FriendAdd).Character:FindFirstChild("Highlight") then
            Players:FindFirstChild(FriendAdd).Character.Highlight.FillColor = FriendEspColor
            end
         RefreshFriends() 
         FriendAdd = nil
      end
   end   
})


local FriendsDropdown = FriendsTab:CreateDropdown({
   Name="Select Friend",
   Options=friends,
   Callback=function(opt)
      local name = typeof(opt)=="table" and opt[1] or opt
      FriendRem = name
   end
})

-- function MakePhoto()
--     VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Print, false, game)
--     task.wait(0.05)
--     VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Print, false, game)
-- end


FriendsTab:CreateButton({
   Name="Remove Friend",
   Callback=function()
         if FriendRem then
         local index = table.find(friends,FriendRem)
         if index then
	      table.remove(friends, index)
         end
            if Players:FindFirstChild(FriendRem).Character and Players:FindFirstChild(FriendRem).Character:FindFirstChild("Highlight") then
               Players:FindFirstChild(FriendRem).Character:FindFirstChild("Highlight").FillColor = Color3.fromRGB(255,0,0)
            end
         FriendsDropdown:Refresh(friends)   
         end
   end
})


local ColorPicker = FriendsTab:CreateColorPicker({
   Name = "Set Friend Esp Color",
   Color = FriendEspColor,
   Callback = function(Value)
      FriendEspColor = Value
   end
})


FriendsTab:CreateButton({
   Name="Set color",
   Callback=function()
      print(FriendRem)
      print(Players:FindFirstChild(FriendRem).Character:FindFirstChild("Highlight"))
      if not FriendRem or not  Players:FindFirstChild(FriendRem).Character:FindFirstChild("Highlight") then
      Rayfield:Notify({
      Title = "Not found friend",
      Content = "or you dont on esp",
      Duration = 3,
      })
      return
      end
      Players:FindFirstChild(FriendRem).Character:FindFirstChild("Highlight").FillColor = FriendEspColor
   end
})


function RefreshFriends()
   FriendsDropdown:Refresh(friends)
end

function useHealingItem()
   local healItem = getBestHealItem()
   if not healItem then return end
   if not humanoidForHeal then return end
   humanoidForHeal:EquipTool(healItem)
   toolActivate()
   task.wait(0.5)
   print(humanoidForHeal.Health, "Сейчас хп")
   if humanoidForHeal.Health <= hpHeal then
   useHealingItem()
   else
      for index, tool in pairs(plr.Backpack:GetChildren()) do
         if tool:FindFirstChild("Glove") then
            humanoidForHeal:EquipTool(tool)
            return
         end
      end
   end
end


function updStat()
print("теееест")
while true do
   print(SRStats)
   if SRStats then
      for i,v in pairs(Players:GetChildren()) do
         print("обновленно")
         updateStats(v)
         task.wait(0.01)
      end
   end
   task.wait(1)  
end
end


delay(5,espUpd)
delay(5,updStat)
print("готов к работе")
