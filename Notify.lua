local function Load(UiAsset)
	local Obj = game:GetObjects("rbxassetid://"..UiAsset)[1]
	Obj.Parent = game.CoreGui

	function GiveOwnGlobals(Func, Script)
		local Fenv = {}
		local RealFenv = {script = Script}
		local FenvMt = {}
		FenvMt.__index = function(a,b)
			if RealFenv[b] == nil then
				return getfenv()[b]
			else
				return RealFenv[b]
			end
		end
		FenvMt.__newindex = function(a, b, c)
			if RealFenv[b] == nil then
				getfenv()[b] = c
			else
				RealFenv[b] = c
			end
		end
		setmetatable(Fenv, FenvMt)
		setfenv(Func, Fenv)
		return Func
	end
	function LoadScripts(Script)
		if Script.ClassName == "Script" or Script.ClassName == "LocalScript" and Script.Disabled == false then
			task.spawn(function()
				GiveOwnGlobals(loadstring(Script.Source, "=" .. Script:GetFullName()), Script)()
			end)
		end
	end
	for i,v in pairs(Obj:GetDescendants()) do 
		LoadScripts(v)
	end
	return Obj
end

return Load(13130986689)
