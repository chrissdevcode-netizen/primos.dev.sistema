-- CHRISS HUB | KEY SYSTEM V2 

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

local HttpService = game:GetService("HttpService")
local RbxAnalytics = game:GetService("RbxAnalyticsService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local DatabaseURL = "https://sistema-llaves-primosdev-default-rtdb.firebaseio.com/"

--  PETICIÓN HTTP 
local httprequest = request or http_request or (fluxus and fluxus.request)
if not httprequest then
    LocalPlayer:Kick("Tu ejecutor no soporta peticiones HTTP avanzadas.")
    return
end

-- OBTENER HWID 
local function GetHWID()
    local success, result = pcall(function() return RbxAnalytics:GetClientId() end)
    return success and result or tostring(LocalPlayer.UserId .. "-FALLBACK")
end
local MyHWID = GetHWID()

-- Efecto de Desenfoque Cinemático
local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Size = 0
BlurEffect.Parent = Lighting
TweenService:Create(BlurEffect, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = 20}):Play()

-- INTERFAZ NEON🔥
local AuthGui = Instance.new("ScreenGui")
AuthGui.Name = "ChrissAuthSystemPremium"
AuthGui.ResetOnSpawn = false

--  PCALL PARA EVITAR BLOQUEOS 
local successParent = pcall(function() AuthGui.Parent = CoreGui end)
if not successParent then AuthGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 1
Overlay.BorderSizePixel = 0
Overlay.Parent = AuthGui
TweenService:Create(Overlay, TweenInfo.new(0.5), {BackgroundTransparency = 0.6}):Play()

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 0, 0, 0) 
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 13, 17)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = AuthGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(160, 80, 255)
UIStroke.Thickness = 2
UIStroke.Transparency = 1
UIStroke.Parent = MainFrame

local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1, 60, 1, 60)
Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = Color3.fromRGB(160, 80, 255)
Glow.ImageTransparency = 1
Glow.ZIndex = 0
Glow.Parent = MainFrame

-- 🔥 TITULO DORADO CON ANIMACIÓN DE BRILLO 🔥
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 15)
Title.Text = "PRIMOS DEV "
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255) -- Color base (será sobreescrito por el gradiente)
Title.BackgroundTransparency = 1
Title.TextTransparency = 1
Title.Parent = MainFrame

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 180, 0)),      -- Oro oscuro
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 150)),  -- Brillo blanco/amarillo
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 180, 0))       -- Oro oscuro
})
TitleGradient.Rotation = 0
TitleGradient.Parent = Title

-- Animación del brillo dorado moviéndose de un lado a otro
task.spawn(function()
    TitleGradient.Offset = Vector2.new(-0.8, 0)
    local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
    local gradientTween = TweenService:Create(TitleGradient, tweenInfo, {Offset = Vector2.new(0.8, 0)})
    gradientTween:Play()
end)

--  BOTÓN DE CERRAR 
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 10)
CloseBtn.Text = "×"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 24
CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextTransparency = 1
CloseBtn.Parent = MainFrame

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    -- Animación de cierre y destrucción
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    TweenService:Create(Overlay, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(BlurEffect, TweenInfo.new(0.5), {Size = 0}):Play()
    task.wait(0.5)
    AuthGui:Destroy()
    BlurEffect:Destroy()
end)

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.85, 0, 0, 48)
KeyInput.Position = UDim2.new(0.5, 0, 0.42, 0)
KeyInput.AnchorPoint = Vector2.new(0.5, 0.5)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
KeyInput.Text = ""
KeyInput.PlaceholderText = "Ingresa tu Licencia VIP..."
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 13
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextTransparency = 1
KeyInput.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = KeyInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(60, 65, 80)
InputStroke.Thickness = 1.5
InputStroke.Parent = KeyInput

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0.5, 0, 0.62, 0)
StatusLabel.AnchorPoint = Vector2.new(0.5, 0.5)
StatusLabel.Text = "Estado: Esperando validación"
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.TextSize = 11
StatusLabel.TextColor3 = Color3.fromRGB(120, 125, 140)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextTransparency = 1
StatusLabel.Parent = MainFrame

local CheckBtn = Instance.new("TextButton")
CheckBtn.Size = UDim2.new(0.85, 0, 0, 45)
CheckBtn.Position = UDim2.new(0.5, 0, 0.82, 0)
CheckBtn.AnchorPoint = Vector2.new(0.5, 0.5)
CheckBtn.BackgroundColor3 = Color3.fromRGB(160, 80, 255)
CheckBtn.Text = "INICIAR SESIÓN"
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.TextSize = 14
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.TextTransparency = 1
CheckBtn.AutoButtonColor = false
CheckBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = CheckBtn

-- Animaciones de Entrada
local OpenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
TweenService:Create(MainFrame, OpenInfo, {Size = UDim2.new(0, 380, 0, 260)}):Play()
TweenService:Create(UIStroke, TweenInfo.new(0.8), {Transparency = 0}):Play()
TweenService:Create(Glow, TweenInfo.new(1), {ImageTransparency = 0.7}):Play()

task.wait(0.3)
local FadeInfo = TweenInfo.new(0.4)
TweenService:Create(Title, FadeInfo, {TextTransparency = 0}):Play()
TweenService:Create(CloseBtn, FadeInfo, {TextTransparency = 0}):Play()
TweenService:Create(KeyInput, FadeInfo, {TextTransparency = 0}):Play()
TweenService:Create(StatusLabel, FadeInfo, {TextTransparency = 0}):Play()
TweenService:Create(CheckBtn, FadeInfo, {TextTransparency = 0}):Play()

-- Efectos del Input y Botón
KeyInput.Focused:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(160, 80, 255)}):Play()
end)
KeyInput.FocusLost:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(60, 65, 80)}):Play()
end)

CheckBtn.MouseEnter:Connect(function()
    TweenService:Create(CheckBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 110, 255)}):Play()
end)
CheckBtn.MouseLeave:Connect(function()
    TweenService:Create(CheckBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(160, 80, 255)}):Play()
end)
CheckBtn.MouseButton1Down:Connect(function()
    TweenService:Create(CheckBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.82, 0, 0, 42)}):Play()
end)
CheckBtn.MouseButton1Up:Connect(function()
    TweenService:Create(CheckBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.85, 0, 0, 45)}):Play()
end)



-- 🔥 LÓGICA DE SERVIDOR Y VALIDACIÓN 
local isChecking = false

local function IniciarValidacion()
    if isChecking then return end
    local userKey = KeyInput.Text:gsub("%s+", "")
    
    if userKey == "" then
        StatusLabel.Text = "❌ Campo vacío, ingresa tu llave."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        
        local originalPos = MainFrame.Position
        for i = 1, 4 do
            MainFrame.Position = originalPos + UDim2.new(0, math.random(-5, 5), 0, 0)
            task.wait(0.05)
        end
        MainFrame.Position = originalPos
        return
    end

    isChecking = true
    StatusLabel.Text = "⏳ Conectando con el servidor..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    CheckBtn.Text = "VERIFICANDO..."
    
    local success, err = pcall(function()
        --  Checar mantenimiento global
        local sysReq = httprequest({Url = DatabaseURL .. "system_status.json", Method = "GET"})
        local sysStatus = HttpService:JSONDecode(sysReq.Body)

        --  Descargar datos de la llave
        local keyReq = httprequest({Url = DatabaseURL .. "keys/" .. userKey .. ".json", Method = "GET"})
        local keyData = HttpService:JSONDecode(keyReq.Body)

        --  Validar Existencia
        if not keyData or keyData == "null" then
            StatusLabel.Text = "❌ Llave inválida o eliminada."
            StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            CheckBtn.Text = "INICIAR SESIÓN"
            isChecking = false
            return
        end

        --  Validar Blacklist (Baneo Manual)
        if keyData.status == "blacklisted" then
            StatusLabel.Text = "⛔ Llave Baneada por el Administrador."
            StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            CheckBtn.Text = "INICIAR SESIÓN"
            isChecking = false
            return
        end

        -- Validar Pausa o Mantenimiento
        if keyData.status == "paused" or (sysStatus and sysStatus.vip_paused and keyData.type == "VIP") then
            StatusLabel.Text = "⏸️ Sistema en Mantenimiento."
            StatusLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
            CheckBtn.Text = "INICIAR SESIÓN"
            isChecking = false
            return
        end

        local currentTime = os.time()

        --  ACTIVACIÓN POR HWID 
        if keyData.expires_at == 0 then
            local duration = keyData.duration_seconds or 0
            if duration > 0 then
                local newExpiration = currentTime + duration
                keyData.expires_at = newExpiration
                
                -- Guardar nueva fecha en Firebase
                httprequest({
                    Url = DatabaseURL .. "keys/" .. userKey .. "/expires_at.json",
                    Method = "PUT",
                    Body = HttpService:JSONEncode(newExpiration),
                    Headers = {["Content-Type"] = "application/json"}
                })
            else
                StatusLabel.Text = "❌ Error en los datos de duración."
                StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                CheckBtn.Text = "INICIAR SESIÓN"
                isChecking = false
                return
            end
        end

        --  Validar Expiración
        if currentTime > keyData.expires_at then
            StatusLabel.Text = "🔴 Tu llave ha expirado."
            StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            CheckBtn.Text = "INICIAR SESIÓN"
            isChecking = false
            return
        end

        -- Validar Límite de HWID
        local used_hwids = keyData.used_hwids or {}
        local hwidEncontrado = false

        for _, v in pairs(used_hwids) do
            if v == MyHWID then
                hwidEncontrado = true
                break
            end
        end

        if not hwidEncontrado then
            if #used_hwids < keyData.hwid_limit then
                table.insert(used_hwids, MyHWID)
                local updateReq = httprequest({
                    Url = DatabaseURL .. "keys/" .. userKey .. "/used_hwids.json",
                    Method = "PUT",
                    Body = HttpService:JSONEncode(used_hwids),
                    Headers = {["Content-Type"] = "application/json"}
                })
                
                if updateReq.StatusCode ~= 200 then
                    StatusLabel.Text = "❌ Error al enlazar PC."
                    StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                    CheckBtn.Text = "INICIAR SESIÓN"
                    isChecking = false
                    return
                end
            else
                StatusLabel.Text = "❌ Límite de HWID alcanzado."
                StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                CheckBtn.Text = "INICIAR SESIÓN"
                isChecking = false
                return
            end
        end

        
        --  ACCESO CONCEDIDO
        
        StatusLabel.Text = "✅ ¡Acceso Concedido! Cargando sistema..."
        StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
        CheckBtn.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        CheckBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        CheckBtn.Text = "ACCESO PERMITIDO"
        
        task.wait(1)
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(Overlay, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(BlurEffect, TweenInfo.new(0.5), {Size = 0}):Play()
        
        task.wait(0.5)
        AuthGui:Destroy()
        BlurEffect:Destroy()
        
        -- Ejecuta tu script principal
        IniciarScriptPrincipal()
    end)

    if not success then
        StatusLabel.Text = "❌ Error de conexión."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        CheckBtn.Text = "INICIAR SESIÓN"
        isChecking = false
    end
end

CheckBtn.MouseButton1Click:Connect(function()
    task.spawn(function()
        IniciarValidacion()
    end)
end)


function IniciarScriptPrincipal()

	



--SERVICIOS PRIMOS DEV SCRIPT 
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local LocalizationService = game:GetService("LocalizationService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
 
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local DroppedItems = Workspace:WaitForChild("DroppedItems")
 
-- OPTIMIZACIÓN MÓVIL / PC (FPS CAP & RENDERING)
local UPDATE_DELAY = 0.033
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- CONFIGURACIÓN DE GUARDADO (SAVE CONFIG)
local CONFIG_FILE = "IsaacScript_Config.json"

local function LoadConfiguration()
	if isfile and isfile(CONFIG_FILE) then
		local success, result = pcall(function()
			return readfile(CONFIG_FILE)
		end)
		if success then
			local decoded = HttpService:JSONDecode(result)
			return decoded
		end
	end
	return nil
end

local SavedData = LoadConfiguration() or {}
 
-- GUI ADAPTABLE (Tamaño optimizado según plataforma - Rediseño Minimalista Oscuro / Acento Violeta)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false
 
local Menu = Instance.new("Frame")
Menu.Size = isMobile and UDim2.new(0, 320, 0, 420) or UDim2.new(0, 370, 0, 460)
Menu.Position = UDim2.new(0.5, -160, 0.2, 0)
Menu.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Menu.Active = true
Menu.Draggable = true
Menu.Parent = ScreenGui

-- ETIQUETA OWNER: ISAAC (Arriba a la izquierda)
local OwnerLabel = Instance.new("TextLabel")
OwnerLabel.Name = "OwnerLabel"
OwnerLabel.Parent = Menu
OwnerLabel.BackgroundTransparency = 1.000
OwnerLabel.Position = UDim2.new(0, 15, 0, 35)
OwnerLabel.Size = UDim2.new(0, 200, 0, 15)
OwnerLabel.Font = Enum.Font.GothamBold
OwnerLabel.Text = "OWNER ISAAC"
OwnerLabel.TextColor3 = Color3.fromRGB(160, 100, 255)
OwnerLabel.TextSize = 10
OwnerLabel.TextXAlignment = Enum.TextXAlignment.Left

local MenuCorner = Instance.new("UICorner")
Menu.ClipsDescendants = false
MenuCorner.CornerRadius = UDim.new(0, 14)
MenuCorner.Parent = Menu

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(45, 35, 65)
MenuStroke.Thickness = 1.5
MenuStroke.Parent = Menu

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 100, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 40, 180))
}
Gradient.Rotation = 45
Gradient.Parent = MenuStroke
 
