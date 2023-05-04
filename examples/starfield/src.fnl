;; title:   Starfield
;; author:  congusbongus, emma bukaceck and phil hagelberg
;; desc:    Draw a starfield with parallax stars
;; license: GPL3+
;; script:  fennel
;; strict:  true
;; tags:    draw parallax effect

(var t 0)
(var x 96)
(var y 24)
(var STARNEAR 13)
(var STARFAR 14)
(var WIDTH 240)
(var HEIGHT 136)

(local stars [])
(for [i 1 32] (table.insert stars [(math.random 480) (math.random 272)]))

(fn draw-stars [scroll-x scroll-y]
  (each [_ s (ipairs stars)]
    (let [[sx sy] s]
      (pix (% (* (- sx scroll-x) 0.5) WIDTH)
           (% (* (- sy scroll-y) 0.5) HEIGHT) STARFAR)
      (pix (% (- sx scroll-x) WIDTH)
           (% (- sy scroll-y) HEIGHT) STARNEAR))))

(fn _G.TIC []
  (when (btn 0) (set y (- y 1)))
  (when (btn 1) (set y (+ y 1)))
  (when (btn 2) (set x (- x 1)))
  (when (btn 3) (set x (+ x 1)))
  (cls 0)
  (draw-stars x y)
  (spr (+ 1 (* (// (% t 60) 30) 2))
       x y 0 3 0 0 2 2)
  (set t (+ t 1)))

;; <TILES>
;; 001:000000000008888800aaaaaa00a8888800accccc00accecc00accecc00accecc
;; 002:0000000088888000aaaaa8008888a800cccca800cecca800cecca800cecca800
;; 003:0008888800aaaaaa00a8888800accccc00accecc00accecc00accecc00accccc
;; 004:88888000aaaaa8008888a800cccca800cecca800cecca800cecca800cccca800
;; 017:00accccc00aaaaaa00aaacaa0ddeaaccd21deeeeeedddddd0eeeeedd0000ffff
;; 018:cccca800aaaaa800acaaa800caaaedd0eeeed76dddddddeeddeeeee0ffff0000
;; 019:00aaaaaa00aaacaa0ddeaaccd21deeeeeedddddd0eeeeedd0000ffff00000000
;; 020:aaaaa800acaaa800caaaedd0eeeed76dddddddeeddeeeee0ffff000000000000
;; </TILES>

;; <TRACKS>
;; 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
;; </TRACKS>

;; <PALETTE>
;; 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
;; </PALETTE>

