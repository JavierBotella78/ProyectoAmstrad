.include "generator.h.s"

.include "../man/entity.h.s"
.include "../man/game.h.s"

.include "ai.h.s"
.include "colisions.h.s"

.globl cpct_memcpy_asm
.globl cpct_getRandom_mxor_u8_asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

minTime2Generate:
    .db #InitMinTime2Generate

time2Generate:
    .db #InitMinTime2Generate


maxNumberEnemies:
    .db #InitMaxNumberEnemies

numberEnemies:
    .db #InitMaxNumberEnemies


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  TEMPLATES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

initPlayer: 
   .db #ETypeRenderable | #ETypeInput | #ETypeMovable | #ETypeColider   ;; Type
   .db #10                                                              ;; x
   .db #Fila1                                                           ;; y
   .db #0                                                               ;; vx
   .db #0                                                               ;; vy
   .db #0x04                                                            ;; width
   .db #0x10                                                            ;; height
   .dw #0                                                               ;; AI
   .dw #sysColisionsPlayer                                              ;; Colision
   .dw #sysColisionsPlayer                                              ;; Colision
   .dw #_spr_idle                                                       ;; Sprite
   .dw #0xc000                                                          ;; prevPos
   .db #0                                                               ;; score


initEnemy1:
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable ;; Type
   .db #60                                                              ;; x
   .db #Fila1                                                           ;; y
   .db #0                                                               ;; vx
   .db #0                                                               ;; vy
   .db #0x04                                                            ;; width
   .db #0x10                                                            ;; height
   .dw #sysAIMoveLeft                                                   ;; AI   
   .dw #sysColisionsEnemy                                               ;; Colision
   .dw #sysColisionsDestroy                                             ;; Physics
   .dw #_spr_drone                                                       ;; Sprite
   .dw #0xc000                                                          ;; prevPos
   .db #125                                                             ;; score

initEnemy2:
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable ;; Type
   .db #60                                                              ;; x
   .db #Fila2                                                           ;; y
   .db #0                                                               ;; vx
   .db #0                                                               ;; vy
   .db #0x04                                                            ;; width
   .db #0x10                                                            ;; height
   .dw #sysAIMoveLeft                                                   ;; AI   
   .dw #sysColisionsEnemy                                             ;; Colision
   .dw #sysColisionsDestroy                                             ;; Physics
   .dw #_spr_octo                                                       ;; Sprite
   .dw #0xc000                                                          ;; prevPos
   .db #100                                                             ;; score

initEnemy3:
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable ;; Type
   .db #60                                                              ;; x
   .db #Fila3                                                           ;; y
   .db #0                                                               ;; vx
   .db #0                                                               ;; vy
   .db #0x04                                                            ;; width
   .db #0x10                                                            ;; height
   .dw #sysAIMoveLeft                                                   ;; AI   
   .dw #sysColisionsEnemy                                            ;; Colision
   .dw #sysColisionsDestroy                                             ;; Physics
   .dw #_spr_robo                                                       ;; Sprite
   .dw #0xc000                                                          ;; prevPos
   .db #50                                                              ;; score


initBullet:
   .db #ETypeRenderable | #ETypeColider | #ETypeMovable  ;; Type     
   .db #13                                               ;; x
   .db #0                                                ;; y
   .db #2                                                ;; vx
   .db #0                                                ;; vy
   .db #4                                             ;; width
   .db #4                                             ;; height
   .dw #0                                                ;; AI
   .dw #sysColisionsBullet                               ;; Colision
   .dw #sysColisionsBullet                               ;; Physics
   .dw #_spr_rainbow                                      ;; Sprite
   .dw #0xc000                                           ;; prevPos
   .db #0                                                ;; score

 ;; initInterf:
  ;;  .db #ETypeRenderable                                  ;; Type     
   ;; .db #0                                               ;; x
   ;; .db #0                                                ;; y
    ;;.db #0                                                ;; vx
    ;;.db #0                                                ;; vy
    ;;.db #31                                             ;; width
    ;;.db #100                                             ;; height
    ;;.dw #0                                                ;; AI
    ;;.dw #0                                                ;; Colision
    ;;.dw #0                                                ;; Physics
    ;;.dw #_spr_hud_0                                         ;; Sprite
    ;;.dw #0xc000                                           ;; prevPos
    ;;.db #0                                                ;; score



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorInit
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorInit::

   ld hl, #initPlayer
   call sysGeneratorTmpl

;;    ld hl, #initInterf
;;   call sysGeneratorTmpl

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysGeneratorUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;
;;
sysGeneratorUpdate::

    ld a, (#time2Generate)
    dec a
    ld (#time2Generate), a

    ret nz

    ld a, (#minTime2Generate)
    ld (#time2Generate), a


    ld a, (#numberEnemies)
    or a
    
    ret z

    dec a
    ld (#numberEnemies), a

    call sysGeneratorEnemy

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Tmpl
;; Parameters:
;;    hl -> Entity template
;; Return:
;;    -
;; Description:
;;    Creates an entity from a template
;;
sysGeneratorTmpl:

   push hl

   call manEntityCreate  

   ex de, hl
   pop hl
   ld bc, #EntitySize

   call cpct_memcpy_asm

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Enemy
;; Parameters:
;;    hl -> Entity template
;; Return:
;;    -
;; Description:
;;    Creates an entity from a template
;;
sysGeneratorEnemy:

   call cpct_getRandom_mxor_u8_asm

   ld a, #3
   and l

   or a

   jp nz, generateEnemy2

   ld hl, #initEnemy1

   jp sysGeneratorEnemyCall

generateEnemy2:

   dec a
   
   jp nz, generateEnemy3

   ld hl, #initEnemy2

   jp sysGeneratorEnemyCall

generateEnemy3:

   ld hl, #initEnemy3

sysGeneratorEnemyCall:
   call sysGeneratorTmpl

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    BulletCreator
;; Parameters:
;;    ix -> Player entity
;; Return:
;;    -
;; Description:
;;    Creates a bullet-type entity at the player's vertical position
;;
sysGeneratorBulletCreator::

   ld iy, #initBullet

   ld a, indY(ix)
   ld b, #8
   add a, b
   ld indY(iy), a 

   ld hl, #initBullet

   call sysGeneratorTmpl

ret