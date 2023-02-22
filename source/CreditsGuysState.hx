package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsGuysState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var credback:FlxSprite;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = true;
		credback = new FlxSprite().loadGraphic(Paths.image('fallmen/MainMenu/menuBGDesat'));
		credback.antialiasing = ClientPrefs.globalAntialiasing;
		credback.visible = false;
		add(credback);
		credback.screenCenter();
		
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
		
		var backColor:FlxColor = 0xFF5296E1;
		var patColor:FlxColor = 0xFF639CE3;
		var bigRingColor:FlxColor = 0xFF639CE3;
		var samRingColor:FlxColor = 0xFF7EA7E9;
		var gradColor:FlxColor = 0xFFCCDFFF;

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

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		var path:String = 'modsList.txt';
		if(FileSystem.exists(path))
		{
			var leMods:Array<String> = CoolUtil.coolTextFile(path);
			for (i in 0...leMods.length)
			{
				if(leMods.length > 1 && leMods[0].length > 0) {
					var modSplit:Array<String> = leMods[i].split('|');
					if(!Paths.ignoreModFolders.contains(modSplit[0].toLowerCase()) && !modsAdded.contains(modSplit[0]))
					{
						if(modSplit[1] == '1')
							pushModCreditsToList(modSplit[0]);
						else
							modsAdded.push(modSplit[0]);
					}
				}
			}
		}

		var arrayOfFolders:Array<String> = Paths.getModDirectories();
		arrayOfFolders.push('');
		for (folder in arrayOfFolders)
		{
			pushModCreditsToList(folder);
		}
		#end

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			["Blunder Bash BG Beans"],
			['Bro_Guy9000',		'1'],
			['banpro05',		'2'],
			['DogeKingYTT',		'3'],
			['m23m23m23_',		'4'],
			['Zyl3thbl0x',		'5'],
			['quadurado',		'6'],
			['prange_dude',		'7'],
			['Maxstarpro',		'8'],
			['bi_satro',		'9'],
			['CoolFreddy_10',	'10'],
			['That_SBMB',		'11'],
			['VicCrack5',		'12'],
			['The_FlumeAT',		'13'],
			['Neoniumplayz',	'14'],
			['ArtisticAzzySus',	'15'],
			['BaldisBasic5356',	'16'],
			['IceConeGaming',	'17'],
			['BeanyTheFallGuy',	'18'],
			['Heloudah__',		'19'],
			['Daemontail1',		'20'],
			['Dynamo_Den',		'21'],
			['POLOisher',		'22'],
			['bozyyy2832',		'23'],
			['Wobblort',		'24'],
			['SasyYtOfficial',	'25'],
			['crispysquidony1',	'26'],
			['RealYeetedBean',	'27'],
			['JahidKainnou',	'28'],
			['xenox1118',		'29'],
			['TheMome_',		'30'],
			['choccy_milk19',	'31'],
			['Ginge0073',		'32'],
			['ImKooz',			'33'],
			['meownadaa',		'34'],
			['Blaze_0432',		'35'],
			['nearbyscallywag',	'36'],
			['HyperYeetedMVP',	'37'],
			['Icytanki',		'38'],
			['SugarShibe',		'39']
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}

		credback.color = getCurrentBGColor();
		intendedColor = credback.color;
		changeSelection();
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP)
				{
					changeSelection(-1 * shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(1 * shiftMult);
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
			}

			if (controls.BACK)
			{
				if(colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new CreditsState());
				quitting = true;
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(credback, 1, credback.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
	}

	#if MODS_ALLOWED
	private var modsAdded:Array<String> = [];
	function pushModCreditsToList(folder:String)
	{
		if(modsAdded.contains(folder)) return;

		var creditsFile:String = null;
		if(folder != null && folder.trim().length > 0) creditsFile = Paths.mods(folder + '/data/credits.txt');
		else creditsFile = Paths.mods('data/credits.txt');

		if (FileSystem.exists(creditsFile))
		{
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for(i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if(arr.length >= 5) arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
		modsAdded.push(folder);
	}
	#end

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}