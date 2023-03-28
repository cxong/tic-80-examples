-- title:   Button
-- author:  JoaoPauloVF
-- desc:    A function that creates buttons that interact with the mouse
-- github:  https://github.com/JoaoPauloVF/Button
-- license: MIT License
-- version: 0.3
-- script:  lua
-- input:   mouse
-- palette: 101015e64040651818ff9d59814410eeee447d7d10b6b6d244445d40e6e630919110343410284444f244107110f6f6f8

--[[
	* Visit the wiki page for general 
	instructions and Button object 
	explanation:
	
	https://github.com/JoaoPauloVF/Button/wiki
	
	* Check the summary below to access 
	the function code or usage	examples.
	
            ----Summary----

 (ctrl+f, search for the term or 
 chapter and press down):
 
 BOOT() Function
   Constants
   Button() Function...........:-1-
   Swicth() Function           :-2-
   print Functions.............:
     printAlign()              :
     printTitle()..............:
   		printInstruction()        :
   Demo Code...................:-3-
     Pressing Example          :3-1
     Releasing Example.........:3-2
     Switching Example         :3-3
 TIC() Function................:
]]--

----BOOT() Function----
function BOOT()
	----Constants----
	BORDER_COLOR = 0x3FF8
	--CURSOR_ADDR = 0x3FFB
	
	WIDTH = 240
	HEIGHT = 136
	
	WHITE = 15
	DARK_GRAY = 8
	DARK_BLUE = 12
	
	BG_COLOR = DARK_BLUE
	
	SPR_SIZE = 8
	
	demoTitle = "Button()/Switch() Demo"
	
	--1--Button() Function----
	--[[
		This is the Button function. 
		You can try it in your code or go
		to the "Demo Code" to see some 
		examples. 
		
		There are some sprites samples in 
		the sprite editor too.
	]]--
	function Button(settings)
		local self = {}
		
		self.x = type(settings.x)=="number" and settings.x or 0
		self.y = type(settings.y)=="number" and settings.y or 0
		self.sprites = type(settings.sprites)=="table" and settings.sprites or {256, 257}
		self.sprW = type(settings.sprW)=="number" and settings.sprW or 1
		self.sprH = type(settings.sprH)=="number" and settings.sprH or 1
		self.scale = type(settings.scale)=="number" and settings.scale or 1
		self.colorKey = type(settings.colorKey)=="number" and settings.colorKey or 0
		self.flip = type(settings.flip)=="number" and settings.flip or 0
		self.rotate = type(settings.rotate)=="number" and settings.rotate or 0
		self.margins = type(settings.margins)=="table" and settings.margins or {top=0, bottom=0, left=0, right=0}
		
		self.changeCursor = true
		if type(settings.changeCursor)=="boolean" then
			self.changeCursor = settings.changeCursor
		end
		
		--Check if the margins values are numbers
		for _, side in pairs({"top", "bottom", "left", "right"}) do
			if not(self.margins[side]) then
				self.margins[side] = 0
			end
		end
		
		local cursors = {128, 129}--{arrow, hand}
		
		local sprId = self.sprites[1]
		
		--button state variables
		local pressed = false
		local wasPressed = false
		local released = false
		
		--cursor state variables
		local cursorIsOnButton = false
		local cursorWasOnButton = false
		local cursorJustLeft = false
		
		local SPR_SIZE = 8
		
		local width = self.scale*(SPR_SIZE*self.sprW-self.margins.right-self.margins.left)
		local height = self.scale*(SPR_SIZE*self.sprH-self.margins.bottom-self.margins.top)
		
		self.getWidth = function()
			return width
		end
		self.getHeight = function()
			return height
		end
		
		self.centralize = function(xAxis, yAxis)
			if xAxis then
				self.x = self.x - self.margins.left*self.scale - width/2
			end
			if yAxis then
				self.y = self.y - self.margins.top*self.scale - height/2
			end
		end
		
		self.updateState = function()
			local mouseX, mouseY, left = mouse()
			
			local sprWidth = SPR_SIZE * self.sprW
			local sprHeight = SPR_SIZE * self.sprH
			
			local x1 = self.x + self.margins.left*self.scale
			local x2 = self.x + self.scale*(sprWidth - self.margins.right)
			local y1 = self.y + self.margins.top*self.scale
			local y2 = self.y + self.scale*(sprHeight - self.margins.bottom)
			
			cursorIsOnButton = 
				mouseX >= x1 and mouseX <= x2 and
				mouseY >= y1 and mouseY <= y2

			local pressed = left and cursorIsOnButton 
			local released = wasPressed and not(pressed) and cursorIsOnButton
			
			cursorJustLeft = cursorWasOnButton and not(cursorIsOnButton)
			
			wasPressed = pressed
			cursorWasOnButton = cursorIsOnButton
			
			return pressed, released
		end
		
		self.updateSprId = function(conditional)
			sprId = conditional and self.sprites[2] or self.sprites[1]
		end
		
		self.updateCursor = function()
			local CURSOR_ADDR = 0x3FFB
			if self.changeCursor then
				if cursorJustLeft then
					poke(CURSOR_ADDR, cursors[1])
				elseif cursorIsOnButton then
					poke(CURSOR_ADDR, cursors[2])
				end
			end
		end
		
		
		self.isPressed = function()
			return pressed
		end
		self.isReleased = function()
			return released
		end
		
		self.update = function()
			pressed, released = self.updateState()
			self.updateSprId(pressed)
			self.updateCursor()
		end
		
		self.render = function()
			spr(
				sprId, 
				self.x, self.y, 
				self.colorKey, 
				self.scale, 
				self.flip, self.rotate, 
				self.sprW, self.sprH
			)
		end
		
		
		return self
	end
	--2--Switch() Function----
	--[[
		The Switch object is like a Button 
		object. The difference is that the 
		first has the boolean attribute "on"
		that inverts its value when the 
		Switch is clicked. The sprite is 
		based on this value too.
  
		Note that the function needs the 
		Button() to work.	
	]]--
	function Switch(settings)
		local self = Button(settings)
		
		local on = false
		
		self.isOn = function()
			return on
		end
		
		self.update = function()
			local pressed, released = self.updateState()
			
			if released then on = not(on) end
			self.updateSprId(on)
			self.updateCursor()
		end
		
		return self
	end
	
	----prints Functions----
	
	----printAlign()----
	--[[
		The normal print with Alignment 
		options.
		
		I already have made a cartridge 
		for it: https://tic80.com/play?cart=2594
	]]--
	local function printAlign(text, x, y, alignX, alignY, color, fixed, scale, smallFont)
 	local x = x or 0
		local y = y or 0
		local alignX = alignX or "right"
		local alignY = alignY or "bottom"
		local color = color or 15
		local fixed = fixed or false
		local scale = scale or 1
		local smallFont = smallFont or false
	  
		local font_h = 6 * scale
		local font_w = print(text, 0, -font_h*scale*1024, color, fixed, scale, smallFont)
	  
		x = alignX=="right" and x or alignX=="center" and x - font_w//2 or alignX=="left" and x - font_w + 1*scale or x 
		y = alignY=="bottom" and y or alignY=="middle" and y - font_h//2 or alignY=="top" and y - font_h + 1*scale or y 
	  
		print(text, x, y, color, fixed, scale, smallFont)
	end
	----printTitle()----
	--[[
		It use the previous function to 
		print the demo title.
	]]--
	function printTitle(title)
		local x = WIDTH*0.5
		local y = HEIGHT*0.03*4
		printAlign(
				title, 
				x, y, 
				"center", "middle", 
				WHITE, 
				false, 
				2,
				smallFont
		)
	end
	----printInstruction()----
	--[[
		It prints the examples texts.
	]]--
	function printInstruction(text, y, button, x)
		local x = x or button.x + button.getWidth()/2 + button.margins.left*button.scale
		local y = y or 0
		printAlign(
				text, 
				x, y, 
				"center", "middle", 
				WHITE, 
				false, 
				1,
				smallFont
		)
	end
	--3--Demo Code----
	--[[
		Here, I create some Buttons and 
		a Switch and use them.
		
		In case you have doubts about 
		using the function, this part can 
		help you.
	]]--
	
	--3-1-Pressing Example----
	--[[
		This is the example more to the 
		left. It tests the "pressed" 
		attribute.
		
		It consists of two buttons and 
		a number.
		It decreases if one of the buttons 
		is pressed and increases if the 
		other one is.
	]]--
	number = 0
	
	minusX = WIDTH*0.06
	minusY = HEIGHT*0.48
	--Button to decrease the number
	minusB = Button({
		x=minusX,
		y=minusY,
		sprites = {305, 306},--{not pressed, pressed}
		scale = 3,
		margins = {left=1}--The button sprite lets a column without pixels from the left side. See it in the sprite editor.
	})
	
	plusX = minusB.x + SPR_SIZE*3.5
	plusY = HEIGHT*0.48
	--Button to increase the number
	plusB = Button({
		x=plusX,
		y=plusY,
		sprites = {289, 290},
		scale = 3,
		margins = {left=1}
	})
	
	--Update the buttons and update 
	--the number if some of them 
	--are pressed
	function updatePressingExample()
		plusB.update()
		minusB.update()
			
		if plusB.isPressed() then
			number=number+1
		end
		if minusB.isPressed() then
			number=number-1
		end
	end
	
	function renderPressingExample()
		local x = minusB.x+(SPR_SIZE*minusB.scale*1.2)
		--Render the number
		printAlign(
			number, 
			x, minusB.y*0.9, 
			"center", "middle", 
			WHITE, 
			false, 2,
			smallFont
		)
		--Render Instruction
		printInstruction("Click and hold", HEIGHT*0.75, minusB, x)
		--Render the buttons
		plusB.render()
		minusB.render()
	end
	--3-2-Releasing Example----
	--[[
		This is the example on the screen 
		center.
	
		Press and release the button 
		to alter the screen border-color.
	]]--
	borderColor = peek4(BORDER_COLOR*2)
	borderColorB = Button({
		x = WIDTH*0.5,
		y = HEIGHT*0.37,
		sprites = {259, 261},
		sprW = 2,--The sprite uses a 16x16 canvas
		sprH = 2,
		scale = 3,
		--These margins ensure that only the middle of the sprite is clickable.
		margins = {top=3, bottom=3, left=4, right=4}
	})
	borderColorB.centralize(true)
	
	function updateReleasingExample()
		borderColorB.update()--Update button
		
		if borderColorB.isReleased() then
			--Alter the screen color-border
			local newColor = math.random(0, 15)
			
			if newColor == borderColor then
				newColor = borderColor<15 and borderColor+1 or borderColor-1
			end
			borderColor = newColor
			
			poke4(BORDER_COLOR*2, newColor)
		end
	end
	function renderReleasingExample()
		--Render Instruction
		printInstruction("Click and release", HEIGHT*0.36, borderColorB)
		--Render button
		borderColorB.render()
	end
	
	--3-3-Switching Example----
	--[[
		The last example is composed of 
		a switch. 
 
		Click on it to turn it on/off.
 
		If it is on, all the texts get 
		in small font. Else, they get in 
		normal font.
	]]--
	smallFont = false
	smallFontS = Switch({
		x = WIDTH*0.75,
		y = HEIGHT*0.54,
		sprites = {291, 292},
		scale = 5,
		margins = {top=1, bottom=1, left=3, right=3}
	})
	smallFontS.centralize(false, true)
	
	function updateSwitchingExample()
		smallFontS.update()--Update button
		smallFont = smallFontS.isOn()--Update smallFont
	end
	
	function renderSwitchingExample()
		--Render Instruction
		printInstruction("Click to\n\nturn on/off", HEIGHT*0.75, smallFontS)
		--Render swicth
		smallFontS.render()
	end
