package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey there, looks like you're running an   \n
			outdated version of Friday Night Fallin' (v" + MainMenuState.fallinVersion + "),\n
			please update to v" + TitleState.updateVersion + "!\n
			\n
			Press B to Download on Gamebanana.\n
			Press J to Download on Gamejolt.\n
			Press ENTER to proceed anyway.\n
			\n
			Thank you for playing the mod!",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.antialiasing = ClientPrefs.globalAntialiasing;
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		if(!leftState) {
			if (FlxG.keys.justPressed.B)
			{
				CoolUtil.browserLoad("https://gamebanana.com/mods/345834");
			}
			else if (FlxG.keys.justPressed.J)
			{
				CoolUtil.browserLoad("https://gamejolt.com/games/friday-night-fallin/674663");
			}
			else if (controls.ACCEPT)
			{
				leftState = true;
			}
			else if (controls.BACK)
			{
				leftState = true;
			}

			if(leftState)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
