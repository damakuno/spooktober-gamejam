local Shop = {}

function Shop:new(x, y, width, height, image, object)
    if width == nil then width = image.width end
    if height == nil then height = image.height end
    object = object or {
        x = x,
        y = y,
        width = width,
        height = height,
        image = image,        
        visible = true
    }
    setmetatable(object, self)
    self.__index = self    
    return object
end

function Shop:draw()
    if self.visible ~= true then return end
	self.image:draw(self.x, self.y)
end

return Shop
