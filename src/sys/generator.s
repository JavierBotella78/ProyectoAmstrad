.include "generator.h.s"

.include "../man/entity.h.s"
.include "../man/game.h.s"

.include "ai.h.s"
.include "colisions.h.s"
.include "render.h.s"
.include "animations.h.s"

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
   .db #4                                                           ;; width
   .db #16                                                            ;; height
   .dw #0                                                               ;; AI
   .dw #sysColisionsPlayer                                              ;; Colision
   .dw #sysColisionsPlayer                                              ;; Physics
   .dw #_spr_idle                                                       ;; Sprite
   .dw #0xc000                                                          ;; prevPos
   .db #0                                                               ;; score
   .db #0                                                     ;; subType


initEnemy1:
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable | #ETypeAnimated ;; Type
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
   .db #AITypeEnemy                                                     ;; subType
   .dw #animationEnemy1                                                 ;; Anim
   .db #5                                                              ;; AnimCounter
   .db #0                                                               ;; AnimActual

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
   .db #AITypeEnemy                                                     ;; subType

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
   .db #AITypeEnemy                                                     ;; subType


initBullet:
   .db #ETypeRenderable | #ETypeColider | #ETypeMovable  ;; Type     
   .db #13                                               ;; x
   .db #0                                                ;; y
   .db #2                                                ;; vx
   .db #0                                                ;; vy
   .db #4                                             ;; width
   .db #4                                             ;; height
   .dw #0                                                ;; AI
   .dw #sysColisionsDestroy                               ;; Colision
   .dw #sysColisionsDestroy                               ;; Physics
   .dw #_spr_rainbow                                      ;; Sprite
   .dw #0xc000                                           ;; prevPos
   .db #0                                                ;; score
   .db #0                                                     ;; subType

initPUBullet:
   .db #ETypeRenderable | #ETypeColisionable | #ETypeMovable | #ETypeAI  ;; Type     
   .db #0                                               ;; x
   .db #0                                                ;; y
   .db #0                                                ;; vx
   .db #0                                                ;; vy
   .db #4                                             ;; width
   .db #4                                             ;; height
   .dw #sysAIMoveLeft                                                ;; AI
   .dw #sysColisionPUBullet                               ;; Colision
   .dw #sysColisionsDestroy                               ;; Physics
   .dw #_spr_idle                                                       ;; Sprite
   .dw #0xc000                                           ;; prevPos
   .db #0                                                ;; score
   .db #0                                                     ;; subType

initPUScore:
   .db #ETypeRenderable | #ETypeColisionable | #ETypeMovable | #ETypeAI  ;; Type     
   .db #0                                               ;; x
   .db #0                                                ;; y
   .db #0                                                ;; vx
   .db #0                                                ;; vy
   .db #4                                             ;; width
   .db #4                                             ;; height
   .dw #sysAIMoveLeft                                                ;; AI
   .dw #sysColisionPUScore                               ;; Colision
   .dw #sysColisionsDestroy                               ;; Physics
   .dw #_spr_rainbow                                      ;; Sprite
   .dw #0xc000                                           ;; prevPos
   .db #0                                                ;; score
   .db #0                                                     ;; subType

initInterf:
   .db #ETypeRenderable                                  ;; Type     
   .db #0                                             ;; x
   .db #144                                                ;; y
   .db #0                                                ;; vx
   .db #0                                                ;; vy
   .db #20                                            ;; width
   .db #56                                             ;; height
   .dw #0                                                ;; AI
   .dw #0                                                ;; Colision
   .dw #0                                                ;; Physics
   .dw #_spr_hud_0                                         ;; Sprite
   .dw #0xc000                                           ;; prevPos
   .db #0                                                ;; score

initInterf2:
   .db #ETypeRenderable                                  ;; Type     
   .db #20                                             ;; x
   .db #144                                                ;; y
   .db #0                                                ;; vx
   .db #0                                                ;; vy
   .db #20                                            ;; width
   .db #56                                             ;; height
   .dw #0                                                ;; AI
   .dw #0                                                ;; Colision
   .dw #0                                                ;; Physics
   .dw #_spr_hud_1                                         ;; Sprite
   .dw #0xc000                                           ;; prevPos
   .db #0                                                ;; score

initInterf3:
   .db #ETypeRenderable                                  ;; Type     
   .db #40                                             ;; x
   .db #144                                                ;; y
   .db #0                                                ;; vx
   .db #0                                                ;; vy
   .db #20                                            ;; width
   .db #56                                             ;; height
   .dw #0                                                ;; AI
   .dw #0                                                ;; Colision
   .dw #0                                                ;; Physics
   .dw #_spr_hud_2                                         ;; Sprite
   .dw #0xc000                                           ;; prevPos
   .db #0                                                ;; score

initInterf4:
   .db #ETypeRenderable                                  ;; Type     
   .db #60                                             ;; x
   .db #144                                                ;; y
   .db #0                                                ;; vx
   .db #0                                                ;; vy
   .db #20                                            ;; width
   .db #56                                             ;; height
   .dw #0                                                ;; AI
   .dw #0                                                ;; Colision
   .dw #0                                                ;; Physics
   .dw #_spr_hud_3                                         ;; Sprite
   .dw #0xc000                                           ;; prevPos
   .db #0                                                ;; score





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

   ;;DIBUJADO INICIAL DE LA INTERFAZ
   ld ix, #initInterf
   call sysRenderUpdateOne

   ld ix, #initInterf2
   call sysRenderUpdateOne

   ld ix, #initInterf3
   call sysRenderUpdateOne

   ld ix, #initInterf4
   call sysRenderUpdateOne

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



sysGeneratorPU::

   call cpct_getRandom_mxor_u8_asm

   ld a, #3
   and l

   or a

   jp nz, generatePU2

   ld hl, #initPUBullet
   ld iy, #initPUBullet

   jp sysGeneratorPUCall

generatePU2:

   dec a
   
   ret nz

   ld hl, #initPUScore
   ld iy, #initPUScore

sysGeneratorPUCall:

   ld a, indX(ix)
   ld indX(iy), a

   ld a, indY(ix)
   ld indY(iy), a

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