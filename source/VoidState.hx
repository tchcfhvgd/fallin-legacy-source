package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class VoidState extends MusicBeatState
{
	var titleText:FlxSprite;

	override function create()
	{
		FlxG.sound.playMusic(Paths.music('void'));

		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('fallmen/Void/entry'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.screenCenter();
		add(bg);

		titleText = new FlxSprite(150, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('fallmen/Void/entryenter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = ClientPrefs.globalAntialiasing;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);
		add(titleText);
	}

	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		var selectedSomethinvoid:Bool = false;

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (FlxG.keys.justPressed.ENTER && !transitioning)
		{
			transitioning = true;
			FlxG.save.data.DemoFreeplaySong4 = true;
			new FlxTimer().start(5, function(tmr:FlxTimer)
			{
				PlayState.SONG = Song.loadFromJson('rap-battle', 'rap-battle');
				PlayState.isStoryMode = false;
				LoadingState.loadAndSwitchState(new PlayState());
				function endSong():Void
				FlxG.sound.music.onComplete = endSong;
				FlxG.switchState(new PlayState());
			});

			var blackScreen:FlxSprite = new FlxSprite().makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
			add(blackScreen);

			FlxG.sound.music.volume = 0;

			if (FlxG.save.data.flashing)
				titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('bing'), 0.7);
		}

		super.update(elapsed);
	}
}
