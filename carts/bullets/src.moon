-- title:   Bullets
-- author:  congusbongus
-- desc:    Shoot-em-up, bullets and overlap
-- license: CC0
-- script:  moon
-- tags:    overlap physics bullet shooting

WIDTH=240
HEIGHT=136
SPRITESIZE=8
ENEMY=0
BULLET=1
PLAYER=2
BULLETSPEED=4
PLAYERSPEED=2
SHOOTCOOLDOWN=10
SFXSHOOT=0
SFXDIE=1

class Sprite
    new:(s,x,y,w,h,dx,dy)=>
        @s=s
        @x=x
        @y=y
        @w=w
        @h=h
        @dx=dx
        @dy=dy
        @health=1

    update:=>
        @x+=@dx
        @y+=@dy

    isoob:=>
        -- Whether this sprite is off screen
        return @x+@w<0 or @x>WIDTH or @y+@h<0 or @y>HEIGHT

    overlaps:(other)=>
        -- Check if two AABBs overlap
        return @x+@w>other.x and other.x+other.w>@x and @y+@h>other.y and other.y+other.h>@y

    draw:=>
        spr @s,@x,@y,0

class Player
    new:(x,y,w,h)=>
        @x=x
        @y=y
        @w=w
        @h=h
        @shootcounter=0

    move:(dx)=>
        -- Keep on screen
        @x+=dx
        if @x<0
            @x=0
        if @x>WIDTH-@w
            @x=WIDTH-@w

    update:=>
        @shootcounter-=1

    shoot:=>
        -- Returns a bullet
        if @shootcounter<=0
            @shootcounter=SHOOTCOOLDOWN
            bulletw=SPRITESIZE
            bulleth=SPRITESIZE
            sfx SFXSHOOT
            return Sprite(BULLET,@x+(@w-bulletw)/2,@y-bulleth,bulletw,bulleth,0,-BULLETSPEED)
        return nil

    draw:=>
        spr PLAYER,@x,@y,0,1,0,0,2,2

enemies={}
bullets={}
player=Player(120,110,16,16)

export TIC=->
    if #enemies==0
        enemies=[Sprite(ENEMY,x*10,y*10,SPRITESIZE,SPRITESIZE,0,0) for x=1,22 for y=1,5]
    for enemy in *enemies
        enemy\update!
    for bullet in *bullets
        bullet\update!
    -- Check overlaps between bullets and enemies
    for bullet in *bullets
        for enemy in *enemies
            if bullet\overlaps(enemy)
                -- Kill both the bullet and the enemy
                if enemy.health>0
                    sfx SFXDIE
                bullet.health-=1
                enemy.health-=1
                break
    -- Remove out of bounds and dead enemies/bullets
    enemies=[enemy for enemy in *enemies when enemy.health>0]
    bullets=[bullet for bullet in *bullets when bullet.health>0 and not bullet\isoob!]
    -- Player moving/shooting
	if btn 2
        player\move(-PLAYERSPEED)
	if btn 3
        player\move(PLAYERSPEED)
    player\update!
    if btn 4
        bullet=player\shoot!
        if bullet!=nil
            table.insert(bullets,bullet)

	cls 15
	player\draw!
    for enemy in *enemies
        enemy\draw!
    for bullet in *bullets
        bullet\draw!

-- <TILES>
-- 000:0500005000555500056556505576675555555555056666500050050005000050
-- 001:0003300000344300034cc430034cc430034cc430034cc4300234432001233210
-- 002:0000000c0000000d0000000d0000000d000000cd000000c800cd00c800cd0c89
-- 003:d0000000d0000000e0000000e0000000ee0000008e0000008e00de0098e0de00
-- 018:00dd089ac0dde8a9c0dde8a9decde8a9ddcded88ddcdedefededefef0fbbbeef
-- 019:9980dd00988edd0e988edd0e888cdeef88dcdedffedcdedffefedeeefeebbbf0
-- </TILES>

-- <WAVES>
-- 000:fffffffffffffffff000000000000000
-- </WAVES>

-- <SFX>
-- 000:5007a005b002c00ed00ae008f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000b00000000000
-- 001:010001001100410061008100a10081006100510061008100b100b100a100910081008100a100e100e100d100d100d100d100e100f100f100f100f100200000000000
-- </SFX>