-- TABS
local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(1, -12, 0, 34)
Tabs.Position = UDim2.new(0, 6, 0, 6)
Tabs.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Tabs.ClipsDescendants = true
Tabs.Parent = Menu

local TabsCorner = Instance.new("UICorner")
TabsCorner.CornerRadius = UDim.new(0, 10)
TabsCorner.Parent = Tabs
 
local VisualTab = Instance.new("TextButton")
VisualTab.Size = UDim2.new(0.31, 0, 1, 0)
VisualTab.Text = "VISUAL"
VisualTab.Font = Enum.Font.GothamBold
VisualTab.TextSize = 12
VisualTab.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
VisualTab.TextColor3 = Color3.fromRGB(220, 220, 220)
VisualTab.Parent = Tabs

local VisualCorner = Instance.new("UICorner")
VisualCorner.CornerRadius = UDim.new(0, 8)
VisualCorner.Parent = VisualTab

local VisualStroke = Instance.new("UIStroke")
VisualStroke.Color = Color3.fromRGB(160, 100, 255)
VisualStroke.Thickness = 1
VisualStroke.Parent = VisualTab
 
local AimTab = Instance.new("TextButton")
AimTab.Size = UDim2.new(0.31, 0, 1, 0)
AimTab.Position = UDim2.new(0.345, 0, 0, 0)
AimTab.Text = "AIMBOT"
AimTab.Font = Enum.Font.GothamBold
AimTab.TextSize = 12
AimTab.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
AimTab.TextColor3 = Color3.fromRGB(150, 150, 150)
AimTab.Parent = Tabs

local AimCorner = Instance.new("UICorner")
AimCorner.CornerRadius = UDim.new(0, 8)
AimCorner.Parent = AimTab

local AimStroke = Instance.new("UIStroke")
AimStroke.Color = Color3.fromRGB(40, 40, 50)
AimStroke.Thickness = 1
AimStroke.Parent = AimTab

-- PESTAÑA BLOOD
local BloodTab = Instance.new("TextButton")
BloodTab.Size = UDim2.new(0.31, 0, 1, 0)
BloodTab.Position = UDim2.new(0.69, 0, 0, 0)
BloodTab.Text = "BLOOD"
BloodTab.Font = Enum.Font.GothamBold
BloodTab.TextSize = 12
BloodTab.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
BloodTab.TextColor3 = Color3.fromRGB(150, 150, 150)
BloodTab.Parent = Tabs

local BloodCorner = Instance.new("UICorner")
BloodCorner.CornerRadius = UDim.new(0, 8)
BloodCorner.Parent = BloodTab

local BloodStroke = Instance.new("UIStroke")
BloodStroke.Color = Color3.fromRGB(40, 40, 50)
BloodStroke.Thickness = 1
BloodStroke.Parent = BloodTab
 
-- CLOSE
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 24, 0, 24)
Close.Position = UDim2.new(0.975, -26, 0, 11)
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16
Close.TextColor3 = Color3.fromRGB(200, 200, 200)
Close.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
Close.Parent = Menu

Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)
 
-- FRAMES
local frameSizeY = isMobile and UDim2.new(1, 0, 1, -50) or UDim2.new(1, 0, 1, -50)
local VisualFrame = Instance.new("Frame")
VisualFrame.Size = frameSizeY
VisualFrame.Position = UDim2.new(0, 0, 0, 50)
VisualFrame.BackgroundTransparency = 1
VisualFrame.Parent = Menu
 
local AimFrame = Instance.new("Frame")
AimFrame.Size = frameSizeY
AimFrame.Position = UDim2.new(0, 0, 0, 50)
AimFrame.BackgroundTransparency = 1
AimFrame.Visible = false
AimFrame.Parent = Menu

local BloodFrame = Instance.new("ScrollingFrame")
BloodFrame.Size = frameSizeY
BloodFrame.Position = UDim2.new(0, 0, 0, 50)
BloodFrame.BackgroundTransparency = 1
BloodFrame.Visible = false
BloodFrame.CanvasSize = UDim2.new(0, 0, 0, 440)
BloodFrame.ScrollBarThickness = 3
BloodFrame.Parent = Menu
 
-- BOTÓN FLOTANTE (MENÚ PRINCIPAL)
local Float = Instance.new("ImageButton")
Float.Size = UDim2.new(0, 42, 0, 42)
Float.Position = UDim2.new(0, 12, 0.5, -21)
Float.Image = "rbxassetid://81327258631605"
Float.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Float.BackgroundTransparency = 0
Float.Visible = false
Float.Active = true
Float.Draggable = true
Float.Parent = ScreenGui
 
Instance.new("UICorner", Float).CornerRadius = UDim.new(0, 10)
 
local FloatStroke = Instance.new("UIStroke")
FloatStroke.Thickness = 2
FloatStroke.Color = Color3.fromRGB(160, 100, 255)
FloatStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FloatStroke.Parent = Float

local FloatGradient = Instance.new("UIGradient")
FloatGradient.Rotation = 45
FloatGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 100, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 40, 180))
}
FloatGradient.Parent = FloatStroke

Close.MouseButton1Click:Connect(function()
	Menu.Visible = false
	Float.Visible = true
end)
 
Float.MouseButton1Click:Connect(function()
	Menu.Visible = true
	Float.Visible = false
end)
 
-- TAB SWITCH
VisualTab.MouseButton1Click:Connect(function()
	VisualFrame.Visible = true
	AimFrame.Visible = false
	BloodFrame.Visible = false

	VisualTab.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
	AimTab.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	BloodTab.BackgroundColor3 = Color3.fromRGB(18, 18, 22)

	VisualTab.TextColor3 = Color3.fromRGB(220, 220, 220)
	AimTab.TextColor3 = Color3.fromRGB(150, 150, 150)
	BloodTab.TextColor3 = Color3.fromRGB(150, 150, 150)

	VisualStroke.Color = Color3.fromRGB(160, 100, 255)
	AimStroke.Color = Color3.fromRGB(40, 40, 50)
	BloodStroke.Color = Color3.fromRGB(40, 40, 50)
end)

AimTab.MouseButton1Click:Connect(function()
	VisualFrame.Visible = false
	AimFrame.Visible = true
	BloodFrame.Visible = false

	AimTab.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
	VisualTab.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	BloodTab.BackgroundColor3 = Color3.fromRGB(18, 18, 22)

	AimTab.TextColor3 = Color3.fromRGB(220, 220, 220)
	VisualTab.TextColor3 = Color3.fromRGB(150, 150, 150)
	BloodTab.TextColor3 = Color3.fromRGB(150, 150, 150)

	AimStroke.Color = Color3.fromRGB(160, 100, 255)
	VisualStroke.Color = Color3.fromRGB(40, 40, 50)
	BloodStroke.Color = Color3.fromRGB(40, 40, 50)
end)