end
----TIC() Function----
function TIC()
	updatePressingExample()
	updateReleasingExample()
	updateSwitchingExample()
	
	cls(BG_COLOR)
	
	printTitle(demoTitle)
	
	renderPressingExample()
	renderReleasingExample()
	renderSwitchingExample()
end
-- <SPRITES>
-- 001:0dddddd0dddfdddddddffddddddfffdddddffddddddfddddedddddde0eeeeee0
-- 002:000000000dddddd0dddfdddddddffddddddfffdddddffddddddfdddd0dddddd0
-- 003:000000000000000000000000000000ff00000f990000f9990007f99900079999
-- 004:00000000000000000000000099000000999000009999000099997000999a7000
-- 005:00000000000000000000000000000077000007ff00007f990007f9990007f999
-- 006:0000000000000000000000007700000099700000999700009999700099997000
-- 017:0070000000770000007770000077770000777800007780000078000000800000
-- 018:0000000000700000007700000077700000777700007770000077000000700000
-- 019:000799990007b9990007bb9900007bbb000007bb000000770000000000000000
-- 020:999a700099ab7000aabb8000bbb80000bb800000780000000000000000000000
-- 021:00079999000799990007b99900007b99000007bb000000770000000000000000
-- 022:999a7000999a700099ab8000aab80000bb800000780000000000000000000000
-- 033:055555550555f5550555f55505fffff50555f5550555f5550555555506666666
-- 034:00000000055555550555f5550555f55505fffff50555f5550555f55505555555
-- 035:00f77700007f1700007117000072270000722700007227000072270000777700
-- 036:00f7770000722700007227000072270000722700007f17000071170000777700
-- 049:05555555055555550555555505fffff505555555055555550555555506666666
-- 050:0000000005555555055555550555555505fffff5055555550555555505555555
-- </SPRITES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <TRACKS>
-- 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </TRACKS>

