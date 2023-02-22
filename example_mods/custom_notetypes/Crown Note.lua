function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Crown Note' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.2'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.4');

			if getPropertyFromGroup('unspawnNotes', i) then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --true means notes are missed by oppenent
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Crown Note' then
		characterPlayAnim('gf', 'cheer', true);
		setProperty('gf.specialAnim', true);
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Crown Note' then
		playSound('goldmiss', 0.5);
		characterPlayAnim('boyfriend', 'hurt', true);
		setProperty('boyfriend.specialAnim', true);
		characterPlayAnim('gf', 'sad', true);
		setProperty('gf.specialAnim', true);
		cameraShake('camGame', 0.01, 0.5)
	end
end