BloodTab.MouseButton1Click:Connect(function()
	VisualFrame.Visible = false
	AimFrame.Visible = false
	BloodFrame.Visible = true

	BloodTab.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
	VisualTab.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	AimTab.BackgroundColor3 = Color3.fromRGB(18, 18, 22)

	BloodTab.TextColor3 = Color3.fromRGB(220, 220, 220)
	VisualTab.TextColor3 = Color3.fromRGB(150, 150, 150)
	AimTab.TextColor3 = Color3.fromRGB(150, 150, 150)

	BloodStroke.Color = Color3.fromRGB(160, 100, 255)
	VisualStroke.Color = Color3.fromRGB(40, 40, 50)
	AimStroke.Color = Color3.fromRGB(40, 40, 50)
end)
 
-- TOGGLES VISUALES
local PlayerESP = true
local NameESP = true
local DistanceESP = true
local HealthESP = true
local WeaponESP = true
local Tracers = true
local HideNameEnabled = true

local ExcludedPlayers = {}
if SavedData.ExcludedPlayers then
	ExcludedPlayers = SavedData.ExcludedPlayers
end

local AimKey = Enum.KeyCode.F
local elementWidth = isMobile and 280 or 300
local elementPosX = isMobile and 20 or 35
 
local function toggle(text,pos,callback)
local b = Instance.new("TextButton")
b.Size = UDim2.new(0,elementWidth,0,30)
b.Position = UDim2.new(0,elementPosX,0,pos)
b.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
b.TextColor3 = Color3.fromRGB(120, 220, 120)
b.Text = text.." : ON"
b.Font = Enum.Font.GothamMedium
b.TextSize = 12
b.Parent = VisualFrame

local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0, 8)
c.Parent = b

local s = Instance.new("UIStroke")
s.Color = Color3.fromRGB(40, 70, 40)
s.Thickness = 1
s.Parent = b
 
local state = true
 
b.MouseButton1Click:Connect(function()
	state = not state
	b.Text = text.." : "..(state and "ON" or "OFF")

	if state then
		b.TextColor3 = Color3.fromRGB(120, 220, 120)
		if s then s.Color = Color3.fromRGB(40, 70, 40) end
	else
		b.TextColor3 = Color3.fromRGB(220, 100, 100)
		if s then s.Color = Color3.fromRGB(70, 40, 40) end
	end

	callback(state)
end)

return b
end
 
toggle("Player ESP",15,function(v) PlayerESP = v end)
toggle("Show Name",52,function(v) NameESP = v end)
toggle("Show Distance",89,function(v) DistanceESP = v end)
toggle("Show Health",126,function(v) HealthESP = v end)
toggle("Show Weapons",163,function(v) WeaponESP = v end)

toggle("Show Tracers",200,function(v)
	Tracers = v
	if not v then TracerLine.Visible = false end
end)

local HideBtn = toggle("Hide Name",237,function(v)
	HideNameEnabled = v
	if not v then
		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
			end
			for _,obj in pairs(character:GetDescendants()) do
				if obj:IsA("BillboardGui") then obj.Enabled = true end
			end
		end
	end
end)
HideBtn.Text = "Hide Name : ON"

local FAKE_NAME = "PRIMOS"

local function ocultarNombreEnTexto(textoOriginal)
	if not HideNameEnabled then return textoOriginal end
	if not textoOriginal then return "" end
	
	local realName = LocalPlayer.Name
	local displayName = LocalPlayer.DisplayName
	
	local modificado = textoOriginal:gsub(realName, FAKE_NAME)
	modificado = modificado:gsub(displayName, FAKE_NAME)
	
	return modificado
end

local function aplicarFiltroGlobal(objeto)
	if objeto:IsA("TextLabel") or objeto:IsA("TextBox") or objeto:IsA("TextButton") then
		objeto.Text = ocultarNombreEnTexto(objeto.Text)
		objeto:GetPropertyChangedSignal("Text"):Connect(function()
			if HideNameEnabled then
				local nuevo = ocultarNombreEnTexto(objeto.Text)
				if objeto.Text ~= nuevo then
					objeto.Text = nuevo
				end
			end
		end)
	elseif objeto:IsA("BillboardGui") then
		for _, desc in ipairs(objeto:GetDescendants()) do
			if desc:IsA("TextLabel") or desc:IsA("TextBox") or desc:IsA("TextButton") then
				desc.Text = ocultarNombreEnTexto(desc.Text)
				desc:GetPropertyChangedSignal("Text"):Connect(function()
					if HideNameEnabled then
						local nuevo = ocultarNombreEnTexto(desc.Text)
						if desc.Text ~= nuevo then
							desc.Text = nuevo
						end
					end
				end)
			end
		end
	end
end

for _, guiObj in ipairs(game:GetDescendants()) do
	pcall(function()
		aplicarFiltroGlobal(guiObj)
	end)
end

game.DescendantAdded:Connect(function(obj)
	pcall(function()
		aplicarFiltroGlobal(obj)
	end)
end)

local function hideMyName()
	if not HideNameEnabled then return end
	local character = LocalPlayer.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	end
	for _,v in pairs(character:GetDescendants()) do
		if v:IsA("BillboardGui") then
			v.Enabled = false
			for _, label in ipairs(v:GetDescendants()) do
				if label:IsA("TextLabel") then
					label.Text = ocultarNombreEnTexto(label.Text)
				end
			end
		elseif v:IsA("Model") and (v.Name:find(LocalPlayer.Name) or v.Name:find("Car") or v.Name:find("Vehicle") or v.Name:find("Coche")) then
			if v.Name:find(LocalPlayer.Name) then
				v.Name = FAKE_NAME
			end
		end
	end
end

RunService.Heartbeat:Connect(hideMyName)
task.wait(1)
if HideNameEnabled then hideMyName() end

-- FILTRO DE ANIMACIONES (BLOQUEA TODO LO RELACIONADO CON AMMO, CRATE, RECARGAS Y ACCIONES EXCEPTO CAMINAR)
local function eliminarAnimacionesDeUso(char)
	local animator = char:FindFirstChildOfClass("Humanoid") and char.Humanoid:FindFirstChildOfClass("Animator")
	if animator then
		local playingTracks = pcall(function() return animator:GetPlayingAnimationTracks() end)
		if playingTracks then
			for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
				local name = track.Name:lower()
				if name:find("ammo") or name:find("crate") or name:find("pistol") or name:find("reload") or name:find("use") or name:find("drink") or name:find("eat") or name:find("blood") or name:find("heal") or name:find("equip") then
					track:Stop(0)
				end
			end
		end
	end
end

RunService.Stepped:Connect(function()
	local char = LocalPlayer.Character
	if char then
		eliminarAnimacionesDeUso(char)
	end
end)

-- LÓGICA AUTO BLOOD BAG
local TOOL_NAME = "Blood Bag"
local autoBloodActive = false

local function simularClick()
	pcall(function()
		if VirtualUser then
			VirtualUser:Button1Down(Vector2.new(0,0))
			task.wait(0.01)
			VirtualUser:Button1Up(Vector2.new(0,0))
		end
	end)
end

local function autoUseBlood()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local backpack = LocalPlayer:FindFirstChild("Backpack")
	
	if not humanoid or humanoid.Health <= 0 or not backpack then return end
	
	local tool = backpack:FindFirstChild(TOOL_NAME) or char:FindFirstChild(TOOL_NAME)
	
	if tool then
		if tool.Parent == backpack then
			humanoid:EquipTool(tool)
		end
		
		local remoteEvent = tool:FindFirstChildWhichIsA("RemoteEvent") or tool:FindFirstChild("ServerControl") or tool:FindFirstChild("Use")
		if remoteEvent then
			pcall(function() remoteEvent:FireServer() end)
		end
		
		if tool:IsA("Tool") then
			pcall(function() tool:Activate() end)
		end
		
		eliminarAnimacionesDeUso(char)
		simularClick()
	end
end

task.spawn(function()
	while true do
		task.wait(0.1)
		if autoBloodActive then
			local char = LocalPlayer.Character
			if char then
				local humanoid = char:FindFirstChildOfClass("Humanoid")
				if humanoid and humanoid.Health > 0 and humanoid.Health < 70 then
					autoUseBlood()
					eliminarAnimacionesDeUso(char)
				end
			end
		end
	end
end)

local BloodToggle = Instance.new("TextButton")
BloodToggle.Size = UDim2.new(0,elementWidth,0,30)
BloodToggle.Position = UDim2.new(0,elementPosX,0,15)
BloodToggle.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
BloodToggle.TextColor3 = Color3.fromRGB(220, 100, 100)
BloodToggle.Text = "Auto Blood Bag (<70 HP) : OFF"
BloodToggle.Font = Enum.Font.GothamMedium
BloodToggle.TextSize = 12
BloodToggle.Parent = BloodFrame

local BloodBtnCorner = Instance.new("UICorner")
BloodBtnCorner.CornerRadius = UDim.new(0, 8)
BloodBtnCorner.Parent = BloodToggle

local BloodBtnStroke = Instance.new("UIStroke")
BloodBtnStroke.Color = Color3.fromRGB(70, 40, 40)
BloodBtnStroke.Thickness = 1
BloodBtnStroke.Parent = BloodToggle

BloodToggle.MouseButton1Click:Connect(function()
	autoBloodActive = not autoBloodActive
	BloodToggle.Text = "Auto Blood Bag (<70 HP) : "..(autoBloodActive and "ON" or "OFF")
	if autoBloodActive then
		BloodToggle.TextColor3 = Color3.fromRGB(120, 220, 120)
		BloodBtnStroke.Color = Color3.fromRGB(40, 70, 40)
	else
		BloodToggle.TextColor3 = Color3.fromRGB(220, 100, 100)
		BloodBtnStroke.Color = Color3.fromRGB(70, 40, 40)
	end
end)

-- ============================================================
-- SKIP CRATE (Standalone) - INTEGRADO
-- ============================================================
local skipCrateEnabled = false

local CrateController
local Util

pcall(function()
    CrateController = require(ReplicatedStorage.Modules.Game.CrateSystem.Crate)
end)

