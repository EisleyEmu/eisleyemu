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
        {"What is special about this server?", "server"}, 
    }
}
eisleyemu_newbie_helper_conversation:addScreen(eisleyemu_newbie_helper_first_screen);

eisleyemu_newbie_helper_server = ConvoScreen:new {
    id = "server",
    leftDialog = "",
    customDialogText = "EisleyEmu aims to restore the original Star Wars Galaxies experience. We are built on the code of SWGEmu, with a few minor adjustments and additions. Additionally, the server is located in Europe, providing a new home for all European SWG fans. For more detailed information and regular updates, feel free to join our Discord.",
    stopConversation = "false",
    options = { 
        {"Thanks. I need some more informations...", "first_screen"}, 
    }
}
eisleyemu_newbie_helper_conversation:addScreen(eisleyemu_newbie_helper_server);

addConversationTemplate("eisleyemu_newbie_helper_conversation", eisleyemu_newbie_helper_conversation);