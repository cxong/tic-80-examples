-- title:   Stars
-- author:  congusbongus
-- desc:    Flying through stars
-- license: MIT License
-- script:  moon
-- tags:    draw effect

WIDTH=240
HEIGHT=136
-- Star colors, brightest to darkest
COLORS={12,13,14,15,0}
SPEEDMIN=0.001
SPEEDMAX=0.05

-- Util functions
distance=(x1,y1,x2,y2)->
	dx=x1-x2
	dy=y1-y2
	return math.sqrt(dx*dx+dy*dy)

norm=(x,y)->
	d=distance(x,y,0,0)
	if d==0
		return 1,0
	return x/d,y/d

clamp=(v,min,max)->
    return math.min(math.max(v,min),max)

class Star
    new:()=>
        @x=WIDTH/2
        @y=HEIGHT/2
        dx,dy=math.random!-0.5,math.random!-0.5
        @dx,@dy=norm(dx,dy)
        -- Square rand to skew more slow stars
        s=math.random!*math.random!*(SPEEDMAX-SPEEDMIN)+SPEEDMIN
        @ddx=@dx*s
        @ddy=@dy*s
        @dx*=s
        @dy*=s
        @mag=math.random!+0.5

    update:=>
        @x+=@dx
        @y+=@dy
        @dx+=@ddx
        @dy+=@ddy

    alive:=>
        return @x>=0 and @x<=WIDTH and @y>=0 and @y<=HEIGHT

    draw:=>
        dfactor=(math.abs(@x-WIDTH/2)+math.abs(@y-HEIGHT/2))/(WIDTH/2)
        sfactor=(math.abs(@dx)+math.abs(@dy)-SPEEDMIN)/(SPEEDMAX-SPEEDMIN)/25
        mfactor=math.sqrt(dfactor*sfactor)
        c=COLORS[#COLORS]-math.min(math.floor(mfactor*@mag*#COLORS),#COLORS-1)
        pix(@x,@y,c)

class StarGenerator
    new:(n,interval)=>
        @n=n
        @interval=interval
        @counter=0
        @stars={}

    update:=>
        -- Add new stars
        if #@stars<@n and @counter==0
            table.insert(@stars,Star())
            @counter=@interval
        if @counter>0
            @counter-=1
        -- Move stars
        for s in *@stars
            s\update!
        -- Remove stars that are out of bounds
        @stars=[s for s in *@stars when s\alive!]

    draw:=>
        for s in *@stars
            s\draw!

stargen=StarGenerator(100,1)

export TIC=->
    stargen\update!
    cls(0)
    stargen\draw!


-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>
