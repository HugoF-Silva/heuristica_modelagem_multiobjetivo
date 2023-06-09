extensions [rnd]

globals [ temperature global-energy]
patches-own [
  value          ; Value in the cell
  block          ; Block 3x3 the cell belongs to
  constraints    ; Number of constraints the cell has in the current state:
                 ;    Number Cells in the same Row with the same value
                 ;    + Number Cells in the same Column with the same value
                 ;    + Number Cells in the same Block with the same value
                 ;   Finally, we take the exponential of this sum.
]

; Setup procedure to prepare the data for the algorithm.
; The world is a Sudoku 9x9 patches/cells
to setup
  clear-all

  ; Fill the initial data on patches
  ask patches [
    ifelse pycor < 3
    [ set block 1 + int (pxcor / 3) ]
    [ ifelse pycor < 6
      [ set block 4 + int (pxcor / 3) ]
      [ set block 7 + int (pxcor / 3) ]
    ]
    ; Block the cell belongs to (9 blocks 3x3)
    set block (3 * int (pycor / 3)) + 1 + int (pxcor / 3)
    ; Each block is filled with a slightly different color
    set pcolor scale-color black block -1 12
    ; Initial value in the cell: ordered in a row
    set value 1 + pxcor
    set plabel value
  ]

  ; Make a random swap of the cells
;  repeat 100 [
;    swap-values (one-of patches) (one-of patches)
;  ]

  ; Compute the constraints of every cell
  compute-constraints

  ; The global energy of the system is the sum of local energies (constraints)
  ;   of the cells
  set global-energy (sum [constraints] of patches )
  ;
  ; Update the view showing
  update-view

  ; Initial temperature
  set temperature 1

  ; Reset the tick counter
  reset-ticks
end

; Go Procedure, where controls the execution of the Simulated Annealing Algorithm
to go
  ; Em cada tick, com a mesma temperatura, fazemos algumas trocas
  repeat 5
  [
    ; The swapping is made between 2 random cells. The cells are chosen
    ; proportionally to their constraints, in order to change the worst
    ; with higher probability
    let p1 rnd:weighted-one-of patches [constraints]
    let p2 rnd:weighted-one-of patches [constraints]
    try-swap p1 p2
  ]
  ; resfrie o sistema
  set temperature temperature * (100 - cooling-rate) / 100

  ; Compute the energy after the swaps
  set global-energy (sum [constraints] of patches )
  update-view
  ; The miminum energy of the system is 81, since the minimum constraint of a cell
  ; is e^0 = 1
  if global-energy = 81 [stop]
  if temperature < 0.00000001 [stop]
  tick
end

; Procedure to compute the constraints of every cell.
; It can be improved by computing only the new constraints of the cells that
;   have been affected by a swap (rows, columns and blocks of the swapped cells).
;   We compute 81 constraints, and the minimal case is <= 9 + 9 + 12 + 10 = 40
to compute-constraints
  ask patches [
    set constraints e ^ (same-in-row + same-in-column + same-in-block)
  ]
end

; Auxiliary reports to compute the different constraints
to-report same-in-row
  let x pxcor
  report -1 + length filter [ ?1 -> ?1 = value ] ([value] of patches with [pxcor = x])
end

to-report same-in-column
  let y pycor
  report -1 + length filter [ ?1 -> ?1 = value ] ([value] of patches with [pycor = y])
end

to-report same-in-block
  let b block
  report -1 + length filter [ ?1 -> ?1 = value ] ([value] of patches with [block = b])
end

; Swap procedure between cells p1 and p2
to try-swap [p1 p2]
  ; If they have the same value, there is no need to change them
  if ([value] of p1 = [value] of p2)
    [ stop ]
  ; Try the swap
  swap-values p1 p2
  ; Compute new energy after the swapping
  compute-constraints
  let new-energy (sum [constraints] of patches)
  ; If the swap is accepted
  ifelse (accept-swap? global-energy new-energy)
  [
    ; Set the new energy as global
    set global-energy new-energy
  ]
  [
    ; If not, swap them again and compute their constraints
    swap-values p1 p2
    compute-constraints
  ]
end

; Auxiliary swap procedure between values of cells
to swap-values [ p1 p2 ]
  let temp [ value ] of p1
  ask p1 [ set value [value] of p2 ]
  ask p2 [ set value temp ]
end

; A swap is accepted if it improves the energy or randomly depending on
; the temperature of the system (it is the central idea of the Simulated
; Annealing Algorithm)
to-report accept-swap? [ previous-energy new-energy]
  let delta new-energy - previous-energy
  let randomNumber random-float 1.0
  ifelse delta < 0
  [report true]
  [
    ifelse randomNumber < e ^ (- delta / temperature)
    [report true]
    [report false]
  ]
end

; Update View procedure. It gives a scale-red color to the label of the cell
; according to the relative energy of the cell
;    dark: correct, bright: higher energy
; It also plots the energy
to update-view
  let M max [constraints] of patches
  ask patches [
    set plabel-color scale-color red constraints 0 M
    set plabel value
  ]
  plot global-energy
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
679
480
-1
-1
51.22222222222222
1
24
1
1
1
0
1
1
1
0
8
0
8
1
1
1
ticks
30.0

BUTTON
13
10
103
43
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
108
10
198
43
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
13
100
193
133
cooling-rate
cooling-rate
0
50
0.3
0.1
1
%
HORIZONTAL

MONITOR
53
50
153
95
NIL
Temperature
10
1
11

MONITOR
52
140
157
185
Global Energy
global-energy
4
1
11

PLOT
12
190
192
340
Global Energy
Time
Energy
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" ""

@#$#@#$#@
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.3.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
