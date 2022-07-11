package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class ThanksState extends MusicBeatState
{
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/thanks'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.screenCenter();
		add(bg);

		var idle:FlxSprite;
		idle = new FlxSprite(817, 250);
		idle.frames = Paths.getSparrowAtlas('fallmen/MainMenu/NewFallGuyIdle');
		idle.scrollFactor.x = 0;
		idle.scrollFactor.y = 0;
		idle.antialiasing = ClientPrefs.globalAntialiasing;
		idle.scale.set(0.29, 0.29);
		idle.animation.addByPrefix('play', 'fgIdle', 24, true);
		idle.updateHitbox();
		idle.animation.play('play');
		add(idle);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		if (controls.ACCEPT)
		{
			FlxG.save.data.DemoScreenSeen = true;
			MusicBeatState.switchState(new MainMenuState());
		}
		if (controls.BACK)
		{
			FlxG.save.data.DemoScreenSeen = true;
			MusicBeatState.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