pcall(function()
    Util = require(ReplicatedStorage.Modules.Core.Util)
end)

pcall(function()
    if Util and Util.tween then
        local origTween = Util.tween
        Util.tween = function(obj, info, target)
            if obj and obj:IsA("NumberValue") and target and target.Value ~= nil then
                obj.Value = target.Value
                return { Cancel = function() end }
            end
            return origTween(obj, info, target)
        end
    end
end)

pcall(function()
    local UtilModule = require(ReplicatedStorage.Modules.Core.Util)
    if UtilModule.tween then
        local old_tween = UtilModule.tween
        UtilModule.tween = function(instance, tweenInfo, properties, ...)
            if instance:IsA("NumberValue") and properties.Value == 1 then
                if tweenInfo.Time > 0 then
                    tweenInfo = TweenInfo.new(0, tweenInfo.EasingStyle, tweenInfo.EasingDirection, tweenInfo.RepeatCount, tweenInfo.Reverses, tweenInfo.DelayTime)
                end
            end
            return old_tween(instance, tweenInfo, properties, ...)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if skipCrateEnabled and CrateController then
            pcall(function()
                for _, crate in pairs(CrateController.class.objects) do
                    crate.states.open.set(true)
                    CrateController.skipping.set(true)
                end
            end)
        end
    end
end)

local AutoSkipToggle = Instance.new("TextButton")
AutoSkipToggle.Size = UDim2.new(0,elementWidth,0,30)
AutoSkipToggle.Position = UDim2.new(0,elementPosX,0,52)
AutoSkipToggle.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
AutoSkipToggle.TextColor3 = Color3.fromRGB(220, 100, 100)
AutoSkipToggle.Text = "Auto Skip Crate / Ammo : OFF"
AutoSkipToggle.Font = Enum.Font.GothamMedium
AutoSkipToggle.TextSize = 12
AutoSkipToggle.Parent = BloodFrame

local astCorner = Instance.new("UICorner")
astCorner.CornerRadius = UDim.new(0, 8)
astCorner.Parent = AutoSkipToggle
local astStroke = Instance.new("UIStroke")
astStroke.Color = Color3.fromRGB(70, 40, 40)
astStroke.Thickness = 1
astStroke.Parent = AutoSkipToggle

AutoSkipToggle.MouseButton1Click:Connect(function()
	skipCrateEnabled = not skipCrateEnabled
	AutoSkipToggle.Text = "Auto Skip Crate / Ammo : "..(skipCrateEnabled and "ON" or "OFF")
	if skipCrateEnabled then
		AutoSkipToggle.TextColor3 = Color3.fromRGB(120, 220, 120)
		astStroke.Color = Color3.fromRGB(40, 70, 40)
	else
		AutoSkipToggle.TextColor3 = Color3.fromRGB(220, 100, 100)
		astStroke.Color = Color3.fromRGB(70, 40, 40)
	end
end)

-- ============================================================
-- AUTO MINIGAME (ATM / Fishing) - Lento y preciso (ACTUALIZADO: 1 Solo Click)
-- ============================================================
local autoMinigameEnabled = false

local SliderModule
pcall(function()
    SliderModule = require(ReplicatedStorage.Modules.Game.Minigames.SliderMinigame)
end)

local function clickMouse()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    task.wait(0.03)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

task.spawn(function()
    while true do
        task.wait(0.04)
        if autoMinigameEnabled then
            if SliderModule and SliderModule.enabled and SliderModule.enabled.get() then
                local ok, current, target = pcall(function()
                    return SliderModule.needle_pos.get(), SliderModule.target_pos.get()
                end)
                
                if ok and typeof(current) == "number" and typeof(target) == "number" then
                    local diff = target - current
                    local speed = 0.12
                    local newPos = current + diff * speed
                    
                    pcall(function()
                        SliderModule.needle_pos.set(newPos)
                    end)
                    
                    if math.abs(diff) < 0.025 then
                        task.wait(0.06)
                        clickMouse()
                        task.wait(0.35)
                    end
                end
            end
        end
    end
end)

local AutoMinigameToggle = Instance.new("TextButton")
AutoMinigameToggle.Size = UDim2.new(0, elementWidth, 0, 30)
AutoMinigameToggle.Position = UDim2.new(0, elementPosX, 0, 89)
AutoMinigameToggle.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
AutoMinigameToggle.TextColor3 = Color3.fromRGB(220, 100, 100)
AutoMinigameToggle.Text = "Auto Minigame : OFF"
AutoMinigameToggle.Font = Enum.Font.GothamMedium
AutoMinigameToggle.TextSize = 12
AutoMinigameToggle.Parent = BloodFrame

local amtCorner = Instance.new("UICorner")
amtCorner.CornerRadius = UDim.new(0, 8)
amtCorner.Parent = AutoMinigameToggle
local amtStroke = Instance.new("UIStroke")
amtStroke.Color = Color3.fromRGB(70, 40, 40)
amtStroke.Thickness = 1
amtStroke.Parent = AutoMinigameToggle

AutoMinigameToggle.MouseButton1Click:Connect(function()
	autoMinigameEnabled = not autoMinigameEnabled
	AutoMinigameToggle.Text = "Auto Minigame : "..(autoMinigameEnabled and "ON" or "OFF")
	if autoMinigameEnabled then
		AutoMinigameToggle.TextColor3 = Color3.fromRGB(120, 220, 120)
		amtStroke.Color = Color3.fromRGB(40, 70, 40)
	else
		AutoMinigameToggle.TextColor3 = Color3.fromRGB(220, 100, 100)
		amtStroke.Color = Color3.fromRGB(70, 40, 40)
	end
end)

-- LÓGICA FPS BOOST
local fpsBoostEnabled = false

local function applyFpsBoost()
	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		settings().Rendering.EagerBulkExecution = true
		
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 999999
		Lighting.Brightness = 1
		Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
		Lighting.Ambient = Color3.fromRGB(128, 128, 128)
		
		for _, v in ipairs(Lighting:GetChildren()) do
			if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") or v:IsA("SunRaysEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("ColorCorrectionEffect") then
				v.Enabled = false
			end
		end
		
		for _, v in ipairs(Workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Material = Enum.Material.SmoothPlastic
				v.Reflectance = 0
				v.CastShadow = false
			elseif v:IsA("Decal") or v:IsA("Texture") then
				v.Transparency = 1
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("Beam") then
				v.Enabled = false
			elseif v:IsA("SpecialMesh") then
				v.TextureId = ""
			elseif v:IsA("Explosion") then
				v.Visible = false
			end
		end
	end)
end

local function removeFpsBoost()
	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
		Lighting.GlobalShadows = true
		Lighting.FogEnd = 100000
		Lighting.Brightness = 2
		for _, v in ipairs(Lighting:GetChildren()) do
			if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
				v.Enabled = true
			end
		end
	end)
end

-- FRIEND LIST EN BLOOD FRAME
local BloodFriendToggle = Instance.new("TextButton")
BloodFriendToggle.Size = UDim2.new(0,elementWidth,0,30)
BloodFriendToggle.Position = UDim2.new(0,elementPosX,0,126)
BloodFriendToggle.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
BloodFriendToggle.TextColor3 = Color3.fromRGB(220, 220, 220)
BloodFriendToggle.Text = "Friend List (Server Players)"
BloodFriendToggle.Font = Enum.Font.GothamMedium
BloodFriendToggle.TextSize = 12
BloodFriendToggle.Parent = BloodFrame

local bftCorner = Instance.new("UICorner")
bftCorner.CornerRadius = UDim.new(0, 8)
bftCorner.Parent = BloodFriendToggle
local bftStroke = Instance.new("UIStroke")
bftStroke.Color = Color3.fromRGB(60, 50, 30)
bftStroke.Thickness = 1
bftStroke.Parent = BloodFriendToggle

local BloodFriendFrame = Instance.new("ScrollingFrame")
BloodFriendFrame.ClipsDescendants = true
BloodFriendFrame.ScrollBarThickness = 3
BloodFriendFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)
BloodFriendFrame.Size = UDim2.new(0,elementWidth,0,110)
BloodFriendFrame.Position = UDim2.new(0,elementPosX,0,162)
BloodFriendFrame.CanvasSize = UDim2.new(0,0,0,0)
BloodFriendFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
BloodFriendFrame.BorderSizePixel = 0
BloodFriendFrame.Parent = BloodFrame
BloodFriendFrame.Visible = false

Instance.new("UICorner", BloodFriendFrame).CornerRadius = UDim.new(0, 8)
local bffstroke = Instance.new("UIStroke")
bffstroke.Color = Color3.fromRGB(60, 50, 30)
bffstroke.Thickness = 1
bffstroke.Parent = BloodFriendFrame

BloodFriendToggle.MouseButton1Click:Connect(function()
	BloodFriendFrame.Visible = not BloodFriendFrame.Visible
end)

local bflayout = Instance.new("UIListLayout")
bflayout.Parent = BloodFriendFrame

local function RefreshBloodFriends()
	for _,v in pairs(BloodFriendFrame:GetChildren()) do
		if v:IsA("TextButton") then v:Destroy() end
	end
 
	local sortedPlayers = Players:GetPlayers()
	table.sort(sortedPlayers,function(a,b) return a.Name:lower() < b.Name:lower() end)
 
	for _,plr in pairs(sortedPlayers) do
		if plr ~= LocalPlayer then
			local btn = Instance.new("TextButton")    
			btn.Size = UDim2.new(1, 0, 0, 24)    
			btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
			btn.TextColor3 = Color3.fromRGB(200, 200, 200)
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 11
			btn.Text = plr.Name    
			btn.Parent = BloodFriendFrame
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

			if ExcludedPlayers[plr.Name] then
				btn.TextColor3 = Color3.fromRGB(120, 220, 120)
				btn.BackgroundColor3 = Color3.fromRGB(20, 45, 20)
			else
				btn.TextColor3 = Color3.fromRGB(200, 200, 200)
				btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
			end
 
			btn.MouseButton1Click:Connect(function()    
				ExcludedPlayers[plr.Name] = not ExcludedPlayers[plr.Name]    
				if ExcludedPlayers[plr.Name] then    
					btn.TextColor3 = Color3.fromRGB(120, 220, 120)
					btn.BackgroundColor3 = Color3.fromRGB(20, 45, 20)
				else    
					btn.TextColor3 = Color3.fromRGB(200, 200, 200)
					btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
				end
			end)    
		end
	end
	task.wait()
	BloodFriendFrame.CanvasSize = UDim2.new(0,0,0,bflayout.AbsoluteContentSize.Y)
