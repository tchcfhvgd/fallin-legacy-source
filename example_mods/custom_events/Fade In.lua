function onEvent(name, value1, value2)
	if name == "Fade In" then
	   makeLuaSprite('dark', 0, 0);
        makeGraphic('dark',1280,720,'000000')
	      addLuaSprite('dark', true);
		doTweenColor('hello', 'dark', 'FFFFFFFF', 0.5, 'quartIn');
		setObjectCamera('dark', 'other');
		runTimer('wait', value1);
	end
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'wait' then
		doTweenAlpha('byebye', 'dark', 0, 0.3, 'linear');
	end
end

function onTweenCompleted(tag)
	if tag == 'byebye' then
		removeLuaSprite('dark', true);
	end
end