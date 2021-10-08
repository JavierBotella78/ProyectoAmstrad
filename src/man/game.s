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
   call manGamePlayerUpdate

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
manGamePlayerUpdate:

   ld a, (#playerInvulnerability)
   or a
   ret z

   dec a
   ld (playerInvulnerability), a 

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

;;Comprobar que haya solo una bala

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