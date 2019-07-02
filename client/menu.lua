--menu.lua

local composer = require("composer")
local scene = composer.newScene()

local function gotoGame()
    composer.gotoScene("game")
end

local function enterServerAddress()
end

function scene:create(event)
    local sceneGroup = self.view
    local background = display.newImageRect(sceneGroup, "menubckg.jpg", 800, 1400)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local serverText = display.newText(sceneGroup, "Ingresar dirección del servidor", display.contentCenterX, display.contentCenterY - 20, native.systemFont, 20 )
    local gameText = display.newText(sceneGroup, "Jugar", display.contentCenterX, display.contentCenterY + 50, native.systemFont, 20 )

    

    serverText:addEventListener("tap", enterServerAddress)
    gameText:addEventListener("tap", gotoGame)
end

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene