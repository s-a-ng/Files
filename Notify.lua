local BannerNotification = Instance.new("ScreenGui")
local ActiveNotifications = Instance.new("Folder")
local List = Instance.new("UIListLayout")
local Canvas = Instance.new("Frame")
local Background = Instance.new("ImageLabel")
local Scale = Instance.new("UIScale")
local Size = Instance.new("UISizeConstraint")


BannerNotification.Name = "BannerNotification"
BannerNotification.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
BannerNotification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BannerNotification.DisplayOrder = 100
BannerNotification.ResetOnSpawn = false

ActiveNotifications.Name = "ActiveNotifications"
ActiveNotifications.Parent = BannerNotification

List.Name = "List"
List.Parent = ActiveNotifications
List.HorizontalAlignment = Enum.HorizontalAlignment.Center
List.SortOrder = Enum.SortOrder.LayoutOrder

Canvas.Name = "Canvas"
Canvas.Parent = BannerNotification
Canvas.AnchorPoint = Vector2.new(0.5, 0)
Canvas.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Canvas.BackgroundTransparency = 1.000
Canvas.BorderSizePixel = 0
Canvas.Position = UDim2.new(0.5, 0, 0, 0)
Canvas.Size = UDim2.new(0.294520557, 0, 0.131510422, 0)
Canvas.Visible = false

Background.Name = "Background"
Background.Parent = Canvas
Background.AnchorPoint = Vector2.new(0.5, 0.5)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 1.000
Background.BorderColor3 = Color3.fromRGB(27, 42, 53)
Background.BorderSizePixel = 0
Background.Position = UDim2.new(0.5, 0, 0.5, 0)
Background.Size = UDim2.new(1, 0, 0.600000024, 0)
Background.Image = "rbxassetid://11983017276"
Background.ImageColor3 = Color3.fromRGB(0, 0, 0)
Background.ImageTransparency = 0.300
Background.ScaleType = Enum.ScaleType.Slice
Background.SliceCenter = Rect.new(512, 512, 512, 512)

Scale.Name = "Scale"
Scale.Parent = Background

Size.Name = "Size"
Size.Parent = Canvas
Size.MaxSize = Vector2.new(350, 101)
Size.MinSize = Vector2.new(350, 101)



local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local info = TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)

local notificationUi = BannerNotification

local activatedFolder = notificationUi.ActiveNotifications
local canvasTemplate = notificationUi.Canvas

local Config = {
	Circle = "rbxassetid://11983017276",
	Square = "rbxassetid://11942813307",
	BackgroundTransparency = 0.3,
	ContentTransparency = 0
}

local function PlayTween(...)
	TweenService:Create(...):Play()

end


function Notify(header, message, icon, duration)
	notificationUi.Enabled = true

	canvasTemplate.Background.Size = UDim2.fromScale(.18, .6)
	canvasTemplate.Background.ImageTransparency = 1
	canvasTemplate.Background.Scale.Scale = 0

	canvasTemplate.Content.GroupTransparency = 1


	local NotificationFrame = canvasTemplate:Clone()
	NotificationFrame.Name = header
	NotificationFrame.Parent = activatedFolder
	NotificationFrame.Visible = true

	local Content = NotificationFrame.Content
	Content.Header.Text = header
	Content.Message.Text = message
	Content.Icon.Image = icon

	local Background = NotificationFrame.Background

	Background.Image = Config.Circle

	PlayTween(Background, info, {ImageTransparency = Config.BackgroundTransparency})
	PlayTween(Background.Scale, info, {Scale = 1.2})

	task.wait(.3)

	Background.Image = Config.Square

	PlayTween(Background, info, {Size = UDim2.fromScale(1, .6)})
	PlayTween(Background.Scale, info, {Scale = 1})

	task.wait(.1)

	PlayTween(Content, info, {GroupTransparency = Config.ContentTransparency})

	task.wait(duration)

	PlayTween(Content, info, {GroupTransparency = 1})

	task.wait(.3)

	Background.Image = Config.Circle

	PlayTween(Background, info, {Size = UDim2.fromScale(.18, .6)})
	PlayTween(Background.Scale, info, {Scale = 1.2})

	task.wait(.3)

	PlayTween(Background, info, {ImageTransparency = 1})
	PlayTween(Background.Scale, info, {Scale = 0})

	task.wait(.3)

	NotificationFrame:Destroy()
end

return Notify
