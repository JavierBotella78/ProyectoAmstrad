;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of Cosmic Gatlin: An Amstrad CPC Game 
;;  Authors: 
;;      Javier Botella Martínez (@javierbotella)
;;      Francesc Martinez Torregrosa (@mellamofrancesc)
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;------------------------------------------------------------------------------

.include "cpctelera.h.s"
.include "game.h.s" 
.include "entity.h.s"
.include "interruptions.h.s"
.include "difficulty.h.s"


.include "../sys/render.h.s"
.include "../sys/prerender.h.s"
.include "../sys/colisions.h.s"
.include "../sys/input.h.s"
.include "../sys/physics.h.s"
.include "../sys/ai.h.s"
.include "../sys/generator.h.s"
.include "../sys/animations.h.s"

.include "../bangerazo.h.s"


.globl cpct_waitVSYNC_asm

.globl cpct_akp_musicInit_asm
.globl cpct_akp_musicPlay_asm
.globl cpct_akp_stop_asm

.globl _pew
.globl cpct_akp_SFXInit_asm
.globl cpct_akp_SFXPlay_asm
.globl cpct_akp_SFXStop_asm



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

playerLife:
   .db #4

playerInvulnerability:
   .db #MaxPlayerInvulnerability

playerInvSubTime:
   .db #0

bulletLife:
   .db #0

highscore:
   .dw #0

score:
   .dw #0

powerUpBullet:
   .db #0

powerUpScore:
   .db #0



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Init
;; Parameters:
;;    -
;; Return:
;;    -
;; Description:
;;    Initialize the game
;;
manGameInit::

   call manEntityInit ;; Iniciamos todos los valores del array a 0
   call sysRenderInit 
   call sysAIInit
   call sysGeneratorInit
   call sysGeneratorInitGame
   call sysPreRenderUpdate
   call sysInputInit
   call manDifficultyInit

   ld hl, #0
   call sysRenderScore

   ld a, #4
   ld (playerLife), a

   ld hl, #0
   ld (score), hl

   ld a, #0
   ld (powerUpBullet), a

   ld a, #0
   ld (powerUpScore), a

   ld de, #_cancion1
   call cpct_akp_musicInit_asm
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Play
;; Parameters:
;;    -
;; Return:
;;    -
;; Description:
;;    Main game loop
;;
manGamePlay::

mainLoop:

   call manEntityDestroyDead
   call manGameUpdate

   call sysGeneratorUpdate

   call sysInputUpdate
   call sysAIUpdate
   call sysAnimationsUpdate

   call sysColisionsUpdate
   call sysPhysicsUpdate

   

