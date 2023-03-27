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
import flixel.util.FlxTimer;


#if windows
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayClassicState extends MusicBeatState
{
	var songs:Array<CongMetadata> = [];

	public static var curSelected:Int = 0;
	
	var scoreBGF:FlxSprite;
	var scoreBGD:FlxSprite;
	var scoreMedalF:FlxSprite;
	var scoreMedalD:FlxSprite;
	var songIconF:FlxSprite;
	var songIconD:FlxSprite;
	var selector:FlxText;
	var curDifficulty:Int = 2;
	var weekbeaten:Int = 1;
	var scoreTextF:FlxText;
	var scoreTextD:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	var dlerpScore:Int = 0;
	var dlerpRating:Float = 0;
	var dintendedScore:Int = 0;
	var dintendedRating:Float = 0;
	var remixSuffix:String = '';
	
	private var grpSongs:FlxTypedGroup<Freephabet>;
	private var curPlaying:Bool = false;
	private static var lastDifficultyName:String = '';
	private var camGame:FlxCamera;

	private var cardArray:Array<FreeplayCards> = [];

	override function create()
	{
		var Song1:String = 'Bean Bam';
		var Song2:String = 'Earthquake';
		var Song3:String = 'Bombshell';
		var Song4:String = 'Spiky Slopes';
		
		/*
		if (FlxG.save.data.DemoFreeplaySong2 == true)
			Song2 = 'Earthquake';
		
		if (FlxG.save.data.DemoFreeplaySong3 == true)
			Song3 = 'Bombshell';

		if (FlxG.save.data.DemoFreeplaySong4 == true)
			Song4 = 'Rap Battle';
		*/

		var initSonglist:Array<String> = [Song1, Song2, Song3, Song4, ''];

		for (i in 0...initSonglist.length)
		{
			var data:Array<String> = initSonglist[i].split(':');
			songs.push(new CongMetadata(data[0], Std.parseInt(data[2]), data[1]));
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

		scoreTextF = new FlxText(FlxG.width * 0.7, 5, 0, "", 25);
		scoreTextF.setFormat(Paths.font("fall.ttf"), 25, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE);
		scoreTextF.antialiasing = ClientPrefs.globalAntialiasing;
		scoreTextF.y = 360 - 130 - 35 - 160 - 720;
		scoreTextF.borderSize = 2;

		scoreTextD = new FlxText(FlxG.width * 0.7, 5, 0, "", 25);
		scoreTextD.setFormat(Paths.font("fall.ttf"), 25, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE);
		scoreTextD.antialiasing = ClientPrefs.globalAntialiasing;
		scoreTextD.y = 360 + 130 + 160 - 720;
		scoreTextD.borderSize = 2;
		
		scoreBGF = new FlxSprite(scoreTextF.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBGF.alpha = 0;
		add(scoreBGF);

		scoreBGD = new FlxSprite(scoreTextD.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBGD.alpha = 0;
		add(scoreBGD);

		diffText = new FlxText(scoreTextF.x, scoreTextF.y + 36, 0, "", 35);
		diffText.font = scoreTextF.font;
		diffText.borderStyle = FlxTextBorderStyle.OUTLINE;
		diffText.y = 337 - 720;
		diffText.borderSize = 2;
		diffText.antialiasing = ClientPrefs.globalAntialiasing;
		add(diffText);

		add(scoreTextF);
		add(scoreTextD);

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

		scoreMedalF = new FlxSprite(900, 230 - 160 - 720);
		scoreMedalF.frames = Paths.getSparrowAtlas('fallmen/Freeplay/medals');
		scoreMedalF.scrollFactor.set(0, 0);
		scoreMedalF.animation.addByPrefix("Purple", "Purple", 24);
		scoreMedalF.animation.addByPrefix("Pink", "Pink", 24);
		scoreMedalF.animation.addByPrefix("Bronze", "Bronze", 24);
		scoreMedalF.animation.addByPrefix("Silver", "Silver", 24);
		scoreMedalF.animation.addByPrefix("Gold", "Gold", 24);
		scoreMedalF.antialiasing = ClientPrefs.globalAntialiasing;
		add(scoreMedalF);

		scoreMedalD = new FlxSprite(900, 230 + 160 - 720);
		scoreMedalD.frames = Paths.getSparrowAtlas('fallmen/Freeplay/medals');
		scoreMedalD.scrollFactor.set(0, 0);
		scoreMedalD.animation.addByPrefix("Purple", "Purple", 24);
		scoreMedalD.animation.addByPrefix("Pink", "Pink", 24);
		scoreMedalD.animation.addByPrefix("Bronze", "Bronze", 24);
		scoreMedalD.animation.addByPrefix("Silver", "Silver", 24);
		scoreMedalD.animation.addByPrefix("Gold", "Gold", 24);
		scoreMedalD.antialiasing = ClientPrefs.globalAntialiasing;
		add(scoreMedalD);
		
		songIconF = new FlxSprite(900, 230 - 160 - 720);
		songIconF.frames = Paths.getSparrowAtlas('fallmen/Freeplay/medal-icons');
		songIconF.scrollFactor.set(0, 0);
		songIconF.antialiasing = ClientPrefs.globalAntialiasing;
		add(songIconF);
		
		songIconD = new FlxSprite(900, 230 + 160 - 720);
		songIconD.frames = Paths.getSparrowAtlas('fallmen/Freeplay/medal-icons');
		songIconD.scrollFactor.set(0, 0);
		songIconD.antialiasing = ClientPrefs.globalAntialiasing;
		add(songIconD);

		FlxTween.tween(scoreMedalF, {y: scoreMedalF.y + 720}, 0.53, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(scoreMedalD, {y: scoreMedalD.y + 720}, 0.53, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(songIconF, {y: songIconF.y + 720}, 0.53, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(songIconD, {y: songIconD.y + 720}, 0.53, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(diffText, {y: diffText.y + 720}, 0.53, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(scoreTextF, {y: scoreTextF.y + 720}, 0.53, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(scoreTextD, {y: scoreTextD.y + 720}, 0.53, {ease: FlxEase.quartInOut, startDelay: 0.5});

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
			// scoreTextF.textField.htmlText = md;
			trace(md);
		 */

		var holdText:FlxText = new FlxText(0, 10, FlxG.width, "Songs made by the original composer\nhave been removed/muted as requested by them.\nVocals made by Denoohay have still been kept in.\nAll Charts are still playable but might be messy.\nP.S. avoid Slime Notes on Spiky Slopes.", 12);
		holdText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		holdText.antialiasing = ClientPrefs.globalAntialiasing;
		holdText.borderSize = 2;
		holdText.size = 32;
		add(holdText);

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
	{
		songs.push(new CongMetadata(songName, weekNum, songCharacter));
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
		dlerpScore = Math.floor(FlxMath.lerp(dlerpScore, dintendedScore, CoolUtil.boundTo(elapsed * 24, 1, 1)));
		dlerpRating = FlxMath.lerp(dlerpRating, dintendedRating, CoolUtil.boundTo(elapsed * 12, 1, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		if (Math.abs(dlerpScore - dintendedScore) <= 10)
			dlerpScore = dintendedScore;
		if (Math.abs(dlerpRating - dintendedRating) <= 0.01)
			dlerpRating = dintendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		var dratingSplit:Array<String> = Std.string(Highscore.floorDecimal(dlerpRating * 100, 2)).split('.');
		if(dratingSplit.length < 2) { //No decimals, add an empty space
			dratingSplit.push('');
		}
		
		while(dratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			dratingSplit[1] += '0';
		}

		scoreTextF.text = 'F-MIX SCORE: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		scoreTextD.text = 'D-MIX SCORE: ' + dlerpScore + ' (' + dratingSplit.join('.') + '%)';
		positionHighscore();

		
		if (lerpRating * 100 >= 100)
		{
			scoreTextF.borderColor = 0xFFE8933C;
			scoreMedalF.animation.play("Gold");
		}
		else if (lerpRating * 100 >= 90)
		{
			scoreTextF.borderColor = 0xFF2AA9AF;
			scoreMedalF.animation.play("Silver");
		}
		else if (lerpRating * 100 >= 70)
		{
			scoreTextF.borderColor = 0xFFA8642F;
			scoreMedalF.animation.play("Bronze");
		}
		else if (lerpRating * 100 >= 1)
		{
			scoreTextF.borderColor = 0xFFDD0088;
			scoreMedalF.animation.play("Pink");
		}
		else if (lerpRating * 100 >= 0)
		{
			scoreTextF.borderColor = 0xFF8A2EDB;
			scoreMedalF.animation.play("Purple");
		}


		if (dlerpRating * 100 >= 100)
		{
			scoreTextD.borderColor = 0xFFE8933C;
			scoreMedalD.animation.play("Gold");
		}
		else if (dlerpRating * 100 >= 90)
		{
			scoreTextD.borderColor = 0xFF2AA9AF;
			scoreMedalD.animation.play("Silver");
		}
		else if (dlerpRating * 100 >= 70)
		{
			scoreTextD.borderColor = 0xFFA8642F;
			scoreMedalD.animation.play("Bronze");
		}
		else if (dlerpRating * 100 >= 1)
		{
			scoreTextD.borderColor = 0xFFDD0088;
			scoreMedalD.animation.play("Pink");
		}
		else if (dlerpRating * 100 >= 0)
		{
			scoreTextD.borderColor = 0xFF8A2EDB;
			scoreMedalD.animation.play("Purple");
		}


		if (curDifficulty == 0)
		{
			diffText.borderColor = 0xFF00A354;
		}
		else if (curDifficulty == 1)
		{
			diffText.borderColor = 0xFFDBAF00;
		}
		else if (curDifficulty == 2)
		{
			diffText.borderColor = 0xFFDD0088;
		}
		
		if (FlxG.save.data.FMixSelected == true)
		{
			remixSuffix = '-f-mix';
		}
		if (FlxG.save.data.DMixSelected == true)
		{
			remixSuffix = '-d-mix';
		}
		if (curSelected == 3)
		{
			remixSuffix = '-f-mix';
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase() + remixSuffix, curDifficulty); //REMINDER: "poop" is the song name AND difficulty EX: 'earthquake-hard'
		var JUSTsongName:String = (songs[curSelected].songName.toLowerCase()); //SONG NAME WITH SPACES AND ALL LOWER CASE
		var FILEsongName:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), 1); //SONG NAME WITH DASHES AND ALL LOWER CASE

		var shiftMult:Int = 1;
		
		songIconF.animation.addByPrefix(JUSTsongName, JUSTsongName, 24);
		songIconF.animation.addByPrefix('locked', 'locked', 24);
		songIconD.animation.addByPrefix(JUSTsongName, JUSTsongName, 24);
		songIconD.animation.addByPrefix('locked', 'locked', 24);

		if (lerpRating * 100 != 0)
		{
			songIconF.animation.play(JUSTsongName);
		}
		else
		{
			songIconF.animation.play('locked');
		}

		if (dlerpRating * 100 != 0)
		{
			songIconD.animation.play(JUSTsongName);
		}
		else
		{
			songIconD.animation.play('locked');
		}

		if (JUSTsongName == 'spiky slopes')
		{
			scoreTextD.alpha = 0;
			scoreMedalD.alpha = 0;
			songIconD.alpha = 0;
		}
		else
		{
			scoreTextD.alpha = 1;
			scoreMedalD.alpha = 1;
			songIconD.alpha = 1;
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

		if (FlxG.save.data.FreeplayClassicSelected == true)
		{
				FlxG.save.data.FreeplayClassicSelected = false;
				trace(poop);
				FlxG.sound.music.volume = 0;
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase() + remixSuffix);
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;
				PlayState.storyWeek = songs[curSelected].week;
				LoadingState.loadAndSwitchState(new PlayState());
		}
		else if (accepted)
		{
			if (JUSTsongName == 'spiky slopes')
			{
				if (Paths.fileExists('data/' + FILEsongName + '-f-mix' + '/' + poop + '.json', TEXT))
				{
					FlxG.sound.play(Paths.sound('confirmMenu2'));
					trace(poop);
					FlxG.sound.music.volume = 0;
					PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase() + '-f-mix');
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
			else
			{
				FlxG.sound.play(Paths.sound('confirmMenu2'));
				persistentUpdate = false;
				openSubState(new FreeplayClassicSelectionSubState());
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
					changeDiff();
				}
			}

			if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				changeSelection(-shiftMult * FlxG.mouse.wheel);
				changeDiff();
			}
						
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
		var fsongHighscore = StringTools.replace(songs[curSelected].songName + '-f-mix', " ", "-");
		var dsongHighscore = StringTools.replace(songs[curSelected].songName + '-d-mix', " ", "-");
		
		#if !switch
		intendedScore = Highscore.getScore(fsongHighscore, curDifficulty);
		intendedRating = Highscore.getRating(fsongHighscore, curDifficulty);
		dintendedScore = Highscore.getScore(dsongHighscore, curDifficulty);
		dintendedRating = Highscore.getRating(dsongHighscore, curDifficulty);
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
		intendedScore = Highscore.getScore(songs[curSelected].songName + '-f-mix', curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName + '-f-mix', curDifficulty);
		dintendedScore = Highscore.getScore(songs[curSelected].songName + '-d-mix', curDifficulty);
		dintendedRating = Highscore.getRating(songs[curSelected].songName + '-d-mix', curDifficulty);
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
			scoreTextF.x = Std.int(900 + (scoreBGF.width / 2));
			scoreTextF.x -= scoreTextF.width / 2;
			scoreTextF.x = 1030 - scoreTextF.width / 2;

			scoreTextD.x = Std.int(900 + (scoreBGD.width / 2));
			scoreTextD.x -= scoreTextD.width / 2;
			scoreTextD.x = 1030 - scoreTextD.width / 2;

			scoreBGF.scale.x = FlxG.width - scoreTextF.x + 6;
			scoreBGF.x = 900;

			scoreBGD.scale.x = FlxG.width - scoreTextD.x + 6;
			scoreBGD.x = 900;

			diffText.x = Std.int(900 + (scoreBGF.width / 2));
			diffText.x -= diffText.width / 2;
			diffText.x = 1030 - diffText.width / 2;
		}
	}

class CongMetadata
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