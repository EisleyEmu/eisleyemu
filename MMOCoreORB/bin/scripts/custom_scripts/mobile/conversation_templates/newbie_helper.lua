eisleyemu_newbie_helper_conversation = ConvoTemplate:new {
    initialScreen = "first_screen",
    templateType = "Lua",
    luaClassHandler = "eisleyemu_newbie_helper_conversation_handler",
    screens = {}
}

eisleyemu_newbie_helper_first_screen = ConvoScreen:new {
    id = "first_screen",
    leftDialog = "",
    customDialogText = "Welcome to our EisleyEmu Server! How can I help you?",
    stopConversation = "false",
    options = { 
        {"Speederbike – 10,000", "speederbike"}, 
        {"I'm fine, thank you!.", "deny_quest"}, 
    }
}
eisleyemu_newbie_helper_conversation:addScreen(eisleyemu_newbie_helper_first_screen);

eisleyemu_newbie_helper_accept_quest = ConvoScreen:new {    
    id = "speederbike",
    leftDialog = "",
    customDialogText = "Enjoy that Speederbike!",
    stopConversation = "true",
    options = { }
}
eisleyemu_newbie_helper_conversation:addScreen(eisleyemu_newbie_helper_accept_quest);

eisleyemu_newbie_helper_deny_quest = ConvoScreen:new {
    id = "deny_quest",
    leftDialog = "",
    customDialogText = "Well, ya’ll have a nice day. Ya hear!",
    stopConversation = "true",
    options = { }
}
eisleyemu_newbie_helper_conversation:addScreen(eisleyemu_newbie_helper_deny_quest);

eisleyemu_newbie_helper_insufficient_funds = ConvoScreen:new {
    id = "insufficient_funds",  
    leftDialog = "", 
    customDialogText = "Sorry, but you don’t have enough credits with you to purchase that. Head on over to the bank. I’ll be here when ya get back!",
    stopConversation = "true",
    options = { }
}
eisleyemu_newbie_helper_conversation:addScreen(eisleyemu_newbie_helper_insufficient_funds);

eisleyemu_newbie_helper_insufficient_space = ConvoScreen:new {
    id = "insufficient_space",
    leftDialog = "", 
    customDialogText = "Sorry, but you don’t have enough space in your inventory to accept the item. Please make some space and try again.",    
    stopConversation = "true",  
    options = { }
}
eisleyemu_newbie_helper_conversation:addScreen(eisleyemu_newbie_helper_insufficient_space);

addConversationTemplate("eisleyemu_newbie_helper_conversation", eisleyemu_newbie_helper_conversation);