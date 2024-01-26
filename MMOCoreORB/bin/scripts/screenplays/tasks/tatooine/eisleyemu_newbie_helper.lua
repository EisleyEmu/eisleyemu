EisleyEmuNewbieHelper = ScreenPlay:new {                
    numberOfActs = 1,                
    questString = "eisleyemu_newbie_helper_task",                   
    states = {}, 
}
registerScreenPlay("EisleyEmuNewbieHelper", true)
function EisleyEmuNewbieHelper:start()     
    -- Spawn our character into the world, setting pNewbieHelper a pointer variable we can use to check or change his state.       
    local pNewbieHelper = spawnMobile("tatooine", "eisleyemu_newbie_helper", 1, 3529, 5, -4811, 35, 0 )
end
eisleyemu_newbie_helper_conversation_handler = Object:new {
    tstring = "myconversation" 
}
function eisleyemu_newbie_helper_conversation_handler:getNextConversationScreen(conversationTemplate, conversingPlayer, selectedOption)            
        -- Assign the player to variable creature for use inside this function.
        local creature = LuaCreatureObject(conversingPlayer)
        -- Get the last conversation to determine whether or not we’re on the first screen      
        local convosession = creature:getConversationSession()  
        lastConversation = nil      
        local conversation = LuaConversationTemplate(conversationTemplate)  
        local nextConversationScreen     
        -- If there is a conversation open, do stuff with it        
        if ( conversation ~= nil ) then  -- check to see if we have a next screen   
            if ( convosession ~= nil ) then             
                local session = LuaConversationSession(convosession)
                if ( session ~= nil ) then                  
                    lastConversationScreen = session:getLastConversationScreen()   
                end         
            end         
            -- Last conversation was nil, so get the first screen
            if ( lastConversationScreen == nil ) then          
                nextConversationScreen = conversation:getInitialScreen()
            end
        end
        -- end of the conversation logic.
        return nextConversationScreen
    end
    function eisleyemu_newbie_helper_conversation_handler:runScreenHandlers(conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen)
    -- Plays the screens of the conversation.
    return conversationScreen
end