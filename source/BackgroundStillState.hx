package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;
import flixel.util.FlxGradient;

using StringTools;

class BackgroundStillState extends MusicBeatState
{
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story',
		'extra',
		'classic'
	];

	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var idk:Bool = true;

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

	var isStupid:Bool = false;
	var pressedP:Bool = false;

	override function create()
	{
		FlxG.mouse.visible = false;
		FlxG.sound.muteKeys = null;

		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));
		
		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

//$ This whole section is just for the background

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

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		FlxG.camera.follow(camFollowPos, null, 1);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (FlxG.keys.justPressed.P && pressedP == false)
		{
			pressedP = true;

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

			FlxTween.tween(bigringInplace.scale, {x:1, y:1}, 12, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );
			FlxTween.tween(samringInplace.scale, {x:1.1, y:1.1}, 12, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );

			FlxTween.tween(bigringInplace2.scale, {x:1, y:1}, 20, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );
			FlxTween.tween(samringInplace2.scale, {x:1.1, y:1.1}, 20, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );

			FlxTween.tween(bigringInplace3.scale, {x:1, y:1}, 30, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );
			FlxTween.tween(samringInplace3.scale, {x:1.1, y:1.1}, 30, { ease: FlxEase.quadInOut, type: FlxTweenType.ONESHOT } );
		
		}

		if (FlxG.keys.justPressed.ONE)
		{
			backColor = 0xFFFFC300;
			patColor = 0xFFFFD200;
			bigRingColor = 0xFFFFD200;
			samRingColor = 0xFFFFDC49;
			gradColor = 0xFFFFE48E;
			FrontalGrad.alpha = 0.5;
		}

		if (FlxG.keys.justPressed.TWO)
		{
			backColor = 0xFFAA5BFF;
			patColor = 0xFFBD72FF;
			bigRingColor = 0xFFBD72FF;
			samRingColor = 0xFFBD72FF;
			gradColor = 0xFFCD99FF;
			FrontalGrad.alpha = 1;
		}

		if (FlxG.keys.justPressed.THREE)
		{
			backColor = 0xFF0EA3F3;
			patColor = 0xFF10C1F3;
			bigRingColor = 0xFF10C1F3;
			samRingColor = 0xFF10C1F3;
			gradColor = 0xFF49E2E5;
			FrontalGrad.alpha = 1;
		}

		if (FlxG.keys.justPressed.FOUR)
		{
			backColor = 0xFF390873;
			patColor = 0xFF560087;
			bigRingColor = 0xFF560087;
			samRingColor = 0xFF560087;
			gradColor = 0xFFB4009F;
			FrontalGrad.alpha = 1;
		}

		if (FlxG.keys.justPressed.FIVE)
		{
			backColor = 0xFF00A0A8;
			patColor = 0xFF00AEAF;
			bigRingColor = 0xFF00AEAF;
			samRingColor = 0xFF00AEAF;
			gradColor = 0xFFD6D672;
			FrontalGrad.alpha = 1;
		}

		if (FlxG.keys.justPressed.SIX)
		{
			backColor = 0xFF1E0092;
			patColor = 0xFF2E00A0;
			bigRingColor = 0xFF2E00A0;
			samRingColor = 0xFF2E00A0;
			gradColor = 0xFFC85363;
			FrontalGrad.alpha = 1;
		}

		if (FlxG.keys.justPressed.SEVEN)
		{
			backColor = 0xFF3C3C9C;
			patColor = 0xFF4643AE;
			bigRingColor = 0xFF4643AE;
			samRingColor = 0xFF4643AE;
			gradColor = 0xFF157CCD;
			FrontalGrad.alpha = 1;
		}

		if (FlxG.keys.justPressed.ZERO && isStupid != true)
		{
			backColor = 0xFF5296E1;
			patColor = 0xFF639CE3;
			bigRingColor = 0xFF639CE3;
			samRingColor = 0xFF7EA7E9;
			gradColor = 0xFFCCDFFF;
			FrontalGrad.alpha = 0.5;
		}

		if (FlxG.keys.justPressed.Q)
		{
			backColor = 0xFFBEBEBE;
			patColor = 0xFFC7C7C7;
			bigRingColor = 0xFFC7C7C7;
			samRingColor = 0xFFD5D5D5;
			gradColor = 0xFFE2E2E2;
			FrontalGrad.alpha = 0.5;
		}

		if (FlxG.keys.justPressed.ANY) //updates the color of the stuff
		{
			bg.color = backColor;
			bgPattern.color = patColor;
			bigring.color = bigRingColor;
			bigring2.color = bigRingColor;
			bigring3.color = bigRingColor;
			bigring4.color = bigRingColor;
			bigring5.color = bigRingColor;
			bigring6.color = bigRingColor;
			bigring7.color = bigRingColor;
			bigring8.color = bigRingColor;
			bigringInplace.color = bigRingColor;
			bigringInplace2.color = bigRingColor;
			bigringInplace3.color = bigRingColor;
			samring.color = samRingColor;
			samring2.color = samRingColor;
			samring3.color = samRingColor;
			samring4.color = samRingColor;
			samring5.color = samRingColor;
			samring6.color = samRingColor;
			samring7.color = samRingColor;
			samring8.color = samRingColor;
			samringInplace.color = samRingColor;
			samringInplace2.color = samRingColor;
			samringInplace3.color = samRingColor;
			FrontalGrad.color = gradColor;
		}

		if (controls.BACK)
		{
			isStupid = true;
			FlxG.sound.muteKeys = TitleState.muteKeys;
			MusicBeatState.switchState(new BackgroundState());
		}

		super.update(elapsed);
	}
}