-- <SCREEN>
-- 000:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 001:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 002:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 003:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 004:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 005:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 006:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 007:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 008:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 009:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 010:fffffffffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5fffffffffffff
-- 011:ffffffffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffffffffffff
-- 012:fffffffffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565fffffffffffff
-- 013:ffffffffff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ffffffffffff
-- 014:ffffffffff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ffffffffffff
-- 015:fffffffffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665fffffffffffff
-- 016:ffffffffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffffffffffff
-- 017:fffffffffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5fffffffffffff
-- 018:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 019:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 020:fffffffffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5fffffffffffff
-- 021:ffffffffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffffffffffff
-- 022:fffffffffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565fffffffffffff
-- 023:ffffffffff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ffffffffffff
-- 024:ffffffffff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ffffffffffff
-- 025:fffffffffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665fffffffffffff
-- 026:ffffffffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffffffffffff
-- 027:fffffffffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5fffffffffffff
-- 028:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 029:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 030:fffffffffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5fffffffffffff
-- 031:ffffffffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffffffffffff
-- 032:fffffffffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565fffffffffffff
-- 033:ffffffffff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ffffffffffff
-- 034:ffffffffff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ffffffffffff
-- 035:fffffffffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665fffffffffffff
-- 036:ffffffffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffffffffffff
-- 037:fffffffffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5fffffffffffff
-- 038:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 039:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 040:fffffffffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5fffffffffffff
-- 041:ffffffffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffffffffffff
-- 042:fffffffffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565fffffffffffff
-- 043:ffffffffff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ffffffffffff
-- 044:ffffffffff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ffffffffffff
-- 045:fffffffffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665fffffffffffff
-- 046:ffffffffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffffffffffff
-- 047:fffffffffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5fffffffffffff
-- 048:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 049:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 050:fffffffffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffffffffffffffffffffffff5ffff5ffffffffffffff5ffff5ffffffffffffff5ffff5fffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 051:ffffffffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffff5555ffffffffffffffffffffffffff5555ffffffffffffffff5555ffffffffffffffff5555ffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 052:fffffffffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffff565565ffffffffffffffffffffffff565565ffffffffffffff565565ffffffffffffff565565fffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 053:ffffffffff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ff55766755ffffffffffffffffffffff55766755ffffffffffff55766755ffffffffffff55766755ffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 054:ffffffffff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ff55555555ffffffffffffffffffffff55555555ffffffffffff55555555ffffffffffff55555555ffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 055:fffffffffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffff566665ffffffffffffffffffffffff566665ffffffffffffff566665ffffffffffffff566665fffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 056:ffffffffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffff5ff5ffffffffffffffffffffffffff5ff5ffffffffffffffff5ff5ffffffffffffffff5ff5ffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 057:fffffffffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffff5ffffffffffffffffffffffff5ffff5ffffffffffffff5ffff5ffffffffffffff5ffff5fffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 058:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 059:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 060:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 061:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 062:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 063:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 064:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 065:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 066:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 067:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 068:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 069:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 070:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 071:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 072:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 073:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 074:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 075:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 076:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 077:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 078:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff33fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 079:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff3443ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 080:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff34cc43fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 081:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff34cc43fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 082:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff34cc43fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 083:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff34cc43fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 084:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff234432fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 085:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff123321fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 086:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 087:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 088:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 089:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 090:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 091:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 092:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 093:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 094:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 095:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 096:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 097:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 098:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 099:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 100:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 101:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 102:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 103:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 104:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 105:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 106:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 107:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 108:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 109:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 110:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffcdfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 111:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffddfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 112:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdefffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 113:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdefffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 114:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffcdeeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 115:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc88effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 116:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffcdffc88effdeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 117:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffcdfc8998efdeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 118:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffddf89a998fddffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 119:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffcfdde8a9988eddfeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 120:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffcfdde8a9988eddfeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 121:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdecde8a9888cdeefffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 122:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffddcded8888dcdedfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 123:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffddcdedeffedcdedfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 124:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffededefeffefedeeeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 125:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffbbbeeffeebbbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 126:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 127:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 128:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 129:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 130:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 131:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 132:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 133:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 134:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 135:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- </SCREEN>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

