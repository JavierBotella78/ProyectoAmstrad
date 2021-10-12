.include "cpctelera.h.s"
.include "game.h.s" 
.include "entity.h.s"

.include "../sys/render.h.s"
.include "../sys/colisions.h.s"
.include "../sys/input.h.s"
.include "../sys/physics.h.s"
.include "../sys/ai.h.s"
.include "../sys/generator.h.s"

.globl cpct_waitVSYNC_asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

playerLife:
   .db #4

playerInvulnerability:
   .db #MaxPlayerInvulnerability

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
   call sysGeneratorInit

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

   call sysPhysicsUpdate

   call sysRenderUpdate
   call sysColisionsUpdate
   
   call waitHalt

loop:
   jr    mainLoop
   
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

   ld hl, #playerInvulnerability
   ld a, (hl)
   call manGameVariableUpdate

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

   ld a, #MaxPlayerInvulnerability
   ld (playerInvulnerability),  a
   
   ret nz

   call manEntityMarkToDestroy

ret


manGameScore::

   ld hl, (#score)
   ld c, indScore(ix)
   ld b, #0

   add hl, bc
   
   ld (score), hl

   ld a, (#powerUpScore)
   or a
   
   ret z

   add hl, bc
   
   ld (score), hl
   
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

   ld a, (#playerLife)
   inc a
   ld (playerLife), a

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
   ld a, #3
   esperarbucle:
   push af
   halt
   halt
   call cpct_waitVSYNC_asm
   pop af
   dec a
   jr nz, esperarbucle
ret