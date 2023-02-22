import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class ExitGameSubState extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var alphabetArray:Array<Alphabet> = [];
	var icon:HealthIcon;
	var onYes:Bool = false;
	var yesText:Alphabet;
	var noText:Alphabet;

	public function new()
	{
		super();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		var text:Alphabet = new Alphabet(0, 180, "Exit Game?", true);
		text.scrollFactor.x = 0;
		text.scrollFactor.y = 0;
		text.screenCenter(X);
		alphabetArray.push(text);
		text.alpha = 0;
		add(text);

		yesText = new Alphabet(0, text.y + 150, 'Yes', true);
		yesText.scrollFactor.x = 0;
		yesText.scrollFactor.y = 0;
		yesText.screenCenter(X);
		yesText.x -= 200;
		add(yesText);
		noText = new Alphabet(0, text.y + 150, 'No', true);
		noText.scrollFactor.x = 0;
		noText.scrollFactor.y = 0;
		noText.screenCenter(X);
		noText.x += 200;
		add(noText);
		updateOptions();
	}

	override function update(elapsed:Float)
	{
		bg.alpha += elapsed * 1.5;
		if(bg.alpha > 0.6) bg.alpha = 0.6;

		for (i in 0...alphabetArray.length) {
			var spr = alphabetArray[i];
			spr.alpha += elapsed * 2.5;
		}

		if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
			FlxG.sound.play(Paths.sound('scrollMenu'), 1);
			onYes = !onYes;
			updateOptions();
		}
		else if (controls.ACCEPT)
		{
			if (onYes)
			{
				Sys.exit(0);
			}
			else
			{
				FlxG.sound.play(Paths.sound('cancelMenu'), 1);
				close();
			}
		}
		new FlxTimer().start(0.0001, function(tmr:FlxTimer)
		{
			if (controls.BACK)
			{
				close();
				FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			}
		});
		super.update(elapsed);
	}

	function updateOptions() {
		var scales:Array<Float> = [0.75, 1];
		var alphas:Array<Float> = [0.6, 1.25];
		var confirmInt:Int = onYes ? 1 : 0;

		yesText.alpha = alphas[confirmInt];
		yesText.scale.set(scales[confirmInt], scales[confirmInt]);
		noText.alpha = alphas[1 - confirmInt];
		noText.scale.set(scales[1 - confirmInt], scales[1 - confirmInt]);
	}
}