-- title:   Clip scrolling
-- author:  congusbongus
-- desc:    Scrolling sprite animation effect using clip
-- license: MIT License
-- script:  moon
-- tags:    draw animation effect scroll clip

t=0
x=63
y=36
-- Clipping area
clipx=84
clipy=44
clipw=54
cliph=30

-- Draw a tiled sprite inside a clipping area
drawtileclip=(x,y,w,h,drawf,cx,cy,cw,ch)->
	clip cx,cy,cw,ch
	-- Find start of tile drawing
	xstart=x
	while xstart>cx
		xstart-=w
	while xstart+w<=cx
		xstart+=w
	ystart=y
	while ystart>cy
		ystart-=h
	while ystart+h<=cy
		ystart+=h
	-- Draw tiled
	y=ystart
	while y<cy+ch
		x=xstart
		while x<cx+cw
			drawf(x,y)
			x+=w
		y+=h
	clip!

export TIC=->
	if btn 0
		y-=1
	if btn 1
		y+=1
	if btn 2
		x-=1
	if btn 3
		x+=1

	cls 13
	spr 1,72,20,14,6,0,0,2,2
	drawf=(x,y)->spr 3,x,y,14,3,0,0,4,2
	drawtileclip(x,y,96,48,drawf,clipx,clipy,clipw,cliph)
	print("Use directions to move my eyes!",35,120)
	trace x
	trace y
	t+=1

-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacccccccacccccccacccccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0cccca0c0cccca0c0c
-- 003:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 004:ccccccccccccccccccccccccccccccccccccccccccccccccccdccdcccdc00cdc
-- 005:ccccccccccccccccccccccccccccccccccccccccccccccccccdccdcccdc00cdc
-- 006:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 020:ddc00cdcccdccdcccccccccccccccccccccccccccccccccccccccccccccccccc
-- 021:cdc00cddccdccdcccccccccccccccccccccccccccccccccccccccccccccccccc
-- 022:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- </TILES>

-- <SCREEN>
-- 000:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 001:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 002:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 003:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 004:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 005:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 006:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 007:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 008:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 009:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 010:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 011:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 012:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 013:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 014:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 015:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 016:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 017:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 018:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 019:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 020:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 021:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 022:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 023:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 024:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 025:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 026:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 027:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 028:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 029:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 030:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 031:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 032:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 033:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 034:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 035:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 036:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 037:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 038:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaa888888888888888888888888888888888888888888888888888888aaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 039:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaa888888888888888888888888888888888888888888888888888888aaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 040:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaa888888888888888888888888888888888888888888888888888888aaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 041:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaa888888888888888888888888888888888888888888888888888888aaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 042:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaa888888888888888888888888888888888888888888888888888888aaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 043:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaa888888888888888888888888888888888888888888888888888888aaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 044:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000ccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 045:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000ccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 046:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000ccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 047:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000ccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 048:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000ccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 049:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000ccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 050:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 051:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 052:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 053:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 054:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 055:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 056:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 057:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 058:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 059:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 060:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 061:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaacccccccccccccccccdddccccccdddccccccccccccdddccccccdddcaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 062:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaacccccccccccccccccdddccccccdddccccccccccccdddccccccdddcaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 063:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaacccccccccccccccccdddccccccdddccccccccccccdddccccccdddcaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 064:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccdddccc000000cccdddccccccdddccc000000cccdaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 065:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccdddccc000000cccdddccccccdddccc000000cccdaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 066:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccdddccc000000cccdddccccccdddccc000000cccdaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 067:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaacccccccccccddddddccc000000cccdddccccccdddccc000000cccdaaaaaa000000cccccc000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 068:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaacccccccccccddddddccc000000cccdddccccccdddccc000000cccdaaaaaa000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 069:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaacccccccccccddddddccc000000cccdddccccccdddccc000000cccdaaaaaa000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 070:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaacccccccccccccccccdddccccccdddccccccccccccdddccccccdddcaaaaaa000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 071:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaacccccccccccccccccdddccccccdddccccccccccccdddccccccdddcaaaaaa000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 072:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaacccccccccccccccccdddccccccdddccccccccccccdddccccccdddcaaaaaa000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 073:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 074:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 075:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 076:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 077:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 078:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 079:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 080:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 081:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 082:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 083:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 084:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 085:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaaccccccaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 086:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 087:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 088:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 089:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 090:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 091:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 092:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 093:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 094:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 095:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 096:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 097:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa000000ccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 098:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccc888888888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 099:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccc888888888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 100:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccc888888888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 101:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccc888888888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 102:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccc888888888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 103:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccc888888888888888888888888888888888888888888888888888888888888888888ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 104:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc000000000000000000cccccccccccccccccc000000000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 105:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc000000000000000000cccccccccccccccccc000000000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 106:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc000000000000000000cccccccccccccccccc000000000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 107:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc000000000000000000cccccccccccccccccc000000000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 108:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc000000000000000000cccccccccccccccccc000000000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 109:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccccc000000000000000000cccccccccccccccccc000000000000000000ccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 110:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccddddddccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 111:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccddddddccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 112:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccddddddccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 113:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccddddddccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 114:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccddddddccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 115:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccccccccddddddccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 116:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 117:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 118:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 119:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 120:dddddddddddddddddddddddddddddddddddffddfddddddddddddddddddddffdffddddddddddddddddddddffdddffddddddddddddddddddddddddffdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddffddddddddddddddddddddddddddddddddddddddd
-- 121:dddddddddddddddddddddddddddddddddddffddfddffffddfffdddddddffffddddffffdddfffdddffffdfffffdddddfffddffffdddffffdddddfffffddfffddddddffdfdddfffddffddfddfffddddddffdfddfddffddddddfffddfddffddfffdddffffdffddddddddddddddddddddddddddddddddddddddd
-- 122:dddddddddddddddddddddddddddddddddddffddfdfffdddffdffdddddfddffdffdffddfdffdffdfffddddffdddffdffddfdffddfdfffddddddddffdddffddfdddddfffffdffddfdffddfdffdffdddddfffffdfddffdddddffdffdfddffdffdffdfffdddffddddddddddddddddddddddddddddddddddddddd
-- 123:dddddddddddddddddddddddddddddddddddffddfdddfffdfffdddddddfddffdffdffddddfffdddfffddddffdddffdffddfdffddfdddfffddddddffdddffddfdddddfdfdfdffddfddfffddfffdddddddfdfdfddffffdddddfffddddffffdfffdddddfffdddddddddddddddddddddddddddddddddddddddddd
-- 124:ddddddddddddddddddddddddddddddddddddfffddffffdddfffdddddddffffdffdffdddddfffdddffffdddfffdffddfffddffddfdffffddddddddfffddfffddddddfdfdfddfffddddfddddfffddddddfdfdfddddffddddddfffdddddffddfffddffffddffddddddddddddddddddddddddddddddddddddddd
-- 125:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddfffdddddddddddddfffddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 126:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 127:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 128:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 129:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 130:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 131:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 132:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 133:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 134:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- 135:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
-- </SCREEN>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>