end
 
RefreshBloodFriends()
Players.PlayerAdded:Connect(RefreshBloodFriends)
Players.PlayerRemoving:Connect(RefreshBloodFriends)

-- BOTÓN DE SERVER HOP INTELIGENTE
local ServerHopBtn = Instance.new("TextButton")
ServerHopBtn.Size = UDim2.new(0,elementWidth,0,30)
ServerHopBtn.Position = UDim2.new(0,elementPosX,0,279)
ServerHopBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
ServerHopBtn.TextColor3 = Color3.fromRGB(240, 180, 80)
ServerHopBtn.Text = "Server Hop (Skins Robux / Pro)"
ServerHopBtn.Font = Enum.Font.GothamMedium
ServerHopBtn.TextSize = 12
ServerHopBtn.Parent = BloodFrame

local shbCorner = Instance.new("UICorner")
shbCorner.CornerRadius = UDim.new(0, 8)
shbCorner.Parent = ServerHopBtn
local shbStroke = Instance.new("UIStroke")
shbStroke.Color = Color3.fromRGB(60, 50, 30)
shbStroke.Thickness = 1
shbStroke.Parent = ServerHopBtn

ServerHopBtn.MouseButton1Click:Connect(function()
	ServerHopBtn.Text = "Buscando servidor con Robux skins..."
	
	task.spawn(function()
		local success, err = pcall(function()
			local cursor = ""
			local foundServers = {}
			
			repeat
				local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
				if cursor ~= "" then
					url = url .. "&cursor=" .. cursor
				end
				
				local req = game:HttpGet(url)
				local data = HttpService:JSONDecode(req)
				
				if data and data.data then
					for _, s in ipairs(data.data) do
						if type(s) == "table" and s.id ~= game.JobId and s.playing and s.maxPlayers then
							if s.playing >= 3 and s.playing < s.maxPlayers then
								table.insert(foundServers, s)
							end
						end
					end
					cursor = data.nextPageCursor
				else
					break
				end
			until cursor == nil or #foundServers >= 40
			
			if #foundServers > 0 then
				local randomServer = foundServers[math.random(1, #foundServers)]
				ServerHopBtn.Text = "¡Cambiando de servidor!"
				TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer.id, LocalPlayer)
			else
				ServerHopBtn.Text = "Redirigiendo a server..."
				TeleportService:Teleport(game.PlaceId, LocalPlayer)
			end
		end)
		
		if not success then
			pcall(function()
				ServerHopBtn.Text = "Reintentando salto..."
				TeleportService:Teleport(game.PlaceId, LocalPlayer)
			end)
		end
	end)
end)

-- BOTÓN DE ULTRA FPS BOOST EXTREMO
local FpsBoostBtn = Instance.new("TextButton")
FpsBoostBtn.Size = UDim2.new(0,elementWidth,0,30)
FpsBoostBtn.Position = UDim2.new(0,elementPosX,0,316)
FpsBoostBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
FpsBoostBtn.TextColor3 = Color3.fromRGB(160, 100, 255)
FpsBoostBtn.Text = "FPS Boost : OFF"
FpsBoostBtn.Font = Enum.Font.GothamMedium
FpsBoostBtn.TextSize = 12
FpsBoostBtn.Parent = BloodFrame

local fpbCorner = Instance.new("UICorner")
fpbCorner.CornerRadius = UDim.new(0, 8)
fpbCorner.Parent = FpsBoostBtn
local fpbStroke = Instance.new("UIStroke")
fpbStroke.Color = Color3.fromRGB(45, 35, 65)
fpbStroke.Thickness = 1
fpbStroke.Parent = FpsBoostBtn

FpsBoostBtn.MouseButton1Click:Connect(function()
	fpsBoostEnabled = not fpsBoostEnabled
	FpsBoostBtn.Text = "FPS Boost : "..(fpsBoostEnabled and "ON" or "OFF")
	
	if fpsBoostEnabled then
		FpsBoostBtn.TextColor3 = Color3.fromRGB(120, 220, 120)
		fpbStroke.Color = Color3.fromRGB(40, 70, 40)
		applyFpsBoost()
	else
		FpsBoostBtn.TextColor3 = Color3.fromRGB(160, 100, 255)
		fpbStroke.Color = Color3.fromRGB(45, 35, 65)
		removeFpsBoost()
	end
end)

-- BOTÓN DE SAVE CONFIGURACIÓN
local SaveConfigBtn = Instance.new("TextButton")
SaveConfigBtn.Size = UDim2.new(0,elementWidth,0,30)
SaveConfigBtn.Position = UDim2.new(0,elementPosX,0,353)
SaveConfigBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
SaveConfigBtn.TextColor3 = Color3.fromRGB(100, 220, 180)
SaveConfigBtn.Text = "Save Configuración"
SaveConfigBtn.Font = Enum.Font.GothamMedium
SaveConfigBtn.TextSize = 12
SaveConfigBtn.Parent = BloodFrame

local scbCorner = Instance.new("UICorner")
scbCorner.CornerRadius = UDim.new(0, 8)
scbCorner.Parent = SaveConfigBtn
local scbStroke = Instance.new("UIStroke")
scbStroke.Color = Color3.fromRGB(30, 60, 50)
scbStroke.Thickness = 1
scbStroke.Parent = SaveConfigBtn

SaveConfigBtn.MouseButton1Click:Connect(function()
	local dataToSave = {
		ExcludedPlayers = ExcludedPlayers,
		FpsBoost = fpsBoostEnabled
	}
	local success = pcall(function()
		local encoded = HttpService:JSONEncode(dataToSave)
		if writefile then
			writefile(CONFIG_FILE, encoded)
		end
	end)
	if success then
		SaveConfigBtn.Text = "¡Configuración Guardada!"
		task.wait(1.5)
		SaveConfigBtn.Text = "Save Configuración"
	else
		SaveConfigBtn.Text = "Error al Guardar"
		task.wait(1.5)
		SaveConfigBtn.Text = "Save Configuración"
	end
end)

-- ============================================================
-- DROPPED ITEMS ESP - Integrado
-- ============================================================
local droppedESPEnabled = false

local DropRarityColors = {
    Common    = Color3.fromRGB(255, 255, 255),
    Uncommon  = Color3.fromRGB(99, 255, 52),
    Rare      = Color3.fromRGB(51, 170, 255),
    Epic      = Color3.fromRGB(237, 44, 255),
    Legendary = Color3.fromRGB(255, 150, 0),
    Omega     = Color3.fromRGB(255, 20, 51),
}

local _dropItemRarityCache = {}
local function _buildDropRarityCache()
    _dropItemRarityCache = {}
    if not Items then return end
    for _, folder in ipairs(Items:GetChildren()) do
        if folder:IsA("Folder") then
            for _, item in ipairs(folder:GetChildren()) do
                _dropItemRarityCache[item.Name] = item:GetAttribute("RarityName") or "Common"
            end
        end
    end
end
pcall(_buildDropRarityCache)

local function getRarityColorForDrop(model)
    if model.Name == "Money" then
        return Color3.fromRGB(0, 255, 0)
    end
    local rarity = _dropItemRarityCache[model.Name]
    if not rarity then
        return Color3.fromRGB(255, 255, 255)
    end
    return DropRarityColors[rarity] or Color3.fromRGB(255, 255, 255)
end

local itemDrawings = {}

local function cleanupItemDrawings()
    for model, data in pairs(itemDrawings) do
        if not model or not model.Parent then
            pcall(function() data.circle:Remove() end)
            pcall(function() data.innerCircle:Remove() end)
            pcall(function() data.name:Remove() end)
            pcall(function() data.amount:Remove() end)
            if data.highlight then
                data.highlight:Destroy()
            end
            itemDrawings[model] = nil
        end
    end
end

local _espHbFrame = 0

RunService.Heartbeat:Connect(function()
    _espHbFrame = _espHbFrame + 1

    if _espHbFrame % 6 ~= 0 then return end

    if _espHbFrame % 300 == 0 then
        cleanupItemDrawings()
    end

    if not droppedESPEnabled or not DroppedItems then
        for _, data in pairs(itemDrawings) do
            if data.circle then data.circle.Visible = false end
            if data.innerCircle then data.innerCircle.Visible = false end
            if data.name then data.name.Visible = false end
            if data.amount then data.amount.Visible = false end
            if data.highlight then data.highlight.Enabled = false end
        end
        return
    end

    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    for _, data in pairs(itemDrawings) do
        if data.circle then data.circle.Visible = false end
        if data.innerCircle then data.innerCircle.Visible = false end
        if data.name then data.name.Visible = false end
        if data.amount then data.amount.Visible = false end
        if data.highlight then data.highlight.Enabled = false end
    end

    for _, model in ipairs(DroppedItems:GetChildren()) do
        if model:IsA("Model") and model:FindFirstChild("PickUpZone") and not model:GetAttribute("Locked") then
            local data = itemDrawings[model]
            if not data then
                data = {}
                data.circle = Drawing.new("Circle")
                data.circle.Thickness = 2
                data.circle.Transparency = 0.7
                data.circle.Filled = false

                data.innerCircle = Drawing.new("Circle")
                data.innerCircle.Thickness = 2
                data.innerCircle.Transparency = 1
                data.innerCircle.Filled = true

                data.name = Drawing.new("Text")
                data.name.Outline = true
                data.name.OutlineColor = Color3.fromRGB(0, 0, 0)
                data.name.Center = true
                data.name.Size = 16
                data.name.Font = 4

                data.amount = Drawing.new("Text")
                data.amount.Outline = true
                data.amount.OutlineColor = Color3.fromRGB(0, 0, 0)
                data.amount.Center = true
                data.amount.Size = 13
                data.amount.Color = Color3.fromRGB(200, 200, 200)

                itemDrawings[model] = data
            end

            if not data.highlight or not data.highlight.Parent then
                local h = Instance.new("Highlight")
                h.Name = "ESP_Highlight"
                h.FillTransparency = 0.5
                h.OutlineTransparency = 0.1
                h.Adornee = model
                h.Parent = model
                data.highlight = h
            end

            local pos, vis = Camera:WorldToViewportPoint(model.PickUpZone.Position)
            if vis then
                local color = getRarityColorForDrop(model)
                local radius = math.clamp(100 / math.max(pos.Z, 0.1), 3, 6)

                data.highlight.FillColor = color
                data.highlight.OutlineColor = color
                data.highlight.Enabled = true

                data.circle.Position = Vector2.new(pos.X, pos.Y)
                data.circle.Radius = radius + 5
                data.circle.Color = color
                data.circle.Visible = true

                data.innerCircle.Position = Vector2.new(pos.X, pos.Y)
                data.innerCircle.Radius = radius
                data.innerCircle.Color = color
                data.innerCircle.Visible = true

                data.name.Color = color
                data.name.Position = Vector2.new(pos.X, pos.Y - radius - 20)
                data.name.Text = model.Name
                data.name.Visible = true

                local amt = model:GetAttribute("Amount") or 1
                data.amount.Position = Vector2.new(pos.X, pos.Y + radius + 15)
                data.amount.Text = amt > 1 and ("[" .. tostring(amt) .. "]") or ""
                data.amount.Visible = amt > 1
            end
        end
    end
end)

local DropESPBtn = Instance.new("TextButton")
DropESPBtn.Size = UDim2.new(0, elementWidth, 0, 30)
DropESPBtn.Position = UDim2.new(0, elementPosX, 0, 390)
DropESPBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
DropESPBtn.TextColor3 = Color3.fromRGB(220, 100, 100)
DropESPBtn.Text = "Drop Items ESP : OFF"
DropESPBtn.Font = Enum.Font.GothamMedium
DropESPBtn.TextSize = 12
DropESPBtn.Parent = BloodFrame

local debCorner = Instance.new("UICorner")
debCorner.CornerRadius = UDim.new(0, 8)
debCorner.Parent = DropESPBtn
local debStroke = Instance.new("UIStroke")
debStroke.Color = Color3.fromRGB(70, 40, 40)
debStroke.Thickness = 1
debStroke.Parent = DropESPBtn

DropESPBtn.MouseButton1Click:Connect(function()
	droppedESPEnabled = not droppedESPEnabled
	DropESPBtn.Text = "Drop Items ESP : " .. (droppedESPEnabled and "ON" or "OFF")
	if droppedESPEnabled then
		DropESPBtn.TextColor3 = Color3.fromRGB(120, 220, 120)
		debStroke.Color = Color3.fromRGB(40, 70, 40)
	else
		DropESPBtn.TextColor3 = Color3.fromRGB(220, 100, 100)
		debStroke.Color = Color3.fromRGB(70, 40, 40)
	end
end)
 
local function healthColor(percent)
local r = 255*(1-percent)
local g = 255*percent
return Color3.fromRGB(r,g,0)
end
 
local RarityColors = {
	Common = Color3.fromRGB(255,255,255),
	Uncommon = Color3.fromRGB(0,255,0),
	Rare = Color3.fromRGB(0,170,255),
	Epic = Color3.fromRGB(170,0,255),
	Legendary = Color3.fromRGB(255,170,0),
	Mythic = Color3.fromRGB(255,0,0)
}

local Items = game:GetService("ReplicatedStorage"):WaitForChild("Items")
local WeaponRegistry = {}

local function registerItems(folder)
	for _,tool in ipairs(folder:GetChildren()) do
		if tool:IsA("Tool") then
			local handle = tool:FindFirstChild("Handle")
			local displayName = tool:GetAttribute("DisplayName") or tool.Name
			local itemId = tool:GetAttribute("ItemId") or tool:GetAttribute("Id") or tool.Name
			local rarity = tool:GetAttribute("RarityName") or "Common"
			local key

			if handle then
				local mesh = handle:FindFirstChildOfClass("SpecialMesh")
				if mesh and mesh.MeshId ~= "" then
					key = mesh.MeshId..(mesh.TextureId or "").."_RARITY_"..rarity
				elseif handle:IsA("MeshPart") and handle.MeshId ~= "" then
					key = handle.MeshId..(handle.TextureID or "").."_RARITY_"..rarity
				end
			end

			if not key and itemId and itemId ~= "" and itemId ~= tool.Name then
				key = "ITEMID_"..itemId.."_RARITY_"..rarity
			end

			if not key then
				key = "NAME_"..displayName.."_"..tool.Name.."_RARITY_"..rarity
			end

			WeaponRegistry[key] = {
				Name = displayName,
				Rarity = rarity,
				ToolName = tool.Name
			}
		end
	end
end

local function scanFolders(folder)
	registerItems(folder)
	folder.ChildAdded:Connect(function(child)
		task.wait(0.1)
		if child:IsA("Folder") then
			scanFolders(child)
		else
			registerItems(folder)
		end
	end)
	for _,child in ipairs(folder:GetChildren()) do
		if child:IsA("Folder") then scanFolders(child) end
	end
end

scanFolders(Items)

local function getItemKey(tool)
	local handle = tool:FindFirstChild("Handle")
	local displayName = tool:GetAttribute("DisplayName") or tool.Name
	local itemId = tool:GetAttribute("ItemId") or tool:GetAttribute("Id") or tool.Name
	local rarity = tool:GetAttribute("RarityName") or "Common"

	if handle then
		local mesh = handle:FindFirstChildOfClass("SpecialMesh")
		if mesh and mesh.MeshId ~= "" then
			return mesh.MeshId..(mesh.TextureId or "").."_RARITY_"..rarity
		end
		if handle:IsA("MeshPart") and handle.MeshId ~= "" then
			return handle.MeshId..(handle.TextureID or "").."_RARITY_"..rarity
		end
	end

	if itemId and itemId ~= "" and itemId ~= tool.Name then
		return "ITEMID_"..itemId.."_RARITY_"..rarity
	end

	return "NAME_"..displayName.."_"..tool.Name.."_RARITY_"..rarity
end

local function getWeaponInfo(tool)
	if not tool or not tool:IsA("Tool") then return nil end
	return WeaponRegistry[getItemKey(tool)]
end

local function getWeapons(player)
	local items = {}
	local function scan(container)
		if not container then return end
		for _,tool in ipairs(container:GetChildren()) do
			if tool:IsA("Tool") and tool.Name ~= "Fists" then
				local info = getWeaponInfo(tool)
				if info then
					table.insert(items,{Name = info.Name, Rarity = info.Rarity})
				end
			end
		end
	end
	scan(player:FindFirstChild("Backpack"))
	scan(player.Character)
	return items
end
 
local LockedTarget = nil
local CurrentTarget = nil

local function createESP(player)
if player == LocalPlayer then return end
 
local highlight = Instance.new("Highlight")
highlight.FillTransparency = 1
highlight.OutlineTransparency = 0
highlight.OutlineColor = Color3.fromRGB(255,255,0)
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.Parent = PlayerGui
 
local name = Drawing.new("Text")
name.Size = 13.75
name.Font = 0
name.Outline = true
name.Color = Color3.new(1,1,1)
 
local distance = Drawing.new("Text")
distance.Size = 12
distance.Outline = true
distance.Color = Color3.fromRGB(180,180,180)
 
local hp = Drawing.new("Text")
hp.Size = 12.75
hp.Outline = true
 
local weaponDrawings = {}
local last = 0
 
RunService.RenderStepped:Connect(function()
if tick() - last < UPDATE_DELAY then return end    
last = tick()    
 
local char = player.Character    
if not char then    
	highlight.Adornee = nil    
	name.Visible = false    
	distance.Visible = false    
	hp.Visible = false    
	for _,draw in pairs(weaponDrawings) do draw.Visible = false end
	return    
end    
 
local head = char:FindFirstChild("Head")    
local root = char:FindFirstChild("HumanoidRootPart")    
local humanoid = char:FindFirstChildOfClass("Humanoid")    
 
if not head or not root or not humanoid then    
	highlight.Adornee = nil    
	name.Visible = false    
	distance.Visible = false    
	hp.Visible = false    
	for _,draw in pairs(weaponDrawings) do draw.Visible = false end   
	return    
end

local safe = false
local safezones = {
	Vector3.new(-205.64,255.3,-223.4),    
	Vector3.new(-122.1,255.1,472.0),    
	Vector3.new(120.5,255.4,486.6),    
	Vector3.new(1049.5,255.0,-592.4),    
	Vector3.new(1183.3,255.2,-566.3),    
	Vector3.new(247.0,255.3,-270.0)
}
 
for _,zone in pairs(safezones) do
	local dist = (root.Position - zone).Magnitude    
	if dist <= 35 then safe = true break end
end

local dead = humanoid.Health <= 0 or humanoid:GetState() == Enum.HumanoidStateType.Dead

if PlayerESP and humanoid.Health > 0 then
	highlight.Adornee = char
	local isTarget = (CurrentTarget and CurrentTarget == player)

	name.Color = Color3.new(1,1,1)

	if isTarget then
		highlight.FillColor = Color3.fromRGB(255,0,0)
		highlight.FillTransparency = 0.35
		highlight.OutlineColor = Color3.fromRGB(255,0,0)
		name.Color = Color3.fromRGB(255,0,0)
	elseif ExcludedPlayers[player.Name] then
		highlight.FillTransparency = 1
		highlight.OutlineColor = Color3.fromRGB(0,255,0)
		name.Color = Color3.fromRGB(0,255,0)
	elseif safe then
		highlight.FillTransparency = 1
		highlight.OutlineColor = Color3.fromRGB(0,255,0)
	elseif dead then
		highlight.FillTransparency = 1
		highlight.OutlineColor = Color3.fromRGB(120,120,120)
	else
		highlight.FillTransparency = 1
		highlight.OutlineColor = Color3.fromRGB(255,255,0)
	end
else
	highlight.Adornee = nil
	name.Visible = false
	distance.Visible = false
	hp.Visible = false
	for _,draw in pairs(weaponDrawings) do draw.Visible = false end
	return
end

local headPos,headVis = Camera:WorldToViewportPoint(head.Position + Vector3.new(0,0.5,0))
local rootPos,rootVis = Camera:WorldToViewportPoint(root.Position - Vector3.new(0,2.3,0))
 
if not headVis or not rootVis or headPos.Z < 0 or rootPos.Z < 0 then    
	name.Visible = false    
	distance.Visible = false    
	hp.Visible = false    
	for _,draw in pairs(weaponDrawings) do draw.Visible = false end    
	return    
end    
 
local height = math.abs(headPos.Y-rootPos.Y)
local width = height/2    
local x = rootPos.X-width/2    
local y = headPos.Y    
 
local distanceFromPlayer = 0    
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then    
	distanceFromPlayer = (LocalPlayer.Character.HumanoidRootPart.Position-root.Position).Magnitude    
end    
 
local anchorX = x + width + 6    
local anchorY = (distanceFromPlayer > 25) and (y - 24.5) or (y - 12)
 
if NameESP then    
	name.Text = ocultarNombreEnTexto(player.Name)    
	name.Position = Vector2.new(anchorX,anchorY)    
	name.Visible = true    
else    
	name.Visible = false    
end    
 
if DistanceESP and LocalPlayer.Character then    
	local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")    
	if myRoot then    
		local dist = math.floor((myRoot.Position-root.Position).Magnitude)    
		distance.Text = dist.."m"    
		distance.Position = Vector2.new(anchorX,anchorY+12)    
		distance.Visible = true    
	end    
else    
	distance.Visible = false    
end    
 
if HealthESP then    
	local percent = humanoid.Health/humanoid.MaxHealth    
	local fixedHealth = math.max(0, humanoid.Health)    
    hp.Text = math.floor(fixedHealth).."/"..math.floor(humanoid.MaxHealth)    
	hp.Color = healthColor(percent)    
	hp.Position = Vector2.new(anchorX,anchorY+24)    
	hp.Visible = true    
else    
	hp.Visible = false    
end    
 
if WeaponESP then
	local items = getWeapons(player)
	for _,draw in pairs(weaponDrawings) do draw.Visible = false end

	for i,w in ipairs(items) do
		if not weaponDrawings[i] then
			local txt = Drawing.new("Text")
			txt.Size = 13.75
			txt.Center = true
			txt.Outline = true
			txt.Font = 2
			weaponDrawings[i] = txt
		end
		local draw = weaponDrawings[i]
		draw.Text = "["..w.Rarity.."] "..w.Name
		draw.Color = RarityColors[w.Rarity] or Color3.new(1,1,1)
		draw.Position = Vector2.new(x + width/2, y + height + 6 + ((i-1)*12))
		draw.Visible = true
	end
else
	for _,draw in pairs(weaponDrawings) do draw.Visible = false end
end
end)
end
 
for _,p in ipairs(Players:GetPlayers()) do createESP(p) end
Players.PlayerAdded:Connect(function(p) task.wait(1) createESP(p) end)
 
local function styleAimButton(btn, isToggle)
	btn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 12
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 8)
	c.Parent = btn
	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(45, 35, 65)
	s.Thickness = 1
	s.Parent = btn

	if isToggle then
		if btn.Text:find("ON") then
			btn.TextColor3 = Color3.fromRGB(120, 220, 120)
			s.Color = Color3.fromRGB(40, 70, 40)
		else
			btn.TextColor3 = Color3.fromRGB(220, 100, 100)
			s.Color = Color3.fromRGB(70, 40, 40)
		end
		btn.MouseButton1Click:Connect(function()
			if btn.Text:find("ON") then
				btn.TextColor3 = Color3.fromRGB(120, 220, 120)
				s.Color = Color3.fromRGB(40, 70, 40)
			else
				btn.TextColor3 = Color3.fromRGB(220, 100, 100)
				s.Color = Color3.fromRGB(70, 40, 40)
			end
		end)
	else
		btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	end
