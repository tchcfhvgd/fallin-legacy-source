package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.2h'; //This is also used for Discord RPC
	public static var fallinVersion:String = '0.2.0';
	public static var curSelected:Int = 0;

	var daThing:String = "";
	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'credits',
		'options'
	];

	var optionDumb:Array<String> = [
		'story_mode',
		'freeplay-locked',
		'credits',
		'options'
	];

	var magenta:FlxSprite;
	var MenuCharacter:FlxSprite;
	var logoBl:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var ArrowGroup:FlxGroup;

	override function create()
	{
		FlxG.mouse.visible = false;

		curSelected = 0;

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

		var ui_tex = Paths.getSparrowAtlas('fallmen/MainMenu/MenuArrows');
		
		if (FlxG.save.data.DemoFreeplayUnlocked == true)
		{
			var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		}
		else
		{
			var yScroll:Float = Math.max(0.25 - (0.05 * (optionDumb.length - 4)), 0.1);
		}
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('fallmen/MainMenu/menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.setGraphicSize(Std.int(bg.width * 1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('fallmen/MainMenu/menuBGMagenta'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0;
		magenta.setGraphicSize(Std.int(magenta.width * 1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		add(magenta);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		if (FlxG.save.data.DemoFreeplayUnlocked == true)
		{
			for (i in 0...optionShit.length)
			{
				var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
				var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
				menuItem.scrollFactor.x = 1;
				menuItem.scrollFactor.y = 0;
				menuItem.scale.x = scale;
				menuItem.scale.y = scale;
				menuItem.frames = Paths.getSparrowAtlas('fallmen/MainMenu/menu_' + optionShit[i]);
				menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
				menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
				menuItem.animation.addByPrefix('press', optionShit[i] + " pressed", 24);
				menuItem.animation.play('idle');
				menuItem.ID = i;
				menuItem.screenCenter(X);
				menuItems.add(menuItem);
				var scr:Float = (optionShit.length - 4) * 0.135;
				menuItem.antialiasing = ClientPrefs.globalAntialiasing;
				menuItem.updateHitbox();
				FlxTween.tween(menuItem,{x: 408 + (i * 500)},1 + (i * -10000),{ease: FlxEase.expoInOut});
			}
		}
		else
		{
			for (i in 0...optionDumb.length)
			{
				var offset:Float = 108 - (Math.max(optionDumb.length, 4) - 4) * 80;
				var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
				menuItem.scrollFactor.x = 1;
				menuItem.scrollFactor.y = 0;
				menuItem.scale.x = scale;
				menuItem.scale.y = scale;
				menuItem.frames = Paths.getSparrowAtlas('fallmen/MainMenu/menu_' + optionDumb[i]);
				menuItem.animation.addByPrefix('idle', optionDumb[i] + " basic", 24);
				menuItem.animation.addByPrefix('selected', optionDumb[i] + " white", 24);
				menuItem.animation.addByPrefix('press', optionDumb[i] + " pressed", 24);
				menuItem.animation.play('idle');
				menuItem.ID = i;
				menuItem.screenCenter(X);
				menuItems.add(menuItem);
				var scr:Float = (optionDumb.length - 4) * 0.135;
				menuItem.antialiasing = ClientPrefs.globalAntialiasing;
				menuItem.updateHitbox();
				FlxTween.tween(menuItem,{x: 408 + (i * 500)},1 + (i * -10000),{ease: FlxEase.expoInOut});
			}
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		ArrowGroup = new FlxGroup();
		add(ArrowGroup);

		leftArrow = new FlxSprite(300, 307);
		leftArrow.scrollFactor.x = 0;
		leftArrow.scrollFactor.y = 0;
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
		ArrowGroup.add(leftArrow);

		rightArrow = new FlxSprite(933, 307);
		rightArrow.scrollFactor.x = 0;
		rightArrow.scrollFactor.y = 0;
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.antialiasing = ClientPrefs.globalAntialiasing;
		ArrowGroup.add(rightArrow);

		var random = FlxG.random.float(0, 200);
		trace(random);

		if (random >= 0 && random <= 20)
		{
			trace('CHARACTER summerpoint');
			daThing = 'summerpoint';
		}

		if (random >= 20.0000000000001 && random <= 40)
		{
			trace('CHARACTER bf');
			daThing = 'bf';
		}

		if (random >= 40.0000000000001 && random <= 60)
		{
			trace('CHARACTER gf');
			daThing = 'gf';
		}

		if (random >= 60.0000000000001 && random <= 80)
		{
			trace('CHARACTER dad');
			daThing = 'dad';
		}

		if (random >= 80.0000000000001 && random <= 100)
		{
			trace('CHARACTER cheer');
			daThing = 'cheer';
		}

		if (random >= 100.0000000000001 && random <= 120)
		{
			trace('CHARACTER bike');
			daThing = 'bike';
		}

		if (random >= 120.0000000000001 && random <= 140)
		{
			trace('CHARACTER amog');
			daThing = 'amog';
		}

		if (random >= 140.0000000000001 && random <= 160)
		{
			trace('CHARACTER sonic');
			daThing = 'sonic';
		}
		

		if (random >= 160.0000000000001 && random <= 180)
		{
			trace('CHARACTER afk');
			daThing = 'afk';
		}

		if (random >= 180.0000000000001 && random <= 200)
		{
			trace('CHARACTER hips');
			daThing = 'hips';
		}

		switch (daThing)
		{
			case 'summerpoint':
				MenuCharacter = new FlxSprite(-140, 800);
				MenuCharacter.frames = Paths.getSparrowAtlas('fallmen/MainMenu/Characters/SummerPoint');
				MenuCharacter.scrollFactor.x = 0;
				MenuCharacter.scrollFactor.y = 0;
				MenuCharacter.antialiasing = ClientPrefs.globalAntialiasing;
				MenuCharacter.scale.set(0.6, 0.6);
				MenuCharacter.animation.addByPrefix('play', 'sumpoint', 24, true);
				MenuCharacter.updateHitbox();
				MenuCharacter.animation.play('play');
				add(MenuCharacter);
			case 'bf':
				MenuCharacter = new FlxSprite(-40, 930);
				MenuCharacter.frames = Paths.getSparrowAtlas('fallmen/MainMenu/Characters/BOYFRIEND');
				MenuCharacter.scrollFactor.x = 0;
				MenuCharacter.scrollFactor.y = 0;
				MenuCharacter.antialiasing = ClientPrefs.globalAntialiasing;
				MenuCharacter.scale.set(1, 1);
				MenuCharacter.animation.addByPrefix('play', 'BF idle dance', 24);
				MenuCharacter.flipX = true;
				MenuCharacter.updateHitbox();
				MenuCharacter.animation.play('play');
				add(MenuCharacter);
			case 'gf':
				MenuCharacter = new FlxSprite(-160, 890);
				MenuCharacter.frames = Paths.getSparrowAtlas('fallmen/MainMenu/Characters/GF_assets');
				MenuCharacter.scrollFactor.x = 0;
				MenuCharacter.scrollFactor.y = 0;
				MenuCharacter.antialiasing = ClientPrefs.globalAntialiasing;
				MenuCharacter.scale.set(1, 1);
				MenuCharacter.animation.addByPrefix('play', 'GF Dancing Beat', 24);
				MenuCharacter.updateHitbox();
				MenuCharacter.animation.play('play');
				add(MenuCharacter);
			case 'dad':
				MenuCharacter = new FlxSprite(-70, 850);
				MenuCharacter.frames = Paths.getSparrowAtlas('fallmen/MainMenu/Characters/DADDY_DEAREST');
				MenuCharacter.scrollFactor.x = 0;
				MenuCharacter.scrollFactor.y = 0;
				MenuCharacter.antialiasing = ClientPrefs.globalAntialiasing;
				MenuCharacter.scale.set(0.9, 0.9);
				MenuCharacter.animation.addByPrefix('play', 'Dad idle dance', 24);
				MenuCharacter.updateHitbox();
				MenuCharacter.animation.play('play');
				add(MenuCharacter);
			case 'cheer':
				MenuCharacter = new FlxSprite(-250, 800);
				MenuCharacter.frames = Paths.getSparrowAtlas('fallmen/MainMenu/Characters/cheer');
				MenuCharacter.scrollFactor.x = 0;
				MenuCharacter.scrollFactor.y = 0;
				MenuCharacter.antialiasing = ClientPrefs.globalAntialiasing;
				MenuCharacter.scale.set(0.6, 0.6);
				MenuCharacter.animation.addByPrefix('play', 'bopping', 24);
				MenuCharacter.updateHitbox();
				MenuCharacter.animation.play('play');
				add(MenuCharacter);
			case 'bike':
				MenuCharacter = new FlxSprite(-250, 800);
				MenuCharacter.frames = Paths.getSparrowAtlas('fallmen/MainMenu/Characters/FirstDaringBike');
				MenuCharacter.scrollFactor.x = 0;
				MenuCharacter.scrollFactor.y = 0;
				MenuCharacter.antialiasing = ClientPrefs.globalAntialiasing;
				MenuCharacter.scale.set(0.6, 0.6);
				MenuCharacter.animation.addByPrefix('play', 'bopping', 24);
				MenuCharacter.updateHitbox();
				MenuCharacter.animation.play('play');
				add(MenuCharacter);
			case 'amog':
				MenuCharacter = new FlxSprite(-250, 800);
				MenuCharacter.frames = Paths.getSparrowAtlas('fallmen/MainMenu/Characters/amog');
				MenuCharacter.scrollFactor.x = 0;
				MenuCharacter.scrollFactor.y = 0;
				MenuCharacter.antialiasing = ClientPrefs.globalAntialiasing;
				MenuCharacter.scale.set(0.6, 0.6);
				MenuCharacter.animation.addByPrefix('play', 'bopping', 24);
				MenuCharacter.updateHitbox();
				MenuCharacter.animation.play('play');
				add(MenuCharacter);
			case 'sonic':
				MenuCharacter = new FlxSprite(-250, 800);
				MenuCharacter.frames = Paths.getSparrowAtlas('fallmen/MainMenu/Characters/sonic');
				MenuCharacter.scrollFactor.x = 0;
				MenuCharacter.scrollFactor.y = 0;
				MenuCharacter.antialiasing = ClientPrefs.globalAntialiasing;
				MenuCharacter.scale.set(0.6, 0.6);
				MenuCharacter.animation.addByPrefix('play', 'bopping', 24);
				MenuCharacter.updateHitbox();
				MenuCharacter.animation.play('play');
				add(MenuCharacter);
			case 'afk':
				MenuCharacter = new FlxSprite(-250, 800);
				MenuCharacter.frames = Paths.getSparrowAtlas('fallmen/MainMenu/Characters/afk');
				MenuCharacter.scrollFactor.x = 0;
				MenuCharacter.scrollFactor.y = 0;
				MenuCharacter.antialiasing = ClientPrefs.globalAntialiasing;
				MenuCharacter.scale.set(0.6, 0.6);
				MenuCharacter.animation.addByPrefix('play', 'bopping', 24);
				MenuCharacter.updateHitbox();
				MenuCharacter.animation.play('play');
				add(MenuCharacter);
			case 'hips':
				MenuCharacter = new FlxSprite(-250, 800);
				MenuCharacter.frames = Paths.getSparrowAtlas('fallmen/MainMenu/Characters/sonic');
				MenuCharacter.scrollFactor.x = 0;
				MenuCharacter.scrollFactor.y = 0;
				MenuCharacter.antialiasing = ClientPrefs.globalAntialiasing;
				MenuCharacter.scale.set(0.6, 0.6);
				MenuCharacter.animation.addByPrefix('play', 'bopping', 24);
				MenuCharacter.updateHitbox();
				MenuCharacter.animation.play('play');
				add(MenuCharacter);
		}

		FlxTween.tween(MenuCharacter, {y: MenuCharacter.y - 500}, 1, {ease: FlxEase.quartInOut});

		logoBl = new FlxSprite(-35, -25);
		logoBl.scrollFactor.x = 0;
		logoBl.scrollFactor.y = 0;
		logoBl.frames = Paths.getSparrowAtlas('fallmen/Title/logoBumpin');
		logoBl.antialiasing = ClientPrefs.globalAntialiasing;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		logoBl.animation.play('bump');
		logoBl.scale.set(0.3, 0.3);
		logoBl.updateHitbox();
		add(logoBl);

		var versionShit:FlxText = new FlxText(12, FlxG.height -40, 1266, "Psych Engine v" + psychEngineVersion + " (Modified)", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShit.antialiasing = ClientPrefs.globalAntialiasing;
		versionShit.borderSize = 1.5;
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height -20, 1266, "Friday Night Fallin' v" + fallinVersion + "s (DEMO)", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShit.antialiasing = ClientPrefs.globalAntialiasing;
		versionShit.borderSize = 1.5;
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
					
		if (!selectedSomethin)
		{	
			if (controls.UI_RIGHT)
				rightArrow.animation.play('press')
			else
				rightArrow.animation.play('idle');

			if (controls.UI_LEFT)
				leftArrow.animation.play('press');
			else
				leftArrow.animation.play('idle');

			if (controls.UI_LEFT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}
			
			if (controls.UI_RIGHT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				persistentUpdate = false;
				FlxG.sound.play(Paths.sound('cancelMenu'), 1);
				openSubState(new ExitGameSubState());
			}

			if (controls.ACCEPT)
			{
				if (curSelected == 1 && !FlxG.save.data.DemoFreeplayUnlocked)
				{
					FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.3));
					camGame.shake(0.005, 0.2);
				}
				else
				{
					{
						selectedSomethin = true;
						FlxG.sound.play(Paths.sound('confirmMenu'));
					
					if (FlxG.save.data.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 1}, 1, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
								}
							});
						}
						else
						{

							if (FlxG.save.data.flashing = true)
							{
								{
									spr.animation.play('press');
								};
							}

							if (FlxG.save.data.flashing = true)
								{
									FlxTween.tween(spr, {alpha: 1}, 1, {
										ease: FlxEase.quadOut,
										onComplete: function(twn:FlxTween)
										{
										}
									});
								}

							if (FlxG.save.data.flashing = false)
							{
								{
									spr.animation.play('press');
								};
							}

							if (FlxG.save.data.flashing = false)
								{
									FlxTween.tween(spr, {alpha: 1}, 1, {
										ease: FlxEase.quadOut,
										onComplete: function(twn:FlxTween)
										{
										}
									});
								}

							FlxFlicker.flicker(spr, 1, 1, true, true, function(flick:FlxFlicker)
							{

								var daChoice:String = optionShit[curSelected];
								var daBoice:String = optionDumb[curSelected];
								
								if (FlxG.save.data.DemoFreeplayUnlocked == true)
								{
									switch (daChoice)
									{
										case 'story_mode':
											MusicBeatState.switchState(new StoryMenuState());
										case 'freeplay':
											MusicBeatState.switchState(new FreeplayState());
										case 'credits':
											MusicBeatState.switchState(new CreditsState());
										case 'options':
											LoadingState.loadAndSwitchState(new options.OptionsState());
									}
								}
								else
								{
									switch (daBoice)
									{
										case 'story_mode':
											MusicBeatState.switchState(new StoryMenuState());
										case 'credits':
											MusicBeatState.switchState(new CreditsState());
										case 'options':
											LoadingState.loadAndSwitchState(new options.OptionsState());
									}
								}
							});
						}
					});
				}
			}
		}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(Y);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				spr.updateHitbox();
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
				spr.updateHitbox();
			}
		});
	}
}