-- <SCREEN>
-- 000:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 001:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 002:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 003:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 004:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 005:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 006:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 007:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 008:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 009:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 010:cccccffffffffccccccccccccccccccffffccccccccffffccccccccccccccccccccccccccccccccffccffccccccccccccffccccffffffffccccccccccccccffffccccffffccccccccccccccccccffffccccccccccffccffccccccccccccffffffffccccccccccccccccccccccccccccccccccccccccccccc
-- 011:cccccffffffffccccccccccccccccccffffccccccccffffccccccccccccccccccccccccccccccccffccffccccccccccccffccccffffffffccccccccccccccffffccccffffccccccccccccccccccffffccccccccccffccffccccccccccccffffffffccccccccccccccccccccccccccccccccccccccccccccc
-- 012:cccccffffccccffccffffccccffccffffffffffccffffffffffccccffffffccccffffffffccccffccccccffccccccccffccccffffffccccccffccccccffccccccccffffffffffccccffffffffccffffffffccccffccccccffccccccccccffffccccffccccffffffccccffffccffccccccffffffccccccccc
-- 013:cccccffffccccffccffffccccffccffffffffffccffffffffffccccffffffccccffffffffccccffccccccffccccccccffccccffffffccccccffccccccffccccccccffffffffffccccffffffffccffffffffccccffccccccffccccccccccffffccccffccccffffffccccffffccffccccccffffffccccccccc
-- 014:cccccffffffffccccffffccccffccccffffccccccccffffccccccffffccccffccffffccccffccffccccccffccccccffccccccccffffffccccffccffccffccffffccccffffccccccffffffccccccffffccccffccffccccccffccccccccccffffccccffccffffccffffccffffffffffccffffccccffccccccc
-- 015:cccccffffffffccccffffccccffccccffffccccccccffffccccccffffccccffccffffccccffccffccccccffccccccffccccccccffffffccccffccffccffccffffccccffffccccccffffffccccccffffccccffccffccccccffccccccccccffffccccffccffffccffffccffffffffffccffffccccffccccccc
-- 016:cccccffffccccffccffffccccffccccffffccccccccffffccccccffffccccffccffffccccffccffccccccffccccffccccccccccccffffffccffffffffffccffffccccffffccccccffffffccccccffffccccffccffccccccffccccccccccffffccccffccffffffccccccffccffccffccffffccccffccccccc
-- 017:cccccffffccccffccffffccccffccccffffccccccccffffccccccffffccccffccffffccccffccffccccccffccccffccccccccccccffffffccffffffffffccffffccccffffccccccffffffccccccffffccccffccffccccccffccccccccccffffccccffccffffffccccccffccffccffccffffccccffccccccc
-- 018:cccccffffffffccccccffffffccccccccffffffccccccffffffccccffffffccccffffccccffccccffccffccccffccccccccccffffffffccccffffccffffccffffccccccffffffccccffffffffccffffccccffccccffccffccccccccccccffffffffccccccffffffccccffccffccffccccffffffccccccccc
-- 019:cccccffffffffccccccffffffccccccccffffffccccccffffffccccffffffccccffffccccffccccffccffccccffccccccccccffffffffccccffffccffffccffffccccccffffffccccffffffffccffffccccffccccffccffccccccccccccffffffffccccccffffffccccffccffccffccccffffffccccccccc
-- 020:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 021:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 022:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 023:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 024:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 025:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 026:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 027:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 028:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 029:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 030:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 031:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 032:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 033:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 034:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 035:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 036:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 037:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 038:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 039:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 040:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 041:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 042:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 043:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 044:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 045:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffccffcccffcccccccffcccccccccccccccccccccccffcccccccccccccccccffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 046:ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffccfcffcccccccffffcffccfccccccffffcffffcccffffcccccffffcccfffccffccccfffcccffffccffffccfffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 047:ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffccccffcccffcfffcccffffccccccfccffcffccfcfccffcccccffccfcffcffcffcccffcffcfccffcfffcccffcffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 048:ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffccfcffcccffcfffcccffccfcccccfccffcffccfcfccffcccccffccccfffcccffcccfffcccfccffcccfffcfffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 049:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffcccfffcffccffffcffccfccccccffffcffccfccffffcccccffcccccfffcccfffccfffcccffffcffffcccfffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 050:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 051:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 052:cccccccccccccccccccccccccccccccccccccccffffffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 053:cccccccccccccccccccccccccccccccccccccccffffffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffff777777777777777cccccccccccccccccccccccccccccc
-- 054:cccccccccccccccccccccccccccccccccccccffffccffffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffff777777777777777cccccccccccccccccccccccccccccc
-- 055:cccccccccccccccccccccccccccccccccccccffffccffffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffff777777777777777cccccccccccccccccccccccccccccc
-- 056:cccccccccccccccccccccccccccccccccccccffffffccffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffff777777777777777cccccccccccccccccccccccccccccc
-- 057:cccccccccccccccccccccccccccccccccccccffffffccffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffff777777777777777cccccccccccccccccccccccccccccc
-- 058:cccccccccccccccccccccccccccccccccccccffffccccffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777fffff1111177777cccccccccccccccccccccccccccccc
-- 059:cccccccccccccccccccccccccccccccccccccffffccccffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc777777777777cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777fffff1111177777cccccccccccccccccccccccccccccc
-- 060:cccccccccccccccccccccccccccccccccccccccffffffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc777777777777cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777fffff1111177777cccccccccccccccccccccccccccccc
-- 061:cccccccccccccccccccccccccccccccccccccccffffffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc777777777777cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777fffff1111177777cccccccccccccccccccccccccccccc
-- 062:ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc777ffffff999999777ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777fffff1111177777cccccccccccccccccccccccccccccc
-- 063:ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc777ffffff999999777ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777111111111177777cccccccccccccccccccccccccccccc
-- 064:ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc777ffffff999999777ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777111111111177777cccccccccccccccccccccccccccccc
-- 065:ccccccccccccccccc555555555555555555555ccccccc555555555555555555555cccccccccccccccccccccccccccccccccccccccccc777fff999999999999999777cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777111111111177777cccccccccccccccccccccccccccccc
-- 066:ccccccccccccccccc555555555555555555555ccccccc555555555555555555555cccccccccccccccccccccccccccccccccccccccccc777fff999999999999999777cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777111111111177777cccccccccccccccccccccccccccccc
-- 067:ccccccccccccccccc555555555555555555555ccccccc555555555555555555555cccccccccccccccccccccccccccccccccccccccccc777fff999999999999999777cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777111111111177777cccccccccccccccccccccccccccccc
-- 068:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777fff999999999999999999999777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 069:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777fff999999999999999999999777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 070:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777fff999999999999999999999777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 071:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777fff999999999999999999999777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 072:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777fff999999999999999999999777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 073:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777fff999999999999999999999777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 074:ccccccccccccccccc555fffffffffffffff555ccccccc555fffffffffffffff555ccccccccccccccccccccccccccccccccccccccc777999999999999999999999aaa777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 075:ccccccccccccccccc555fffffffffffffff555ccccccc555fffffffffffffff555ccccccccccccccccccccccccccccccccccccccc777999999999999999999999aaa777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 076:ccccccccccccccccc555fffffffffffffff555ccccccc555fffffffffffffff555ccccccccccccccccccccccccccccccccccccccc777999999999999999999999aaa777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 077:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777999999999999999999999aaa777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 078:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777999999999999999999999aaa777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 079:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777999999999999999999999aaa777ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 080:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777bbb999999999999999aaabbb888ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 081:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777bbb999999999999999aaabbb888ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 082:ccccccccccccccccc555555555555555555555ccccccc555555555fff555555555ccccccccccccccccccccccccccccccccccccccc777bbb999999999999999aaabbb888ccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 083:ccccccccccccccccc555555555555555555555ccccccc555555555555555555555cccccccccccccccccccccccccccccccccccccccccc777bbb999999aaaaaabbb888cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 084:ccccccccccccccccc555555555555555555555ccccccc555555555555555555555cccccccccccccccccccccccccccccccccccccccccc777bbb999999aaaaaabbb888cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 085:ccccccccccccccccc555555555555555555555ccccccc555555555555555555555cccccccccccccccccccccccccccccccccccccccccc777bbb999999aaaaaabbb888cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 086:ccccccccccccccccc666666666666666666666ccccccc666666666666666666666ccccccccccccccccccccccccccccccccccccccccccccc777bbbbbbbbbbbb888ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 087:ccccccccccccccccc666666666666666666666ccccccc666666666666666666666ccccccccccccccccccccccccccccccccccccccccccccc777bbbbbbbbbbbb888ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777222222222277777cccccccccccccccccccccccccccccc
-- 088:ccccccccccccccccc666666666666666666666ccccccc666666666666666666666ccccccccccccccccccccccccccccccccccccccccccccc777bbbbbbbbbbbb888ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777777777777777777cccccccccccccccccccccccccccccc
-- 089:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc777777777888cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777777777777777777cccccccccccccccccccccccccccccc
-- 090:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc777777777888cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777777777777777777cccccccccccccccccccccccccccccc
-- 091:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc777777777888cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777777777777777777cccccccccccccccccccccccccccccc
-- 092:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777777777777777777cccccccccccccccccccccccccccccc
-- 093:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 094:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 095:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 096:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 097:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 098:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 099:cccccccfffccffcccffcccccccffcccccccccccccccccccccccffcccccffccccccccccffccccccffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffccffcccffcccccccffcccccccccffccccccccccccccccccccccccccccccccccccccc
-- 100:ccccccffccfcffcccccccffffcffccfccccccffffcffffcccffffcccccffffcccfffccffccccffffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffccfcffcccccccffffcffccfcccccfffffccfffcccccccccccccccccccccccccccccccc
-- 101:ccccccffccccffcccffcfffcccffffccccccfccffcffccfcfccffcccccffccfcffccfcffcccfccffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffccccffcccffcfffcccffffcccccccffcccffccfccccccccccccccccccccccccccccccc
-- 102:ccccccffccfcffcccffcfffcccffccfcccccfccffcffccfcfccffcccccffccfcffccfcffcccfccffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffccfcffcccffcfffcccffccfccccccffcccffccfccccccccccccccccccccccccccccccc
-- 103:cccccccfffcccfffcffccffffcffccfccccccffffcffccfccffffcccccffccfccfffcccfffccffffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffcccfffcffccffffcffccfcccccccfffccfffcccccccccccccccccccccccccccccccc
-- 104:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 105:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 106:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 107:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 108:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 109:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 110:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 111:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffcccccccccccccccccccccccccccccccccccccccccfcccccccccfffcccfffccccccccc
-- 112:ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffffcffccfcffffccffffcccccccfffccffffcccccfcccfffcccffccccffccccccccccc
-- 113:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffcccffccfcffccfcffccfcccccffccfcffccfcccfcccffccfcfffffcfffffccccccccc
-- 114:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffcccffccfcffccccffccfcccccffccfcffccfccfccccffccfccffccccffccccccccccc
-- 115:ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffccfffccffccccffccfccccccfffccffccfcfccccccfffcccffccccffccccccccccc
-- 116:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 117:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 118:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 119:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 120:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 121:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 122:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 123:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 124:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 125:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 126:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 127:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 128:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 129:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 130:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 131:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 132:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 133:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 134:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 135:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- </SCREEN>

-- <PALETTE>
-- 000:101015e64040651818ff9d59814410eeee447d7d10b6b6d244445d40e6e630919110343410284444f244107110f6f6f8
-- </PALETTE>