end

-- AIM SETTINGS & AIMBOT TORSO/CABEZA
local AimEnabled = false
local WallCheck = true
local ShowFOV = true
local FOVRadius = 200
local Smoothness = 1
local NoRecoilEnabled = false

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = true
FOVCircle.Radius = FOVRadius
FOVCircle.Color = Color3.fromRGB(160, 100, 255)
FOVCircle.Thickness = 1
FOVCircle.Filled = false

local TracerLine = Drawing.new("Line")
TracerLine.Visible = false

local function GetHitboxPosition(character)
	local head = character:FindFirstChild("Head")
	local upperTorso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
	
	if head and upperTorso then
		return (head.Position + upperTorso.Position) / 2
	elseif head then
		return head.Position
	end
	return nil
end
 
local function GetClosestPlayer()
	local Closest = nil
	local ClosestDistance = FOVRadius
 
	for _,plr in pairs(Players:GetPlayers()) do
		local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
		if plr ~= LocalPlayer and not ExcludedPlayers[plr.Name] and plr.Character and plr.Character:FindFirstChild("Head") and humanoid and humanoid.Health > 0 and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
			local hitPos = GetHitboxPosition(plr.Character)
			if hitPos then
				local pos,visible = Camera:WorldToViewportPoint(hitPos)    
 
				if visible then    
					local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
					local dist = (Vector2.new(pos.X,pos.Y) - center).Magnitude
 
					if dist < ClosestDistance then
						if WallCheck then    
							local rayParams = RaycastParams.new()    
							rayParams.FilterType = Enum.RaycastFilterType.Blacklist    
							rayParams.FilterDescendantsInstances = {LocalPlayer.Character}    
							local ray = workspace:Raycast(Camera.CFrame.Position, (hitPos - Camera.CFrame.Position).Unit * 500, rayParams)    
							if ray and not ray.Instance:IsDescendantOf(plr.Character) then continue end    
						end    
						ClosestDistance = dist    
						Closest = plr    
					end    
				end
			end
		end
	end
	LockedTarget = Closest 
	return Closest
