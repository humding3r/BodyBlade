extends Node

# Emitted when the sword is thrown. Used to deactivate the sword scene and activate the thrown_sword scene.
signal sword_thrown

# Emitted when the sword is retrieved. Used to activate the sword scene and deactivate the thrown_sword scene.
signal sword_retrieved
