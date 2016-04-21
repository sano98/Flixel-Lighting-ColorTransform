# TestProject

Goal of this project is to prove the concept of doing dynamic atmospheric lighting in haxeFlixel through the follwing means:

1. Selected FlxSprites and FlxTilemaps are darkened through a colorTransorm. This method is superior to the classical approach of 
putting a layer of darkness over the whole screen, as it allows for selective areas to be darkened in fron of a bright background
(E.g. a dark figure standing indoor in front of a bright window)

2. In order to achieve lighting, the intersection between light source and target object is taken. In this intersection area,
the original, unmodified pixels from before the colorTransform are copied, via a alpha masking process.

While the process already works for static sprites, it is not yet successful for Tilemaps (because I was not yet able to access the
resulting bitmap data of a FlxTilemap) or for animated sprites (because somehow the manipulation of the framepixels does not have 
the desired effect).

Input is greatly appreciated!
