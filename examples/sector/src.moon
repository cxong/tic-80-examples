-- title:   Draw sector
-- author:  congusbongus
-- desc:    Draw a sector of a circle using a fan of triangles
-- site:    https://cxong.github.io/tic-80-examples/
-- license: CC0
-- version: 0.1
-- script:  moon

export TIC=->
    cls(0)

    x=100
    y=80
    dx=25
    dy=15
    iterations=16

    d=math.pi/iterations
    for i=0,iterations-1
        tri(x,y,x+math.cos(d*i)*dx,y+math.sin(d*i)*dy,x+math.cos(d*(i+1))*dx,y+math.sin(d*(i+1))*dy,2)

-- <TILES>
-- 000:9acaaaa99aaaaaaa09aaaaac009aaaaa009aaaaa09aaaaaa9accaaaa9acaaaa9
-- 001:9acaaaa9aaaaaaa9caaaaa90aaaaa900aaaaa900aaaaaa90aaaaaca99aaaaaa9
-- 002:0099990009aaaa909accaaa99acaaaa99aaaaaa99aaaaaa99aaaaaa99acaaaa9
-- 003:0099999909aaaaaa9accaaac9acaaaaa9aaaaaaa9aaaaaaa09aaaaaa00999999
-- 004:99999999aaaaaaaaccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999
-- 005:99999900aaaaaa90caaaaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaa9099999900
-- 006:9acaaaa99acaaaaa9acaaaac9acaaaaa9acaaaaa9acaaaaa9acaaaaa9acaaaa9
-- 007:9acaaaa9aacaaaa9ccaaaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaaa99acaaaa9
-- 016:0000099900099aaa009aaaac09accaaa09acaaaa9aaaaaaa9aaaaaaa9acaaaa9
-- 017:99900000aaa99000caaaa900aaaaaa90aaaaaa90aaaaaaa9aaaaaaa99aaaaaa9
-- 018:9acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa99acaaaa9
-- 019:99000099aa9009aacaa99accaaaaaacaaaaaaaaaaaaaaaaaaaaaaaaa9acaaaa9
-- 020:0099990009aaaa909accaaa99acaaaa99aaaaaa99aaaaaa909aaaa9000999900
-- 021:99999999aaaaaaaaccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9acaaaa9
-- 022:999999999aaaaaaa9accaaac9acaaaaa9aaaaaaa9aaaaaaa9aaaaaaa9acaaaa9
-- 023:99999999aaaaaaa9ccccaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaaa99acaaaa9
-- 032:9acaaaa99aaaaaaa9aaaaaac09aaaaaa09aaaaaa009aaaaa00099aaa00000999
-- 033:9acaaaa9aaaaaaa9caaaaaa9aaaaaa90aaaaaa90aaaaa900aaa9900099900000
-- 034:9acaaaa99aaaaaa99aaaaaa99aaaaaa99aaaaaa99aaaaaa909aaaa9000999900
-- 035:9acaaaa9aacaaaaaccaaaaacaaaaaaaaaaaaaaaaaaa99aaaaa9009aa99000099
-- 037:9acaaaa9aacaaaaaccaaaaacaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999
-- 038:9acaaaa99acaaaaa9acaaaac9acaaaaa9aaaaaaa9aaaaaaa9aaaaaaa99999999
-- 039:9acaaaa9aaaaaaa9cacaaaa9aaaaaaa9aaaaaaa9aaaaaaa9aaaaaaa999999999
-- </TILES>

-- <WAVES>
-- 000:01358acefeca853101368acefeca8531
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:00000000000000001000300040004000500050007000700090009000a000a000c000d000e000e000f000e000e000e000e000e000e000e000e000e000377000000000
-- 001:0100417061c09100a100c100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100450000000300
-- </SFX>

-- <PATTERNS>
-- 000:400008100000000000000000b00006100000000000000000f00006100000000000000000b00006100000000000000000b00008100000000000000000000000400008000000000000022600000000000000000000000000000000000000000000100000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 001:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000800000000000042260a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 002:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800008022600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 003:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b22608000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </PATTERNS>

-- <TRACKS>
-- 000:180301000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ec02df
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>
