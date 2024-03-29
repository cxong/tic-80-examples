// title:   Affine Sprites
// author:  congusbongus, MypkaMax
// desc:    draw sprites with affine transformations
// license: Unlicense
// version: 0.1
// script:  wren
// tags:    draw transform affine sprite skew shear rotate scale

class Game is TIC{
    construct new(){
        _t=0
    }
    t{_t}
    t=(value){_t=value}
    rot(x,y,ca,sa){
        return [x*ca-y*sa,x*sa+y*ca]
    }
    aspr(id,x,y,colorkey,sx,sy,flip,rotate,w,h,ox,oy,shx1,shy1,shx2,shy2){
        // Draw a sprite using two textured triangles.
        // Apply affine transformations: scale, shear, rotate, flip

        // scale / flip
        if((flip%2)==1){
            sx=-sx
        }
        if(flip>=2){
            sy=-sy
        }
        ox=ox*-sx
        oy=oy*-sy
        // shear / rotate
        shx1=shx1*-sx
        shy1=shy1*-sy
        shx2=shx2*-sx
        shy2=shy2*-sy
        var rr=rotate*Num.pi/180
        var sa=rr.sin
        var ca=rr.cos
        var r1=rot(ox+shx1,oy+shy1,ca,sa)
        var r2=rot(w*8*sx+ox+shx1,oy+shy2,ca,sa)
        var r3=rot(ox+shx2,h*8*sy+oy+shy1,ca,sa)
        var r4=rot(w*8*sx+ox+shx2,h*8*sy+oy+shy2,ca,sa)
        var x1 = x + r1[0]
        var y1 = y + r1[1]
        var x2 = x + r2[0]
        var y2 = y + r2[1]
        var x3 = x + r3[0]
        var y3 = y + r3[1]
        var x4 = x + r4[0]
        var y4 = y + r4[1]
        // UV coords
        var u1=(id%16)*8
        var v1=(id/16).floor*8
        var u2=u1+w*8
        var v2=v1+h*8

        TIC.ttri(x1,y1,x2,y2,x3,y3,u1,v1,u2,v1,u1,v2,0,colorkey)
        TIC.ttri(x3,y3,x4,y4,x2,y2,u1,v2,u2,v2,u2,v1,0,colorkey)
    }

	TIC(){
        TIC.cls(13)
        
        // Common params
        var id=1+((t%60)/30).floor*2
        var textcolor=12
        var colorkey=14
        var sx=2
        var sy=2
        var flip=((t%160)/40).floor
        var ox=8
        var oy=8
        var xstart=32
        var dx=56

        var w=2
        var h=2
        var shx1=0
        var shy1=0
        var shx2=0
        var shy2=0
        var x=xstart
        var y=24

        // Basic sprite (drop-in spr replacement)
        TIC.print("base",x-4,y+24,textcolor,false,1,true)
        aspr(id,x,y,colorkey,sx,sy,flip,0,w,h,ox,oy,shx1,shy1,shx2,shy2)
        x=x+dx

        // scale x
        var sx1=(t%60-30).abs/10+0.25
        TIC.print("scale x=%(sx1)",x-24,y+24,textcolor,false,1,true)
        aspr(id,x,y,colorkey,sx1,sy,flip,0,w,h,ox,oy,shx1,shy1,shx2,shy2)
        x=x+dx

        // scale y
        var sy1=(t%60-30).abs/10+0.25
        TIC.print("scale y=%(sy1)",x-24,y+24,textcolor,false,1,true)
        aspr(id,x,y,colorkey,sx,sy1,flip,0,w,h,ox,oy,shx1,shy1,shx2,shy2)
        x=x+dx

        // rotate
        var rotate=t%360
        TIC.print("rotate r=%(rotate)",x-20,y+24,textcolor,false,1,true)
        aspr(id,x,y,colorkey,sx,sy,flip,rotate,w,h,ox,oy,shx1,shy1,shx2,shy2)

        y=y+64
        x=xstart

        // shear x1
        shx1=((t%60-30).abs-15)/5
        TIC.print("shear x1=%(shx1)",x-24,y+24,textcolor,false,1,true)
        aspr(id,x,y,colorkey,sx,sy,flip,0,w,h,ox,oy,shx1,0,0,0)
        x=x+dx

        // shear y1
        shy1=((t%60-30).abs-15)/5
        TIC.print("shear y1=%(shy1)",x-24,y+24,textcolor,false,1,true)
        aspr(id,x,y,colorkey,sx,sy,flip,0,w,h,ox,oy,0,shy1,0,0)
        x=x+dx

        // shear x2
        shx2=((t%60-30).abs-15)/5
        TIC.print("shear x2=%(shx2)",x-24,y+24,textcolor,false,1,true)
        aspr(id,x,y,colorkey,sx,sy,flip,0,w,h,ox,oy,0,0,shx2,0)
        x=x+dx

        // shear y2
        shy2=((t%60-30).abs-15)/5
        TIC.print("shear y1=%(shy2)",x-24,y+24,textcolor,false,1,true)
        aspr(id,x,y,colorkey,sx,sy,flip,0,w,h,ox,oy,0,0,0,shy2)
        x=x+dx

        TIC.print("flip=%(flip)",100,124,textcolor,false,1,true)

        t=t+1
	}
}