end

local function limpiarRecoil(tool)
	if not NoRecoilEnabled then return end
	pcall(function()
		for _, v in ipairs(tool:GetDescendants()) do
			local nombre = v.Name:lower()
			if nombre:find("recoil") or nombre:find("shake") or nombre:find("kick") or nombre:find("spread") or nombre:find("bobble") then
				if v:IsA("NumberValue") or v:IsA("IntValue") then
					v.Value = 0
				elseif v:IsA("Vector3Value") then
					v.Value = Vector3.new(0, 0, 0)
				elseif v:IsA("Script") or v:IsA("LocalScript") then
					v.Disabled = true
				elseif v:IsA("ModuleScript") then
					pcall(function() require(v) end)
				end
			end
		end
		
		for attrName, _ in pairs(tool:GetAttributes()) do
			if attrName:lower():find("recoil") or attrName:lower():find("shake") or attrName:lower():find("spread") then
				tool:SetAttribute(attrName, 0)
			end
		end
	end)
end
 
RunService.RenderStepped:Connect(function()
	FOVCircle.Visible = ShowFOV
	FOVCircle.Radius = FOVRadius
	FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
 
	local target = GetClosestPlayer()
	LockedTarget = target
	CurrentTarget = target

	local targetHitboxPos = target and target.Character and GetHitboxPosition(target.Character)

	if NoRecoilEnabled then
		pcall(function()
			local char = LocalPlayer.Character
			if char then
				for _, tool in ipairs(char:GetChildren()) do
					if tool:IsA("Tool") then
						limpiarRecoil(tool)
					end
				end
			end
			local backpack = LocalPlayer:FindFirstChild("Backpack")
			if backpack then
				for _, tool in ipairs(backpack:GetChildren()) do
					if tool:IsA("Tool") then
						limpiarRecoil(tool)
					end
				end
			end
		end)
	end

	if Tracers and target and target.Character and targetHitboxPos then
		local pos, visible = Camera:WorldToViewportPoint(targetHitboxPos)

		if visible and pos.Z > 0 then
			TracerLine.Visible = true
			TracerLine.Thickness = 1
			TracerLine.Transparency = 1
			TracerLine.Color = Color3.fromRGB(160, 100, 255)
			TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
			TracerLine.To = Vector2.new(pos.X, pos.Y)
		else
			TracerLine.Visible = false
		end
	else
		TracerLine.Visible = false
	end
 
	if AimEnabled and target and target.Character and targetHitboxPos then
		local aimPosition = targetHitboxPos
		local camPos = Camera.CFrame.Position
		local localHumanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

		if localHumanoid and localHumanoid.SeatPart then
			aimPosition = aimPosition + Vector3.new(0, 0.4, 0)
			local velocity = LocalPlayer.Character.HumanoidRootPart.Velocity / 14
			aimPosition = aimPosition + velocity
		end

		Camera.CFrame = CFrame.lookAt(camPos, aimPosition)
	end
end)
 
-- AIM MENU CONTROLS
local AimToggle = Instance.new("TextButton")
AimToggle.Size = UDim2.new(0,elementWidth,0,30)
AimToggle.Position = UDim2.new(0,elementPosX,0,15)
AimToggle.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
AimToggle.TextColor3 = Color3.fromRGB(220, 100, 100)
AimToggle.Text = "Aim : OFF"
AimToggle.Parent = AimFrame
styleAimButton(AimToggle,true)
 
AimToggle.MouseButton1Click:Connect(function()
	AimEnabled = not AimEnabled
	AimToggle.Text = "Aim : "..(AimEnabled and "ON" or "OFF")
	if AimEnabled then
		FloatStroke.Color = Color3.fromRGB(120, 220, 120)
	else
		FloatStroke.Color = Color3.fromRGB(220, 100, 100)
	end
end)
 
local WallBtn = Instance.new("TextButton")
WallBtn.Size = UDim2.new(0,elementWidth,0,30)
WallBtn.Position = UDim2.new(0,elementPosX,0,52)
WallBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
WallBtn.TextColor3 = Color3.fromRGB(120, 220, 120)
WallBtn.Text = "WallCheck : ON"
WallBtn.Parent = AimFrame
styleAimButton(WallBtn,true)
 
WallBtn.MouseButton1Click:Connect(function()
	WallCheck = not WallCheck
	WallBtn.Text = "WallCheck : "..(WallCheck and "ON" or "OFF")
end)
 
