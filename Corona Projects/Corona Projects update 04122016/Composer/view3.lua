local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view
    print("Scene #3 : create")
end

local function showScene()
    composer.gotoScene("view1", {effect = "fade", time = 500})
end

local function screenTouched( event )
   local phase = event.phase
   local xStart = event.xStart
   local xEnd = event.x
   local swipelLength = math.abs(xEnd - xStart)
   if(phase=='began')then
        return true
    elseif(phase=='ended' or phase=='cancelled') then
        if(xStart > xEnd and swipelLength > 50) then
            composer.gotoScene('view1', {effect = "fromRight", time = 500})
        elseif(xStart < xEnd and swipelLength > 50) then
            composer.gotoScene("view2", {effect = "fromLeft", time = 500})
        end
   end   
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then
        print("Scene #3: show (will)")
        background = display.setDefault("background", 0, 0, 1)
        myText = display.newText("View #3", 160, 240 -50, "Arial", 50)
        sceneGroup:insert(myText)
    elseif (phase == "did") then
        print("Scene #3 :show (did)")
        --timer.performWithDelay(1000, showScene)
        Runtime:addEventListener('touch', screenTouched)
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then
        print("Scene #3 : hide (will)")
        myText:removeSelf()
        myText = nil
        Runtime:removeEventListener('touch', screenTouched)
    elseif (phase == "did") then
        print("Scene #3 : hide (did)")
    end
end

function scene:distroy(event)
    local sceneGroup = self.view
    local phase = event.phase
    print("Scene #3 : destroy (will)")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
