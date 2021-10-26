local MainScene = require "scenes.MainScene"
local Credits = require "scenes.Credits" 
local SceneHandler = {}

function SceneHandler:new(sceneIndex, object)
    object = object or
	{
		Scenes = {
			[1] = MainScene, 
			[2] = Credits
		},
		SceneIndex = 1 or sceneIndex
	}
    setmetatable(object, self)
    self.__index = self
    return object
end

function SceneHandler:setScene(numIndex) 
	self.SceneIndex = numIndex
end

function SceneHandler:curScene()
	return self.Scenes[self.SceneIndex]
end

return SceneHandler
