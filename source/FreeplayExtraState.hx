package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.input.keyboard.FlxKeyboard;
import flixel.input.keyboard.FlxKey;
import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;
import flixel.util.FlxTimer;


#if windows
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayExtraState extends MusicBeatState
{
	var songs:Array<EongMetadata> = [];

	public static var curSelected:Int = 0;
	
	var scoreBG:FlxSprite;
	var scoreMedal:FlxSprite;
	var songIcon:FlxSprite;
	var selector:FlxText;
	var curDifficulty:Int = 1;
	var weekbeaten:Int = 1;
	var scoreText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	
	private var grpSongs:FlxTypedGroup<Freephabet>;
	private var curPlaying:Bool = false;
	private static var lastDifficultyName:String = '';
	private var camGame:FlxCamera;

	private var cardArray:Array<FreeplayCards> = [];

	override function create()
	{
		var Song1:String = 'Better Bean';
		var Song2:String = 'Everybody Falls';

		/*
		if (FlxG.save.data.DemoFreeplaySong2 == true)
			Song2 = 'Earthquake';
		
		if (FlxG.save.data.DemoFreeplaySong3 == true)
			Song3 = 'Bombshell';

		if (FlxG.save.data.DemoFreeplaySong4 == true)
			Song4 = 'Rap Battle';
		*/

		var initSonglist:Array<String> = [Song1, Song2, ''];

		for (i in 0...initSonglist.length)
		{
			var data:Array<String> = initSonglist[i].split(':');
			songs.push(new EongMetadata(data[0], Std.parseInt(data[2]), data[1]));
		}

		camGame = new FlxCamera(0);
		FlxG.cameras.reset(camGame);

		 #if windows
		 // Updating Discord Rich Presence
		 DiscordClient.changePresence("In the Freeplay Menu", null);
		 #end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

//$ This whole section is just for the background

		var bg:FlxSprite;
		var bgPattern:FlxSprite;
		var bigring:FlxSprite;
		var samring:FlxSprite;
		var bigring2:FlxSprite;
		var samring2:FlxSprite;
		var bigring3:FlxSprite;
		var samring3:FlxSprite;
		var bigring4:FlxSprite;
		var samring4:FlxSprite;
		var bigring5:FlxSprite;
		var samring5:FlxSprite;
		var bigring6:FlxSprite;
		var samring6:FlxSprite;
		var bigring7:FlxSprite;
		var samring7:FlxSprite;
		var bigring8:FlxSprite;
		var samring8:FlxSprite;
		var bigringInplace:FlxSprite;
		var samringInplace:FlxSprite;
		var bigringInplace2:FlxSprite;
		var samringInplace2:FlxSprite;
		var bigringInplace3:FlxSprite;
		var samringInplace3:FlxSprite;
		var FrontalGrad:FlxSprite;
		
		var backColor:FlxColor = 0xFFFFC300;
		var patColor:FlxColor = 0xFFFFD200;
		var bigRingColor:FlxColor = 0xFFFFD200;
		var samRingColor:FlxColor = 0xFFFFDC49;
		var gradColor:FlxColor = 0xFFFFE48E;

		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, 0xFFFFFFFF);
		bg.color = backColor;
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		function makeBackground():Void
		{
			var lastX:Int = 0;
			var lastY:Int = 0;
			var imgAssetStr = "assets/images/fallmen/MainMenu/pat1.png";
			var dirtPattern:FlxSprite = new FlxSprite(0, 0, imgAssetStr);
			dirtPattern.antialiasing = ClientPrefs.globalAntialiasing;

			bgPattern = new FlxSprite(0, 0); //THIS ONE IS WHAT SHOWS ON-SCREEN
			bgPattern.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
			bgPattern.scrollFactor.x = 0;
			bgPattern.scrollFactor.y = 0;
			bgPattern.color = patColor;
			bgPattern.antialiasing = ClientPrefs.globalAntialiasing;

			while (lastY < FlxG.height)
			{
				while (lastX < FlxG.width)
				{
					bgPattern.stamp(dirtPattern, Std.int(lastX), Std.int(lastY));
					lastX += Std.int(dirtPattern.width);
				}

				lastX = 0;
				lastY += Std.int(dirtPattern.height);
			}

			dirtPattern.destroy();
			add(bgPattern);
		};

		makeBackground();

		bigring = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleBig'));
		bigring.scrollFactor.x = 0;
		bigring.scrollFactor.y = 0;
		bigring.setGraphicSize(Std.int(bigring.width * 0.001));
		bigring.updateHitbox();
		bigring.screenCenter();
		bigring.antialiasing = ClientPrefs.globalAntialiasing;
		bigring.color = bigRingColor;
		add(bigring);

		samring = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleSam'));
		samring.scrollFactor.x = 0;
		samring.scrollFactor.y = 0;
		samring.setGraphicSize(Std.int(samring.width * 0.001));
		samring.updateHitbox();
		samring.screenCenter();
		samring.antialiasing = ClientPrefs.globalAntialiasing;
		samring.color = samRingColor;
		add(samring);
		
		bigring2 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleBig'));
		bigring2.scrollFactor.x = 0;
		bigring2.scrollFactor.y = 0;
		bigring2.setGraphicSize(Std.int(bigring2.width * 0.001));
		bigring2.updateHitbox();
		bigring2.screenCenter();
		bigring2.antialiasing = ClientPrefs.globalAntialiasing;
		bigring2.color = bigRingColor;
		add(bigring2);

		samring2 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleSam'));
		samring2.scrollFactor.x = 0;
		samring2.scrollFactor.y = 0;
		samring2.setGraphicSize(Std.int(samring2.width * 0.001));
		samring2.updateHitbox();
		samring2.screenCenter();
		samring2.antialiasing = ClientPrefs.globalAntialiasing;
		samring2.color = samRingColor;
		add(samring2);
		
		bigring3 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleBig'));
		bigring3.scrollFactor.x = 0;
		bigring3.scrollFactor.y = 0;
		bigring3.setGraphicSize(Std.int(bigring3.width * 0.001));
		bigring3.updateHitbox();
		bigring3.screenCenter();
		bigring3.antialiasing = ClientPrefs.globalAntialiasing;
		bigring3.color = bigRingColor;
		add(bigring3);

		samring3 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleSam'));
		samring3.scrollFactor.x = 0;
		samring3.scrollFactor.y = 0;
		samring3.setGraphicSize(Std.int(samring3.width * 0.001));
		samring3.updateHitbox();
		samring3.screenCenter();
		samring3.antialiasing = ClientPrefs.globalAntialiasing;
		samring3.color = samRingColor;
		add(samring3);
		
		bigring4 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleBig'));
		bigring4.scrollFactor.x = 0;
		bigring4.scrollFactor.y = 0;
		bigring4.setGraphicSize(Std.int(bigring4.width * 0.001));
		bigring4.updateHitbox();
		bigring4.screenCenter();
		bigring4.antialiasing = ClientPrefs.globalAntialiasing;
		bigring4.color = bigRingColor;
		add(bigring4);

		samring4 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleSam'));
		samring4.scrollFactor.x = 0;
		samring4.scrollFactor.y = 0;
		samring4.setGraphicSize(Std.int(samring4.width * 0.001));
		samring4.updateHitbox();
		samring4.screenCenter();
		samring4.antialiasing = ClientPrefs.globalAntialiasing;
		samring4.color = samRingColor;
		add(samring4);

		bigring5 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleBig'));
		bigring5.scrollFactor.x = 0;
		bigring5.scrollFactor.y = 0;
		bigring5.setGraphicSize(Std.int(bigring5.width * 0.001));
		bigring5.updateHitbox();
		bigring5.screenCenter();
		bigring5.antialiasing = ClientPrefs.globalAntialiasing;
		bigring5.color = bigRingColor;
		add(bigring5);

		samring5 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleSam'));
		samring5.scrollFactor.x = 0;
		samring5.scrollFactor.y = 0;
		samring5.setGraphicSize(Std.int(samring5.width * 0.001));
		samring5.updateHitbox();
		samring5.screenCenter();
		samring5.antialiasing = ClientPrefs.globalAntialiasing;
		samring5.color = samRingColor;
		add(samring5);
		
		bigring6 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleBig'));
		bigring6.scrollFactor.x = 0;
		bigring6.scrollFactor.y = 0;
		bigring6.setGraphicSize(Std.int(bigring6.width * 0.001));
		bigring6.updateHitbox();
		bigring6.screenCenter();
		bigring6.antialiasing = ClientPrefs.globalAntialiasing;
		bigring6.color = bigRingColor;
		add(bigring6);

		samring6 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleSam'));
		samring6.scrollFactor.x = 0;
		samring6.scrollFactor.y = 0;
		samring6.setGraphicSize(Std.int(samring6.width * 0.001));
		samring6.updateHitbox();
		samring6.screenCenter();
		samring6.antialiasing = ClientPrefs.globalAntialiasing;
		samring6.color = samRingColor;
		add(samring6);
		
		bigring7 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleBig'));
		bigring7.scrollFactor.x = 0;
		bigring7.scrollFactor.y = 0;
		bigring7.setGraphicSize(Std.int(bigring7.width * 0.001));
		bigring7.updateHitbox();
		bigring7.screenCenter();
		bigring7.antialiasing = ClientPrefs.globalAntialiasing;
		bigring7.color = bigRingColor;
		add(bigring7);

		samring7 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleSam'));
		samring7.scrollFactor.x = 0;
		samring7.scrollFactor.y = 0;
		samring7.setGraphicSize(Std.int(samring7.width * 0.001));
		samring7.updateHitbox();
		samring7.screenCenter();
		samring7.antialiasing = ClientPrefs.globalAntialiasing;
		samring7.color = samRingColor;
		add(samring7);
		
		bigring8 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleBig'));
		bigring8.scrollFactor.x = 0;
		bigring8.scrollFactor.y = 0;
		bigring8.setGraphicSize(Std.int(bigring8.width * 0.001));
		bigring8.updateHitbox();
		bigring8.screenCenter();
		bigring8.antialiasing = ClientPrefs.globalAntialiasing;
		bigring8.color = bigRingColor;
		add(bigring8);

		samring8 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleSam'));
		samring8.scrollFactor.x = 0;
		samring8.scrollFactor.y = 0;
		samring8.setGraphicSize(Std.int(samring8.width * 0.001));
		samring8.updateHitbox();
		samring8.screenCenter();
		samring8.antialiasing = ClientPrefs.globalAntialiasing;
		samring8.color = samRingColor;
		add(samring8);

		FlxTween.tween(bigring.scale, {x:1, y:1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
		FlxTween.tween(samring.scale, {x:1.1, y:1.1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
		
		new FlxTimer().start(6, function(tmr:FlxTimer)
		{
			FlxTween.tween(bigring2.scale, {x:1, y:1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
			FlxTween.tween(samring2.scale, {x:1.1, y:1.1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
		});
		
		new FlxTimer().start(10, function(tmr:FlxTimer)
		{
			FlxTween.tween(bigring3.scale, {x:1, y:1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
			FlxTween.tween(samring3.scale, {x:1.1, y:1.1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
		});
		
		new FlxTimer().start(16, function(tmr:FlxTimer)
		{
			FlxTween.tween(bigring4.scale, {x:1, y:1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
			FlxTween.tween(samring4.scale, {x:1.1, y:1.1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
		});
		new FlxTimer().start(22, function(tmr:FlxTimer)
		{
			FlxTween.tween(bigring5.scale, {x:1, y:1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
			FlxTween.tween(samring5.scale, {x:1.1, y:1.1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
		});
		
		new FlxTimer().start(26, function(tmr:FlxTimer)
		{
			FlxTween.tween(bigring6.scale, {x:1, y:1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
			FlxTween.tween(samring6.scale, {x:1.1, y:1.1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
		});
		
		new FlxTimer().start(32, function(tmr:FlxTimer)
		{
			FlxTween.tween(bigring7.scale, {x:1, y:1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
			FlxTween.tween(samring7.scale, {x:1.1, y:1.1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
		});

		new FlxTimer().start(36, function(tmr:FlxTimer)
		{
			FlxTween.tween(bigring8.scale, {x:1, y:1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
			FlxTween.tween(samring8.scale, {x:1.1, y:1.1}, 39, { ease: FlxEase.quadInOut, type: FlxTweenType.LOOPING } );
		});
		
		bigringInplace = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleBig'));
		bigringInplace.scrollFactor.x = 0;
		bigringInplace.scrollFactor.y = 0;
		bigringInplace.setGraphicSize(Std.int(bigringInplace.width * 0.7));
		bigringInplace.updateHitbox();
		bigringInplace.screenCenter();
		bigringInplace.antialiasing = ClientPrefs.globalAntialiasing;
		bigringInplace.color = bigRingColor;
		add(bigringInplace);

		samringInplace = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleSam'));
		samringInplace.scrollFactor.x = 0;
		samringInplace.scrollFactor.y = 0;
		samringInplace.setGraphicSize(Std.int(samringInplace.width * 0.75));
		samringInplace.updateHitbox();
		samringInplace.screenCenter();
		samringInplace.antialiasing = ClientPrefs.globalAntialiasing;
		samringInplace.color = samRingColor;
		add(samringInplace);

		bigringInplace2 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleBig'));
		bigringInplace2.scrollFactor.x = 0;
		bigringInplace2.scrollFactor.y = 0;
		bigringInplace2.setGraphicSize(Std.int(bigringInplace2.width * 0.4));
		bigringInplace2.updateHitbox();
		bigringInplace2.screenCenter();
		bigringInplace2.antialiasing = ClientPrefs.globalAntialiasing;
		bigringInplace2.color = bigRingColor;
		add(bigringInplace2);

		samringInplace2 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleSam'));
		samringInplace2.scrollFactor.x = 0;
		samringInplace2.scrollFactor.y = 0;
		samringInplace2.setGraphicSize(Std.int(samringInplace2.width * 0.45));
		samringInplace2.updateHitbox();
		samringInplace2.screenCenter();
		samringInplace2.antialiasing = ClientPrefs.globalAntialiasing;
		samringInplace2.color = samRingColor;
		add(samringInplace2);

		bigringInplace3 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleBig'));
		bigringInplace3.scrollFactor.x = 0;
		bigringInplace3.scrollFactor.y = 0;
		bigringInplace3.setGraphicSize(Std.int(bigringInplace3.width * 0.15));
		bigringInplace3.updateHitbox();
		bigringInplace3.screenCenter();
		bigringInplace3.antialiasing = ClientPrefs.globalAntialiasing;
		bigringInplace3.color = bigRingColor;
		add(bigringInplace3);

		samringInplace3 = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smircleSam'));
		samringInplace3.scrollFactor.x = 0;
		samringInplace3.scrollFactor.y = 0;
		samringInplace3.setGraphicSize(Std.int(samringInplace3.width * 0.2));
		samringInplace3.updateHitbox();
		samringInplace3.screenCenter();
		samringInplace3.antialiasing = ClientPrefs.globalAntialiasing;
		samringInplace3.color = samRingColor;
		add(samringInplace3);

		FlxTween.tween(bigringInplace.scale, {x:1, y:1}, 12, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );
		FlxTween.tween(samringInplace.scale, {x:1.1, y:1.1}, 12, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );

		FlxTween.tween(bigringInplace2.scale, {x:1, y:1}, 20, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );
		FlxTween.tween(samringInplace2.scale, {x:1.1, y:1.1}, 20, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );

		FlxTween.tween(bigringInplace3.scale, {x:1, y:1}, 30, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );
		FlxTween.tween(samringInplace3.scale, {x:1.1, y:1.1}, 30, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );
		
		FrontalGrad = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/smunstupidGrad'));
		FrontalGrad.scrollFactor.x = 0;
		FrontalGrad.scrollFactor.y = 0;
		FrontalGrad.updateHitbox();
		FrontalGrad.screenCenter();
		FrontalGrad.antialiasing = ClientPrefs.globalAntialiasing;
		FrontalGrad.alpha = 0.5;
		FrontalGrad.color = gradColor;
		add(FrontalGrad);

//$ and the background section ends here. ughghughhh

		grpSongs = new FlxTypedGroup<Freephabet>();
		add(grpSongs);

		if(FlxG.save.data.mainshowwon == true)
			{
				weekbeaten = 0;
			}

		for (i in 0...songs.length - weekbeaten)
		{
			var songText:Freephabet = new Freephabet(0, (2000) + 30, '', true, false); //2000 is there to make it look like it transitions
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			var card:FreeplayCards = new FreeplayCards(songs[i].songName);
			card.sprTracker = songText;
			card.antialiasing = ClientPrefs.globalAntialiasing;
			cardArray.push(card);
			add(card);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 25);
		scoreText.setFormat(Paths.font("fall.ttf"), 25, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE);
		scoreText.antialiasing = ClientPrefs.globalAntialiasing;
		scoreText.y = 360 - 130 - 35 - 720;
		scoreText.borderSize = 2;
		
		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0;
		add(scoreBG);

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

		scoreMedal = new FlxSprite(900, 230 - 720);
		scoreMedal.frames = Paths.getSparrowAtlas('fallmen/Freeplay/medals');
		scoreMedal.scrollFactor.set(0, 0);
		scoreMedal.animation.addByPrefix("Purple", "Purple", 24);
		scoreMedal.animation.addByPrefix("Pink", "Pink", 24);
		scoreMedal.animation.addByPrefix("Bronze", "Bronze", 24);
		scoreMedal.animation.addByPrefix("Silver", "Silver", 24);
		scoreMedal.animation.addByPrefix("Gold", "Gold", 24);
		scoreMedal.antialiasing = ClientPrefs.globalAntialiasing;
		add(scoreMedal);
		
		songIcon = new FlxSprite(900, 230 - 720);
		songIcon.frames = Paths.getSparrowAtlas('fallmen/Freeplay/medal-icons');
		songIcon.scrollFactor.set(0, 0);
		songIcon.antialiasing = ClientPrefs.globalAntialiasing;
		add(songIcon);

		FlxTween.tween(scoreMedal, {y: scoreMedal.y + 720}, 0.53, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(songIcon, {y: songIcon.y + 720}, 0.53, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(scoreText, {y: scoreText.y + 720}, 0.53, {ease: FlxEase.quartInOut, startDelay: 0.5});

		var swag:Freephabet = new Freephabet(1, 0, "swag");

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

		var holdText:FlxText = new FlxText(0, 10, FlxG.width, "Better Bean is the same as Rap Battle from the Demos.\nEverybody Falls has sloppy charting.", 12);
		holdText.scrollFactor.set();
		holdText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		holdText.antialiasing = ClientPrefs.globalAntialiasing;
		holdText.screenCenter(X);
		holdText.borderSize = 2;
		holdText.size = 32;
		add(holdText);

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
	{
		songs.push(new EongMetadata(songName, weekNum, songCharacter));
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

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 1, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 1, 1));

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

		scoreText.text = 'HIGHSCORE: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		positionHighscore();

		
		if (lerpRating * 100 >= 100)
		{
			scoreText.borderColor = 0xFFE8933C;
			scoreMedal.animation.play("Gold");
		}
		else if (lerpRating * 100 >= 90)
		{
			scoreText.borderColor = 0xFF2AA9AF;
			scoreMedal.animation.play("Silver");
		}
		else if (lerpRating * 100 >= 70)
		{
			scoreText.borderColor = 0xFFA8642F;
			scoreMedal.animation.play("Bronze");
		}
		else if (lerpRating * 100 >= 1)
		{
			scoreText.borderColor = 0xFFDD0088;
			scoreMedal.animation.play("Pink");
		}
		else if (lerpRating * 100 >= 0)
		{
			scoreText.borderColor = 0xFF8A2EDB;
			scoreMedal.animation.play("Purple");
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty); //REMINDER: "poop" is the song name AND difficulty EX: 'earthquake-hard'
		var JUSTsongName:String = (songs[curSelected].songName.toLowerCase()); //SONG NAME WITH SPACES AND ALL LOWER CASE
		var FILEsongName:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), 1); //SONG NAME WITH DASHES AND ALL LOWER CASE
		var shiftMult:Int = 1;
		
		songIcon.animation.addByPrefix(JUSTsongName, JUSTsongName, 24);
		songIcon.animation.addByPrefix('locked', 'locked', 24);

		if (lerpRating * 100 != 0)
		{
			songIcon.animation.play(JUSTsongName);
		}
		else
		{
			songIcon.animation.play('locked');
		}

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new FreeplayMenuState());
		}

		else if (accepted)
		{
			if (JUSTsongName == 'locked')
			{
				FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.3));
				camGame.shake(0.005, 0.2);
				trace('no <3');
			}
			else
			{
				if (Paths.fileExists('data/' + FILEsongName + '/' + poop + '.json', TEXT))
				{
					FlxG.sound.play(Paths.sound('confirmMenu2'));
					trace(poop);
					FlxG.sound.music.volume = 0;
					PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
					PlayState.isStoryMode = false;
					PlayState.storyDifficulty = curDifficulty;
					PlayState.storyWeek = songs[curSelected].week;
					LoadingState.loadAndSwitchState(new PlayState());
				}
				else
				{
					FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.3));
					camGame.shake(0.005, 0.2);
					trace('data/' + FILEsongName + '/' + poop + '.json' + " doesn't exist");
				}
			}
		}

		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

			if (upP)
			{
				changeSelection(-shiftMult);
				holdTime = 0;
			}
			if (downP)
			{
				changeSelection(shiftMult);
				holdTime = 0;
			}

			if(controls.UI_DOWN || controls.UI_UP)
			{
				var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				{
					changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
				}
			}

			if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				changeSelection(-shiftMult * FlxG.mouse.wheel);
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
		switch (songHighscore)
		{
			case 'Dad-Battle': songHighscore = 'Dadbattle';
			case 'Philly-Nice': songHighscore = 'Philly';
		}
		
		#if !switch
		intendedScore = Highscore.getScore(songHighscore, curDifficulty);
		intendedRating = Highscore.getRating(songHighscore, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
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

		for (i in 0...cardArray.length)
		{
			cardArray[i].alpha = 0.4;
		}
		
		cardArray[curSelected].alpha = 1;

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
			scoreText.x = Std.int(900 + (scoreBG.width / 2));
			scoreText.x -= scoreText.width / 2;
			scoreText.x = 1030 - scoreText.width / 2;

			scoreBG.scale.x = FlxG.width - scoreText.x + 6;
			scoreBG.x = 900;
		}
	}

class EongMetadata
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