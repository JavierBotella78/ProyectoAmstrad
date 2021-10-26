.include "cpctelera.h.s"
.include "game.h.s" 
.include "entity.h.s"
.include "interruptions.h.s"

.include "../sys/render.h.s"
.include "../sys/prerender.h.s"
.include "../sys/colisions.h.s"
.include "../sys/input.h.s"
.include "../sys/physics.h.s"
.include "../sys/ai.h.s"
.include "../sys/generator.h.s"
.include "../sys/animations.h.s"

.globl cpct_waitVSYNC_asm

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

   call waitHalt

   call sysPreRenderUpdate

   ld a, (#playerLife)
   or a
   jp nz, mainLoop
   
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

   ld a, (#playerInvulnerability)
   or a
   
   ret nz

   ld a, (#playerLife)
   dec a
   ld (playerLife), a 
   ;;Dibujar estrella rota

   push ix
   ld ix, #initStars

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

   ;;TODO: QUE NO PASE DE 9999 A 0

   ld (score), hl

   call sysRenderScore

ret

manGameSubScore:

   ld hl, (#score)
   ld c, #0x10
   ld b, #0

   ld a, l
   sub c
   daa
   ld l, a

   ld a, h
   sbc b
   daa
   ld h, a

   ;;TODO: QUE NO PASE DE 0 A 9999

   ld (score), hl

   call sysRenderScore

ret

manGamePUBulletColision::

   ld hl, #powerUpBullet
   call manGamePUColision

ret

manGamePUScoreColision::

   ld hl, #powerUpScore
   call manGamePUColision

ret

manGamePUColision:

   ld (hl), #PUTime

ret



manGameGetScore::

   ld hl, (#score)

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
waitHalt:
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