loopRender:
   ld a, (#numI)
   cp #1
   jr nz, loopRender
   call sysRenderUpdate

   call sysPreRenderUpdate

   call cpct_akp_musicPlay_asm
   call cpct_akp_musicPlay_asm


   call waitHalt

   ld a, (#playerLife)
   or a
   jp nz, mainLoop

   call cpct_akp_stop_asm
   call cpct_akp_SFXStop_asm
   call manGameChangeHighscore
   
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Update
;; Parameters:
;;    -
;; Return:
;;    -
;; Description:
;;    Decreases the player's life by 1 if it's hit by an enemy
;;
manGameUpdate:

   ld a, (#playerInvulnerability)
   or a

   jp z, keepManGameUpdate

   dec a
   ld (#playerInvulnerability), a 

   ld a, (#playerInvSubTime)
   dec a
   ld (#playerInvSubTime), a 

   jp z, changePlayerRender 
   jp keepManGameUpdate

changePlayerRender:

   ld a, #MaxPlayerInvSubTime
   ld (#playerInvSubTime), a 

   ld a, #1
   ld (#changeRenderable), a


keepManGameUpdate:

   ld hl, #bulletLife
   ld a, (hl)
   call manGameVariableUpdate

   ld hl, #powerUpScore
   ld a, (hl)
   call manGameVariableUpdate

   ld hl, #powerUpBullet
   ld a, (hl)
   call manGameVariableUpdate

ret

manGameVariableUpdate:

   or a
   ret z

   dec a
   ld (hl), a 

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    BulletCreator
;; Parameters:
;;    -
;; Return:
;;    -
;; Description:
;;    Decreases the player's life by 1 if it's hit by an enemy
;;
manGameBulletCreator::

   ld a, (#bulletLife)
   or a 

   ret nz

   ld hl, #powerUpBullet
   ld b, (hl)
   or b

   jp nz, ifPowerUpBullet

   ld a, #SingleBulletTime

   jp exitPowerUpBullet

   

ifPowerUpBullet:
   ld a, #MultiBulletTime

exitPowerUpBullet:
   ld (#bulletLife), a
   call sysGeneratorBulletCreator

   ld de, #_pew
   call cpct_akp_SFXInit_asm

   ld l, #1
   ld h, #15
   ld e, #65
   ld d, #0
   ld bc,#0
   ld a, #10
   push ix 
   call cpct_akp_SFXPlay_asm
   pop ix 
   
  
   

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    PlayerColision
;; Parameters:
;;    ix -> Player entity
;; Return:
;;    -
;; Description:
;;    Decreases the player's life by 1 if it's hit by an enemy
;;
manGamePlayerColision::

   ld de, #_pew
   call cpct_akp_SFXInit_asm

   ld l, #1
   ld h, #15
   ld e, #45
   ld d, #0
   ld bc,#0
   ld a, #10
   push ix 
   call cpct_akp_SFXPlay_asm
   pop ix 

   ld a, (#playerInvulnerability)
   or a
   
   ret nz

   ld a, (#playerLife)
   dec a
   ld (playerLife), a 
   ;;Dibujar estrella rota

   push ix
   call drawLifeStars
   pop ix

   ld a, #MaxPlayerInvulnerability
   ld (playerInvulnerability),  a

   ld a, #MaxPlayerInvSubTime
   ld (playerInvSubTime),  a

   ld a, (#playerLife)
   or a
   
   ret nz ;; Si 0 vidas, game over

   call manEntityMarkToDestroy

  

ret


manGameScore::

   ld hl, (#score)
   ld c, indScore(ix)
   ld b, #0

   ld a, (#powerUpScore)
   or a
   
   jp z, skipDobleScore

   ld a, c
   add a
   daa
   ld c, a

skipDobleScore:
   
   ld a, l
   add c
   daa
   ld l, a

   ld a, h
   adc b
   daa
   ld h, a

   jp nc, skipMaxScore

   ld a, #0
   ld (playerLife), a

   ld hl, #0x9999

skipMaxScore:
   ld (score), hl

   call sysRenderScore

ret

manGameSubScore:

   ld hl, (#score)
   ld c, #0x20
   ld b, #0

   ld a, l
   sub c
   daa
   ld l, a

   ld a, h
   sbc b
   daa
   ld h, a

   jp nc, skipMinScore

   ld hl, #0

skipMinScore:

   ld (score), hl

   call sysRenderScore

ret

manGamePUBulletColision::

   ld hl, #powerUpBullet
   ld (hl), #PUTimeBullet

ret

manGamePUScoreColision::

   ld hl, #powerUpScore
   ld (hl), #PUTimeScore

ret

manGamePULifeColision::

   ld a, (#playerLife)
   inc a

   ld b, #5
   cp b

   ret z
   
   ld (playerLife), a 

   
   push ix
   call drawLifeStars
   pop ix

ret


drawLifeStars::

   ld ix, #initStars

   ld b, #4                   ;; 4 ESTRELLAS
   cp b
   
   jp z, stars4

   ld b, #3                   ;; 3 ESTRELLAS
   cp b
   
   jp z, stars3

   ld b, #2                   ;; 2 ESTRELLAS
   cp b
   
   jp z, stars2

   ld b, #1                   ;; 1 ESTRELLAS
   cp b
   
   jp z, stars1               ;; 0 ESTRELLAS

   or a

   jp z, stars0

stars4:
   ld hl, #_spr_stars4
   jp skipStars
stars3:
   ld hl, #_spr_stars3
   jp skipStars
stars2:
   ld hl, #_spr_stars2
   jp skipStars
stars1:
   ld hl, #_spr_stars1
   jp skipStars
stars0:
   ld hl, #_spr_stars0
skipStars:
   
   ld indSprite1(ix), h 
   ld indSprite2(ix), l

   call sysRenderDrawOnce


ret


manGameChangeHighscore:

   ld hl, (#score)
   ld bc, (#highscore)

   ld a, h
   cp b
   ret c

   jp z, sameUpperScore

   ld (#highscore), hl

   ret

sameUpperScore:
   ld a, l
   cp c

   ret c

   ld (#highscore), hl

ret


manGameGetHighscore::

   ld hl, (#highscore)

ret

manGameGetScoreWin::

   ld hl, (#score)

   ld a, #0x99
   cp l

   jp nz, no9999

   cp h

   jp nz, no9999
   jp si9999

no9999:
   ld a, #0

ret

si9999:
   ld a, #1

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    waitHalt
;; Parameters:
;;    -
;; Return:
;;    -
;; Description:
;;    Wait x halts and vsync
;;
waitHalt::
   ld a, #1
   esperarbucle:
   push af
   halt
   halt
   call cpct_waitVSYNC_asm
   pop af
   dec a
   jr nz, esperarbucle
ret