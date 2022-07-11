package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.input.keyboard.FlxKeyboard;
import flixel.input.keyboard.FlxKey;
import lime.utils.Assets;


#if windows
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];
	
	var scoreBG:FlxSprite;
	var selector:FlxText;
	var riddleText:FlxText;
	var curSelected:Int = 0;
	var curDifficulty:Int = 1;
	var weekbeaten:Int = 1;
	var goku:Bool = false;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;
	private static var lastDifficultyName:String = '';
	private var camGame:FlxCamera;

	private var iconArray:Array<HealthIcon> = [];

	var pogoStick:Array<Dynamic> = [
	[FlxKey.I, FlxKey.A], 
	[FlxKey.M], 
	[FlxKey.P, FlxKey.O], 
	[FlxKey.O, FlxKey.N], 
	[FlxKey.S, FlxKey.G],
	[FlxKey.T, FlxKey.SPACE],
	[FlxKey.O, FlxKey.U],
	[FlxKey.R, FlxKey.S],
	[FlxKey.ENTER]];
	var pogoStickJoe:Int = 0;

	override function create()
	{
		if (FlxG.save.data.DemoFreeplaySong2 == true && FlxG.save.data.DemoFreeplaySong3 == true && FlxG.save.data.DemoFreeplaySong4 == true)
		{
			var initSonglist:Array<String> = ['Bean Bam:fall-guy', 'Earthquake:fall-guy', 'Bombshell:fall-guy', 'Rap Battle:rapguy', ''];

			for (i in 0...initSonglist.length)
			{
				var data:Array<String> = initSonglist[i].split(':');
				songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
			}
		}
		else if (FlxG.save.data.DemoFreeplaySong2 == true && FlxG.save.data.DemoFreeplaySong3 == true)
		{
			var initSonglist:Array<String> = ['Bean Bam:fall-guy', 'Earthquake:fall-guy', 'Bombshell:fall-guy', '???:rapguy-locked', ''];

			for (i in 0...initSonglist.length)
			{
				var data:Array<String> = initSonglist[i].split(':');
				songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
			}
		}
		else if (FlxG.save.data.DemoFreeplaySong2 == true)
		{
			var initSonglist:Array<String> = ['Bean Bam:fall-guy', 'Earthquake:fall-guy', '???:fall-guy-locked', '???:rapguy-locked', ''];

			for (i in 0...initSonglist.length)
			{
				var data:Array<String> = initSonglist[i].split(':');
				songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
			}
		}
		else
		{
			var initSonglist:Array<String> = ['Bean Bam:fall-guy', '???:fall-guy-locked', '???:fall-guy-locked', '???:rapguy-locked', ''];

			for (i in 0...initSonglist.length)
			{
				var data:Array<String> = initSonglist[i].split(':');
				songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
			}
		}

		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);

		 #if windows
		 // Updating Discord Rich Presence
		 DiscordClient.changePresence("In the Freeplay Menu", null);
		 #end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/menuBGBlue'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		if(FlxG.save.data.mainshowwon == true)
			{
				weekbeaten = 0;
			}

		for (i in 0...songs.length - weekbeaten)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;
			icon.antialiasing = ClientPrefs.globalAntialiasing;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		scoreText.antialiasing = ClientPrefs.globalAntialiasing;

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		diffText.antialiasing = ClientPrefs.globalAntialiasing;
		add(diffText);

		add(scoreText);

		if(curSelected >= songs.length) curSelected = 0;
		
		changeSelection();
		changeDiff();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		selector.antialiasing = ClientPrefs.globalAntialiasing;
		// add(selector);

		riddleText = new FlxText(0, 270, FlxG.width, "", 0);
		riddleText.setFormat(Paths.font("vcr.ttf"), 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		riddleText.scrollFactor.set();
		riddleText.borderSize = 1.875;
		riddleText.text = "";
		riddleText.screenCenter(X);
		riddleText.antialiasing = ClientPrefs.globalAntialiasing;
		add(riddleText);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));
			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;
			FlxG.stage.addChild(texFel);
			// scoreText.textField.htmlText = md;
			trace(md);
		 */

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter));
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['dad'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);

			if (songCharacters.length != 1)
				num++;
		}
	}
	
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		positionHighscore();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);

		var shiftMult:Int = 1;

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		else if (accepted && pogoStickJoe == 5)
		{
		}
		else if (accepted && pogoStickJoe == 8)
		{
		}
		else if (accepted)
		{
			if (poop == '???')
			{
				FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.3));
				camGame.shake(0.005, 0.2);
				trace('no <3');
			}
			else
			{
				trace(poop);
				FlxG.sound.music.volume = 0;
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;
				PlayState.storyWeek = songs[curSelected].week;
				trace('CUR WEEK' + PlayState.storyWeek);
				LoadingState.loadAndSwitchState(new PlayState());
			}
		}

		if(FlxG.keys.pressed.SHIFT) shiftMult = 1;

			if (upP && curSelected == 0 && FlxG.save.data.DemoFreeplaySong3 == true && !FlxG.save.data.DemoFreeplaySong4)
			{
				changeSelection(-shiftMult);
				holdTime = 0;
				riddleText.alpha = 1;
				riddleText.text = "Riddle me this:\n\nWhat's red, blue, and SUS ALL OVER?\n\n\nType your answer, then press ENTER";
			}
			else if (upP)
			{
				changeSelection(-shiftMult);
				holdTime = 0;
				riddleText.alpha = 0;
				riddleText.text = "Riddle me this:\n\nWhat's red, blue, and SUS ALL OVER?\n\n\nType your answer, then press ENTER";
			}
			if (downP && curSelected == 2 && FlxG.save.data.DemoFreeplaySong3 == true && !FlxG.save.data.DemoFreeplaySong4)
			{
				changeSelection(shiftMult);
				holdTime = 0;
				riddleText.alpha = 1;
				riddleText.text = "Riddle me this:\n\nWhat's red, blue, and SUS ALL OVER?\n\n\nType your answer, then press ENTER";
			}
			else if (downP && pogoStickJoe == 4)
			{
			}
			else if (downP && pogoStickJoe == 7)
			{
			}
			else if (downP)
			{
				changeSelection(shiftMult);
				holdTime = 0;
				riddleText.alpha = 0;
				riddleText.text = "Riddle me this:\n\nWhat's red, blue, and SUS ALL OVER?\n\n\nType your answer, then press ENTER";
			}

			if(controls.UI_DOWN || controls.UI_UP)
			{
				var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				{
					changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					changeDiff();
				}
			}

		
		if (curSelected == 3 && FlxG.save.data.DemoFreeplaySong3 == true && !FlxG.save.data.DemoFreeplaySong4)
		{
			if (FlxG.keys.justPressed.ANY) 
			{
				var hitCorrectKey:Bool = false;
				for (i in 0...pogoStick[pogoStickJoe].length)
				{
					if (FlxG.keys.checkStatus(pogoStick[pogoStickJoe][i], JUST_PRESSED))
						hitCorrectKey = true;
				}
				if (hitCorrectKey)
				{
					if (pogoStickJoe == (pogoStick.length - 1))
					{
						MusicBeatState.switchState(new VoidState());
					}
					else
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.7);
						trace('susing');
						pogoStickJoe++;
					}
				}
				else 
				{
					pogoStickJoe = 0;
					trace('wrong, dumb');
					for (i in 0...pogoStick[0].length)
					{
						if (FlxG.keys.checkStatus(pogoStick[0][i], JUST_PRESSED))
							pogoStickJoe = 1;
					}
				}
			}
		}

		if (curSelected == 3)
		{
			changeDiff(1 - curDifficulty);
		}
		else if (poop == '???')
		{
			changeDiff(1 - curDifficulty);
		}
		else
		{
			if (controls.UI_LEFT_P)
			{
				changeDiff(-1);
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			}
			else if (controls.UI_RIGHT_P)
			{
				changeDiff(1);
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			}
		}

		super.update(elapsed);
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		// adjusting the highscore song name to be compatible (changeDiff)
		var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
		switch (songHighscore) {
			case 'Dad-Battle': songHighscore = 'Dadbattle';
			case 'Philly-Nice': songHighscore = 'Philly';
		}
		
		#if !switch
		intendedScore = Highscore.getScore(songHighscore, curDifficulty);
		intendedRating = Highscore.getRating(songHighscore, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
		diffText.text = '< ' + CoolUtil.difficultyString() + ' >';
		positionHighscore();
	}


	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - weekbeaten - 1;
		if (curSelected >= songs.length - weekbeaten)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
	}
		private function positionHighscore() {
			scoreText.x = FlxG.width - scoreText.width - 6;

			scoreBG.scale.x = FlxG.width - scoreText.x + 6;
			scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
			diffText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
			diffText.x -= diffText.width / 2;
		}
	}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}