// <TILES>
// 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
// 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
// 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
// 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
// 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
// 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
// 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
// 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
// </TILES>

// <SCREEN>
// 000:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 001:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 002:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 003:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 004:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 005:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 006:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccdccdddddddddddddddddddddddddddddddddddddddd
// 007:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccddddddddddddddddddddddddddddddddddddddd
// 008:ddddddddddddddddddccccccccccccccccccccccccddddddddddddddddddddddddddddddddddccccccccccccccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccccccccdddccddddddddddddddddddddddddddddddddd
// 009:ddddddddddddddddddccccccccccccccccccccccccddddddddddddddddddddddddddddddddddccccccccccccccccccccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccc88c00ccccccccdddddddddddddddddddddddddddddddd
// 010:ddddddddddddddddcccc88888888888888888888ccccdddddddddddddddddddddddddddddddccc88888888888888888cccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccc888a000cccc0cccddddddddddddddddddddddddddddddd
// 011:ddddddddddddddddcccc88888888888888888888ccccdddddddddddddddddddddddddddddddccc88888888888888888cccddddddddddddddddddddddddddddddddccccccccccccccccccccccccddddddddddddddddddddddddddddddddddddccc888aaa000ccc00cccdddddddddddddddddddddddddddddd
// 012:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccdddddddddddddddddddddddddddddddcaaaaaaaaaaaaaaaaaaa0ccddddddddddddddddddddddddddddddcccc88888888888888888888ccccdddddddddddddddddddddddddddddddddccc888aaaaa000ccc00cccddddddddddddddddddddddddddddd
// 013:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccdddddddddddddddddddddddddddddddcaaaaaaaaaaaaaaaaaaa0ccddddddddddddddddddddddddddddddcccc88888888888888888888ccccddddddddddddddddddddddddddddddddccc888aa88aaa000ccc00cccdddddddddddddddddddddddddddd
// 014:ddddddddddddddddccaa888888888888888888aa00ccdddddddddddddddddddddddddddddddcaa888888888888888aa0ccddddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccdddddddddddddddddddddddddddddddccc888aa888caaa000ccc00cccddddddddddddddddddddddddddd
// 015:ddddddddddddddddccaa888888888888888888aa00ccdddddddddddddddddddddddddddddddcaa888888888888888aa0ccddddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddddccc888aa888cccaaa000cc0cccdddddddddddddddddddddddddddd
// 016:ddddddddddddddddccaaccccccccccccccccccaa00ccccccdddddddddddddddddddddddddddcaacccccccccccccccaa0cccccdddddddddddddddddddddddddddccaa888888888888888888aa00ccdddddddddddddddddddddddddddddccc88aaa888cccccaaa000c0cccdddddddddddddddddddddddddddd
// 017:ddddddddddddddddccaaccccccccccccccccccaa00ccccccdddddddddddddddddddddddddddcaacccccccccccccccaa0cccccdddddddddddddddddddddddddddccaaccccccccccccccccccaa00ccccccddddddddddddddddddddddddccc88aaa888cccccccaaa00000ccdddddddddddddddddddddddddddd
// 018:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddddddcaaccc00ccccc00cccaa0cc00cdddddddddddddddddddddddddddccaaccccccccccccccccccaa00ccccccdddddddddddddddddddddddccc88aaa888cccccccccaaa000ccddddddddddddddddddddddddddddd
// 019:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddddddcaaccc00ccccc00cccaa0cc00cdddddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddccc88aaa888ccc00ccccccaaa000ccdddddddddddddddddddddddddddd
// 020:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddddddcaaccc00ccccc00cccaa0cc00cdddddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddcc888aaa888ccccc00ccccccaaa000ccddddddddddddddddddddddddddd
// 021:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddddddcaaccc00ccccc00cccaa0cc00cdddddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddcc888aaa888ccccccc00cccccaaaa00cccdddddddddddddddddddddddddd
// 022:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddddddcaaccc00ccccc00cccaa0cc00cdddddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddccc88aaa888ccccccccc00cccaaaaaa00cccddddddddddddddddddddddddd
// 023:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddddddcaaccc00ccccc00cccaa0cc00cdddddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddcccaaa888ccccccccccc0ccaaaaaaaa00cccdddddddddddddddddddddddd
// 024:ddddddddddddddddccaaccccccccccccccccccaa0000ccccdddddddddddddddddddddddddddcaacccccccccccccccaa000cccdddddddddddddddddddddddddddccaaccccccccccccccccccaa0000ccccdddddddddddddddddddcccaaa888ccc0ccccccccccaaaaaaaaaa00cccddddddddddddddddddddddd
// 025:ddddddddddddddddccaaccccccccccccccccccaa0000ccccdddddddddddddddddddddddddddcaacccccccccccccccaa000cccdddddddddddddddddddddddddddccaaccccccccccccccccccaa0000ccccdddddddddddddddddddcccaaa88ccc000ccccccccaaaaaaaaaaaacccdddddddddddddddddddddddd
// 026:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccccdddddddddddddddddddddddddddddcaaaaaaaaaaaaaaaaaaa0ccccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccccddddddddddddddddddddddcccaaaccccc000ccccccaaaccaaaaaaa88ccdddddddddddddddddddddddd
// 027:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccccdddddddddddddddddddddddddddddcaaaaaaaaaaaaaaaaaaa0ccccddddddddddddddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccdddddddddddddddddddddddddcccaaaccccc000ccccaaaaccaaaaaa888cccddddddddddddddddddddddd
// 028:ddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccdddddddddddddddddddddddddddddddcaaaaaccaaaaaccaaaaa0ccddddddddddddddddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccddddddddddddddddddddddddddcccaaaccccc00cccaaaaaaaaaaaa888ccddddddddddddddddddddddddd
// 029:ddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccdddddddddddddddddddddddddddddddcaaaaaccaaaaaccaaaaa0ccddddddddddddddddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccdddddddddddddddddddddddddddcccaaaccccccccaaaaaaccaaaa88800ccdddddddddddddddddddddddd
// 030:ddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccdddddddddddddddddddddddddddddddcaaaaaaacccccaaaaaaa0ccddddddddddddddddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccddddddddddddddddddddddddddddcccaaaccccccaaaaaacccaaa88800cccdddddddddddddddddddddddd
// 031:ddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccdddddddddddddddddddddddddddddddcaaaaaaacccccaaaaaaa0ccddddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccdddddddddddddddddddddddddddddcccaaaccccaaacaacccaaa88800cccddddddddddddddddddddddddd
// 032:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccdddddddddddddddddddddddddddddddcaaaaaaaaaaaaaaaaaaa0ccddddddddddddddddddddddddddddddcc8888888888888888888888ccccddddddddddddddddddddddddddddddcccaaaccaaaccccccaaa88000cccdddddddddddddddddddddddddd
// 033:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccdddddddddddddddddddddddddddddddcaaaaaaaaaaaaaaaaaaa0ccddddddddddddddddddddddddddddddcc8888888888888888888888ccccdddddddddddddddddddddddddddddddcccaacaaaaacaacaaa88cc0cccddddddddddddddddddddddddddd
// 034:ddddddddddddddddcc8888888888888888888888ccccdddddddddddddddddddddddddddddddc8888888888888888888cccddddddddddddddddddddddddddddddcccc000000cccccc000000ccccddddddddddddddddddddddddddddddddddcccaaaaaaaaaaaaa88ccccccdddddddddddddddddddddddddddd
// 035:ddddddddddddddddcc8888888888888888888888ccccdddddddddddddddddddddddddddddddc8888888888888888888cccddddddddddddddddddddddddddddddcccc000000cccccc000000ccccdddddddddddddddddddddddddddddddddddcccaaaaaaaaaa888ccccccddddddddddddddddddddddddddddd
// 036:ddddddddddddddddcccc000000cccccc000000ccccdddddddddddddddddddddddddddddddddccc00000ccccc00000cccddddddddddddddddddddddddddddddddddccccccccccddccccccccccddddddddddddddddddddddddddddddddddddddcccaaaaaaaa888cccddcdddddddddddddddddddddddddddddd
// 037:ddddddddddddddddcccc000000cccccc000000ccccdddddddddddddddddddddddddddddddddccc00000ccccc00000cccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccaaaaaa88800ccddddddddddddddddddddddddddddddddd
// 038:ddddddddddddddddddccccccccccddccccccccccddddddddddddddddddddddddddddddddddddcccccccccdcccccccccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccaaaa888000cccdddddddddddddddddddddddddddddddd
// 039:ddddddddddddddddddccccccccccddccccccccccddddddddddddddddddddddddddddddddddddcccccccccdcccccccccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccaa888000cccddddddddddddddddddddddddddddddddd
// 040:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcca888000cccdddddddddddddddddddddddddddddddddd
// 041:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcc88c00cccddddddddddddddddddddddddddddddddddd
// 042:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccdddddddddddddddddddddddddddddddddddd
// 043:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccddddddddddddddddddddddddddddddddddddd
// 044:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcdccdddddddddddddddddddddddddddddddddddddd
// 045:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 046:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 047:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 048:ddddddddddddddddddddddddddddcdddddddddddddddddddddddddddddddddddddddddddddddccdddddddddddddddddcdddddccdcccdddddddddddddddddddddddddccdddddddddddddddddcdddddccdcccddddddddddddddddddddddddddcdddddddcddddddddddddddddccdddcdddccddddddddddddddd
// 049:ddddddddddddddddddddddddddddccddccdddccddccddddddddddddddddddddddccddccdccdddcdddccdddcdcdcccdccddddcdddcddddddddddddddddccddccdccdddcdddccdddcdcdcccdccddddcdddcdddddddddddddddddddcdcddcddcccdccddcccddccdddcdcdcccdddcdccddcddddddddddddddddd
// 050:ddddddddddddddddddddddddddddcdcddccdccddcdcdddddddddddddddddddddccddcddddccddcddcdcddddcdddddddcddddcccdccddddddddddddddccddcddddccddcddcdcdddcdcddddddcddddcccdccddddddddddddddddddccddcdcddcdddccddcddcdcdddccdddddddcdddcddcccddddddddddddddd
// 051:ddddddddddddddddddddddddddddcdcdcdcdddcdccddddddddddddddddddddddddcdcdddcdcddcddccddddcdcdcccddcddddcdcdddcdddddddddddddddcdcdddcdcddcddccdddddccdcccddcddddcdcdddcdddddddddddddddddcdddcdcddcddcdcddcddccddddcdddcccdddcddcddcdcddddddddddddddd
// 052:ddddddddddddddddddddddddddddccddcccdccdddccdddddddddddddddddddddccdddccdcccdcccddccdddcdcdddddcccdcdcccdccddddddddddddddccdddccdcccdcccddccdddddcdddddcccdcdcccdccddddddddddddddddddcddddcddddcdcccdddcddccdddcdddddddccddcccdcccddddddddddddddd
// 053:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 054:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 055:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 056:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 057:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 058:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 059:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 060:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 061:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 062:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 063:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 064:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 065:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 066:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 067:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 068:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 069:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 070:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 071:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 072:ddddddddddddddddddccccccccccccccccccccccccddddddddddddddddddddddddddddddddccccccccccccccccccccccccddddddddddddddddddddddddddddddddccccccccccccccccccccccccddddddddddddddddddddddddddddddddccccccccccccccccccccccccdddddddddddddddddddddddddddddd
// 073:ddddddddddddddddddccccccccccccccccccccccccddddddddddddddddddddddddddddddddccccccccccccccccccccccccddddddddddddddddddddddddddddddddccccccccccccccccccccccccddddddddddddddddddddddddddddddddccccccccccccccccccccccccdddddddddddddddddddddddddddddd
// 074:ddddddddddddddddcccc88888888888888888888ccccddddddddddddddddddddddddddddcccc88888888888888888888ccccddddddddddddddddddddddddddddcccc88888888888888888888ccccddddddddddddddddddddddddddddcccc88888888888888888888ccccdddddddddddddddddddddddddddd
// 075:ddddddddddddddddcccc88888888888888888888ccccddddddddddddddddddddddddddddcccc88888888888888888888ccccddddddddddddddddddddddddddddcccc88888888888888888888ccccddddddddddddddddddddddddddddcccc88888888888888888888ccccdddddddddddddddddddddddddddd
// 076:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccdddddddddddddddddddddddddddd
// 077:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccdddddddddddddddddddddddddddd
// 078:ddddddddddddddddccaa888888888888888888aa00ccddddddddddddddddddddddddddddccaa888888888888888888aa00ccddddddddddddddddddddddddddddccaa888888888888888888aa00ccddddddddddddddddddddddddddddccaa888888888888888888aa00ccdddddddddddddddddddddddddddd
// 079:ddddddddddddddddccaa888888888888888888aa00ccddddddddddddddddddddddddddddccaa888888888888888888aa00ccddddddddddddddddddddddddddddccaa888888888888888888aa00ccddddddddddddddddddddddddddddccaa888888888888888888aa00ccdddddddddddddddddddddddddddd
// 080:ddddddddddddddddccaaccccccccccccccccccaa00ccccccddddddddddddddddddddddddccaaccccccccccccccccccaa00ccccccddddddddddddddddddddddddccaaccccccccccccccccccaa00ccccccddddddddddddddddddddddddccaaccccccccccccccccccaa00ccccccdddddddddddddddddddddddd
// 081:ddddddddddddddddccaaccccccccccccccccccaa00ccccccddddddddddddddddddddddddccaaccccccccccccccccccaa00ccccccddddddddddddddddddddddddccaaccccccccccccccccccaa00ccccccddddddddddddddddddddddddccaaccccccccccccccccccaa00ccccccdddddddddddddddddddddddd
// 082:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddd
// 083:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddd
// 084:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddd
// 085:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddd
// 086:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddd
// 087:ddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccddddddddddddddddddddddddccaacccc00cccccc00ccccaa00cc00ccdddddddddddddddddddddddd
// 088:ddddddddddddddddccaaccccccccccccccccccaa0000ccccddddddddddddddddddddddddccaaccccccccccccccccccaa0000ccccddddddddddddddddddddddddccaaccccccccccccccccccaa0000ccccddddddddddddddddddddddddccaaccccccccccccccccccaa0000ccccdddddddddddddddddddddddd
// 089:ddddddddddddddddccaaccccccccccccccccccaa0000ccccddddddddddddddddddddddddccaaccccccccccccccccccaa0000ccccddddddddddddddddddddddddccaaccccccccccccccccccaa0000ccccddddddddddddddddddddddddccaaccccccccccccccccccaa0000ccccdddddddddddddddddddddddd
// 090:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccccddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccccddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccccddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccccdddddddddddddddddddddddddd
// 091:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccccddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccccddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccccddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccccdddddddddddddddddddddddddd
// 092:ddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccdddddddddddddddddddddddddddd
// 093:ddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaccaaaaaaccaaaaaa00ccdddddddddddddddddddddddddddd
// 094:ddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccdddddddddddddddddddddddddddd
// 095:ddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaccccccaaaaaaaa00ccdddddddddddddddddddddddddddd
// 096:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccdddddddddddddddddddddddddddd
// 097:ddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccddddddddddddddddddddddddddddccaaaaaaaaaaaaaaaaaaaaaa00ccdddddddddddddddddddddddddddd
// 098:ddddddddddddddddcc8888888888888888888888ccccddddddddddddddddddddddddddddcc8888888888888888888888ccccddddddddddddddddddddddddddddcc8888888888888888888888ccccddddddddddddddddddddddddddddcc8888888888888888888888ccccdddddddddddddddddddddddddddd
// 099:ddddddddddddddddcc8888888888888888888888ccccddddddddddddddddddddddddddddcc8888888888888888888888ccccddddddddddddddddddddddddddddcc8888888888888888888888ccccddddddddddddddddddddddddddddcc8888888888888888888888ccccdddddddddddddddddddddddddddd
// 100:ddddddddddddddddcccc000000cccccc000000ccccddddddddddddddddddddddddddddddcccc000000cccccc000000ccccddddddddddddddddddddddddddddddcccc000000cccccc000000ccccddddddddddddddddddddddddddddddcccc000000cccccc000000ccccdddddddddddddddddddddddddddddd
// 101:ddddddddddddddddcccc000000cccccc000000ccccddddddddddddddddddddddddddddddcccc000000cccccc000000ccccddddddddddddddddddddddddddddddcccc000000cccccc000000ccccddddddddddddddddddddddddddddddcccc000000cccccc000000ccccdddddddddddddddddddddddddddddd
// 102:ddddddddddddddddddccccccccccddccccccccccddddddddddddddddddddddddddddddddddccccccccccddccccccccccddddddddddddddddddddddddddddddddddccccccccccddccccccccccddddddddddddddddddddddddddddddddddccccccccccddccccccccccdddddddddddddddddddddddddddddddd
// 103:ddddddddddddddddddccccccccccddccccccccccddddddddddddddddddddddddddddddddddccccccccccddccccccccccddddddddddddddddddddddddddddddddddccccccccccddccccccccccddddddddddddddddddddddddddddddddddccccccccccddccccccccccdddddddddddddddddddddddddddddddd
// 104:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 105:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 106:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 107:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 108:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 109:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 110:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 111:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 112:ddddddddddddcddddddddddddddddddddddcdddddddddddccdddccddddddddddddddcddddddddddddddddddddddcdddddddddddccdddccddddddddddddddcdddddddddddddddddddddccdddddddddddccdddccddddddddddddddcddddddddddddddddddddddcdddddddddddccdddccdddddddddddddddddd
// 113:dddddddddccdccdddccdccddcdcdddcdcdccddcccdddddcdcdddddcddddddddddccdccdddccdccddcdcdddcdcdccddcccdddddcdcdddddcddddddddddccdccdddccdccddcdcdddcdcdddcdcccdddddcdcdddddcddddddddddccdccdddccdccddcdcdddcdcdccddcccdddddcdcdddddcddddddddddddddddd
// 114:ddddddddccddcdcdcdcddccdccdddddcdddcddddddcccdcdcddddcddddddddddccddcdcdcdcddccdccddddcdcddcddddddcccdcdcddddcddddddddddccddcdcdcdcddccdccdddddcdddcddddddcccdcdcddddcddddddddddccddcdcdcdcddccdccddddcdcddcddddddcccdcdcddddcdddddddddddddddddd
// 115:ddddddddddcdcdcdccddcdcdcdddddcdcddcddcccdddddcdcdddcdddddddddddddcdcdcdccddcdcdcddddddccddcddcccdddddcdcdddcdddddddddddddcdcdcdccddcdcdcdddddcdcdcdddcccdddddcdcdddcdddddddddddddcdcdcdccddcdcdcddddddccddcddcccdddddcdcdddcddddddddddddddddddd
// 116:ddddddddccddcdcddccdcccdcdddddcdcdcccdddddddddccddcdcccdddddddddccddcdcddccdcccdcdddddddcdcccdddddddddccddcdcccdddddddddccddcdcddccdcccdcdddddcdcdcccdddddddddccddcdcccdddddddddccddcdcddccdcccdcdddddddcdcccdddddddddccddcdcccddddddddddddddddd
// 117:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcdddddddddddddddddddddddddddddddddddddddd
// 118:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 119:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 120:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 121:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 122:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 123:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 124:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcdccddcddddddddddccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 125:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcdddcddddccddcccdcdcddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 126:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccddcddcdcdcdddddcdcddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 127:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcdddcddcdcdcdcccdcdcddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 128:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcddcccdcdccddddddccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 129:ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 130:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 131:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 132:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 133:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 134:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// 135:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
// </SCREEN>

// <PALETTE>
// 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
// </PALETTE>

