# /assets

All of the images, music and such for the game. 
# /data

All of the `.tres` files for game objects that need them, grouped by entity. 
# /entities

All of the code for the game objects. Currently that's rooms and events. Right now it also includes the tech tree for some reason, which I guess is arguably an entity. It should include state managers. 
# /generated

Generated code. Currently specifically for the resource groups generated code. 
# /scripts

General helper code that doesn't belong in another place. Specifically scripts that aren't associated with an actual game object. 
# /tools

Code to be used for game dev in some way.

# /ui

The primary panels for the game, including the top level GUI component. 
# /widgets

Reusable UI elements. 
# /

The main entry points for the game. UI, state, theming. This should probably include as little as possible. 