local FOVBtn = Instance.new("TextButton")
FOVBtn.Size = UDim2.new(0,elementWidth,0,30)
FOVBtn.Position = UDim2.new(0,elementPosX,0,89)
FOVBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
FOVBtn.TextColor3 = Color3.fromRGB(120, 220, 120)
FOVBtn.Text = "FOV Circle : ON"
FOVBtn.Parent = AimFrame
styleAimButton(FOVBtn,true)
 
FOVBtn.MouseButton1Click:Connect(function()
	ShowFOV = not ShowFOV
	FOVBtn.Text = "FOV Circle : "..(ShowFOV and "ON" or "OFF")
end)
 
local RadiusBox = Instance.new("TextBox")
RadiusBox.Size = UDim2.new(0,elementWidth,0,30)
RadiusBox.Position = UDim2.new(0,elementPosX,0,126)
RadiusBox.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
RadiusBox.TextColor3 = Color3.fromRGB(200, 200, 200)
RadiusBox.PlaceholderText = "FOV Radius"
RadiusBox.Text = tostring(FOVRadius)
RadiusBox.Parent = AimFrame
styleAimButton(RadiusBox,false)
 
RadiusBox.FocusLost:Connect(function()
	local num = tonumber(RadiusBox.Text)
	if num then FOVRadius = num end
end)
 
local SmoothBox = Instance.new("TextBox")
SmoothBox.Size = UDim2.new(0,elementWidth,0,30)
SmoothBox.Position = UDim2.new(0,elementPosX,0,163)
SmoothBox.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
SmoothBox.TextColor3 = Color3.fromRGB(200, 200, 200)
SmoothBox.PlaceholderText = "Smooth"
SmoothBox.Text = tostring(Smoothness)
SmoothBox.Parent = AimFrame
styleAimButton(SmoothBox,false)
 
SmoothBox.FocusLost:Connect(function()
	local num = tonumber(SmoothBox.Text)
	if num then Smoothness = num end
end)
 
local BindButton = Instance.new("TextButton")
BindButton.Size = UDim2.new(0,elementWidth,0,30)
BindButton.Position = UDim2.new(0,elementPosX,0,200)
BindButton.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
BindButton.TextColor3 = Color3.fromRGB(200, 200, 200)
BindButton.Text = "Bind : F"
BindButton.Parent = AimFrame
styleAimButton(BindButton,false)
 
local WaitingBind = false
BindButton.MouseButton1Click:Connect(function()
	WaitingBind = true
	BindButton.Text = "Press any key..."
end)
 
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if WaitingBind then
		WaitingBind = false
		if input.UserInputType == Enum.UserInputType.Keyboard then
			AimKey = input.KeyCode
			BindButton.Text = "Bind : "..tostring(input.KeyCode):gsub("Enum.KeyCode.","")
		else
			if tostring(input.KeyCode) ~= "Enum.KeyCode.Unknown" then
				AimKey = input.KeyCode
				BindButton.Text = "Bind : "..tostring(input.KeyCode):gsub("Enum.KeyCode.","")
			else
				AimKey = input.UserInputType
				BindButton.Text = "Bind : "..tostring(input.UserInputType):gsub("Enum.UserInputType.","")
			end
		end
		return
	end

	if input.KeyCode == AimKey or input.UserInputType == AimKey then
		AimEnabled = not AimEnabled
		AimToggle.Text = "Aim : "..(AimEnabled and "ON" or "OFF")
		local stroke = AimToggle:FindFirstChildOfClass("UIStroke")

		if AimEnabled then
			FloatStroke.Color = Color3.fromRGB(120, 220, 120)
			FloatGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 220, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 120, 40))}
			AimToggle.TextColor3 = Color3.fromRGB(120, 220, 120)
			if stroke then stroke.Color = Color3.fromRGB(40, 70, 40) end
		else
			FloatStroke.Color = Color3.fromRGB(220, 100, 100)
			FloatGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 100, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 40, 180))}
			AimToggle.TextColor3 = Color3.fromRGB(220, 100, 100)
			if stroke then stroke.Color = Color3.fromRGB(70, 40, 40) end
		end
	end
end)

local AimPartLabel = Instance.new("TextLabel")
AimPartLabel.Size = UDim2.new(0,elementWidth,0,30)
AimPartLabel.Position = UDim2.new(0,elementPosX,0,237)
AimPartLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
AimPartLabel.TextColor3 = Color3.fromRGB(160, 100, 255)
AimPartLabel.Text = "Hitbox : Torso & Cabeza"
AimPartLabel.Font = Enum.Font.GothamMedium
AimPartLabel.TextSize = 12
AimPartLabel.Parent = AimFrame
styleAimButton(AimPartLabel, false)

local NoRecoilToggle = Instance.new("TextButton")
NoRecoilToggle.Size = UDim2.new(0,elementWidth,0,30)
NoRecoilToggle.Position = UDim2.new(0,elementPosX,0,274)
NoRecoilToggle.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
NoRecoilToggle.TextColor3 = Color3.fromRGB(220, 100, 100)
NoRecoilToggle.Text = "No Recoil : OFF"
NoRecoilToggle.Parent = AimFrame
styleAimButton(NoRecoilToggle, true)

NoRecoilToggle.MouseButton1Click:Connect(function()
	NoRecoilEnabled = not NoRecoilEnabled
	NoRecoilToggle.Text = "No Recoil : "..(NoRecoilEnabled and "ON" or "OFF")
end)

-- ============================================================
-- AUTO PICKUP STANDALONE + BOTÓN FLOTANTE MODERNO (INTEGRADO)
-- ============================================================
local Counter
pcall(function()
    for _, v in ipairs(getgc(true)) do
        if typeof(v) == "table" and rawget(v, "event") and rawget(v, "func") then
            Counter = v
            break
        end
    end
end)

local function netGet(...)
    if not Counter or not Counter.func then return end
    local args = {...}
    for i, v in ipairs(args) do
        if typeof(v) == "Instance" then
            if v:IsA("Model") and #v:GetChildren() == 0 then
                local dropped = Workspace:FindFirstChild("DroppedItems")
                if dropped then
                    local model = dropped:FindFirstChildWhichIsA("Model")
                    if model then
                        args[i] = model
                    else
                        return
                    end
                else
                    return
                end
            end
        end
    end
    Counter.func = (Counter.func or 0) + 1
    local get = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Get")
    return get:InvokeServer(Counter.func, unpack(args))
end

local autoPickupEnabled = false
local PICKUP_RANGE = 50 -- metros

-- Loop de Auto Pickup optimizado
task.spawn(function()
    while true do
        task.wait(0.2)
        if autoPickupEnabled then
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                for _, item in ipairs(DroppedItems:GetChildren()) do
                    if item:IsA("Model") and item:FindFirstChild("PickUpZone") then
                        if (item:GetPivot().Position - root.Position).Magnitude < PICKUP_RANGE then
                            pcall(netGet, "pickup_dropped_item", item)
                        end
                    end
                end
            end
        end
    end
end)

-- Botón Flotante Moderno para Auto Pickup
local AutoPickupGui = Instance.new("ScreenGui")
AutoPickupGui.Name = "AutoPickupToggleGui"
AutoPickupGui.ResetOnSpawn = false
AutoPickupGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
AutoPickupGui.Parent = CoreGui

local AutoPickupBtn = Instance.new("ImageButton")
AutoPickupBtn.Name = "AutoPickupButton"
AutoPickupBtn.Size = UDim2.new(0, 50, 0, 50)
AutoPickupBtn.Position = UDim2.new(0, 20, 0.5, 35)
AutoPickupBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
AutoPickupBtn.BorderSizePixel = 0
AutoPickupBtn.Active = true
AutoPickupBtn.Draggable = true
AutoPickupBtn.AutoButtonColor = false
AutoPickupBtn.Parent = AutoPickupGui

local AutoPickupIcon = Instance.new("ImageLabel")
AutoPickupIcon.Name = "Icon"
AutoPickupIcon.Size = UDim2.new(0, 26, 0, 26)
AutoPickupIcon.AnchorPoint = Vector2.new(0.5, 0.5)
AutoPickupIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
AutoPickupIcon.BackgroundTransparency = 1
AutoPickupIcon.Image = "rbxassetid://6031094678"
AutoPickupIcon.ImageColor3 = Color3.fromRGB(255, 80, 80)
AutoPickupIcon.Parent = AutoPickupBtn

local APCorner = Instance.new("UICorner")
APCorner.CornerRadius = UDim.new(0, 12)
APCorner.Parent = AutoPickupBtn

local APStroke = Instance.new("UIStroke")
APStroke.Color = Color3.fromRGB(255, 80, 80)
APStroke.Thickness = 2
APStroke.Parent = AutoPickupBtn

local APGradient = Instance.new("UIGradient")
APGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 55)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 28))
})
APGradient.Rotation = 45
APGradient.Parent = AutoPickupBtn

local function updateAutoPickupButton()
    local targetColor, targetBg
    if autoPickupEnabled then
        targetColor = Color3.fromRGB(80, 255, 120)
        targetBg = Color3.fromRGB(20, 45, 30)
    else
        targetColor = Color3.fromRGB(255, 80, 80)
        targetBg = Color3.fromRGB(25, 25, 35)
    end

    TweenService:Create(AutoPickupIcon, TweenInfo.new(0.2), {ImageColor3 = targetColor}):Play()
    TweenService:Create(APStroke, TweenInfo.new(0.2), {Color = targetColor}):Play()
    TweenService:Create(AutoPickupBtn, TweenInfo.new(0.2), {BackgroundColor3 = targetBg}):Play()
end

AutoPickupBtn.MouseButton1Click:Connect(function()
    autoPickupEnabled = not autoPickupEnabled
    updateAutoPickupButton()
    
    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(AutoPickupBtn, tweenInfo, {Size = UDim2.new(0, 44, 0, 44)}):Play()
    task.wait(0.1)
    TweenService:Create(AutoPickupBtn, tweenInfo, {Size = UDim2.new(0, 50, 0, 50)}):Play()
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.P then
        autoPickupEnabled = not autoPickupEnabled
        updateAutoPickupButton()
    end
end)

end
