package;

import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class FreeplayCards extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(0, sprTracker.y);
	}

	private var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String) {
		if(this.char != char) {
			var name:String = 'fallmen/Freeplay/Cards' + char;
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'fallmen/Freeplay/Cards/' + char; //Older versions of psych engine's support
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'fallmen/Freeplay/Cards/Locked'; //Older versions of psych engine's support
			var file:Dynamic = Paths.image(name);

			loadGraphic(file); //Load stupidly first for getting the file size
			updateHitbox();

			this.char = char;
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = 0;
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String {
		return char;
	}
}
