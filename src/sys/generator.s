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
    .db #InitMaxTime2Generate

time2Generate:
    .db #InitMaxTime2Generate

maxNumberEnemies:
    .db #InitMinNumberEnemies

numberEnemies:
    .db #InitMinNumberEnemies

speedUp:
   .db #SpeedUp1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  TEMPLATES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

initPlayer: 
   .db #ETypeRenderable | #ETypeInput | #ETypeMovable | #ETypeColider   ;; Type
   .db #10, #EFila1, #0, #0                                             ;; x, y, vx, vy
   .db #4, #16                                                          ;; width, height
   .dw #0                                                               ;; AI
   .dw #sysColisionsPlayer, #sysColisionsPlayer                         ;; Colision, Physics
   .dw #_spr_idle, #0xc000                                              ;; Sprite, prevPos
   .db #0, #0                                                           ;; score, subtype
   .dw #0                                                               ;; Anim
   .db #0, #0                                                           ;; AnimCounter, AnimActual
   .dw #0                                                                                 ;; actualPos
   .db #0                                                                                 ;; AICounter
   .db #4, #16                                                          ;; delWitdh, delHeight

initEnemy1: 
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable | #ETypeAnimated  ;; Type
   .db #63, #EFila1, #0, #0                                                               ;; x, y, vx, vy
   .db #6, #16                                                                            ;; width, height
   .dw #sysAIEnemy1                                                                       ;; AI
   .dw #sysColisionsEnemy, #sysColisionsDestroy                                           ;; Colision, Physics
   .dw #_spr_drone, #0xc000                                                               ;; Sprite, prevPos
   .db #125, #AITypeEnemy | #RenderTypeStatic                                             ;; score, subtype
   .dw #animationEnemy1                                                                   ;; Anim
   .db #5, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0                                                                                 ;; actualPos
   .db #0                                                                                 ;; AICounter
   .db #6, #16                                                                            ;; delWitdh, delHeight

initEnemy2: 
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable | #ETypeAnimated  ;; Type
   .db #63, #EFila2, #0, #0                                                               ;; x, y, vx, vy
   .db #5, #16                                                                            ;; width, height
   .dw #sysAIEnemy2                                                                       ;; AI
   .dw #sysColisionsEnemy, #sysColisionsDestroy                                           ;; Colision, Physics
   .dw #_spr_octo, #0xc000                                                                ;; Sprite, prevPos
   .db #100, #AITypeEnemy | #RenderTypeStatic                                             ;; score, subtype
   .dw #animationEnemy2                                                                   ;; Anim
   .db #5, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0                                                                                 ;; actualPos
   .db #0                                                                                 ;; AICounter
   .db #5, #13                                                                            ;; delWitdh, delHeight

initEnemy3: 
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable | #ETypeAnimated  ;; Type
   .db #63, #EFila3, #0, #0                                                               ;; x, y, vx, vy
   .db #6, #16                                                                            ;; width, height
   .dw #sysAIEnemy3                                                                       ;; AI
   .dw #sysColisionsEnemy, #sysColisionsDestroy                                           ;; Colision, Physics
   .dw #_spr_robo, #0xc000                                                                ;; Sprite, prevPos
   .db #50, #AITypeEnemy | #RenderTypeStatic                                              ;; score, subtype
   .dw #animationEnemy3                                                                   ;; Anim
   .db #5, #0                                                                             ;; AnimCounter, AnimActual
   .dw #0                                                                                 ;; actualPos
   .db #0                                                                                 ;; AICounter
   .db #6, #13                                                                            ;; delWitdh, delHeight

initBullet: 
   .db #ETypeRenderable | #ETypeColider | #ETypeMovable                 ;; Type 
   .db #13, #0, #2, #0                                                  ;; x, y, vx, vy
   .db #6, #4                                                           ;; width, height
   .dw #0                                                               ;; AI
   .dw #sysColisionsBullet, #sysColisionsDestroy                        ;; Colision, Physics
   .dw #_spr_rainbow, #0xc000                                           ;; Sprite, prevPos
   .db #0, #AITypeBullet | #RenderTypeStatic                            ;; score, subtype
   .dw #0                                                               ;; Anim
   .db #0, #0                                                           ;; AnimCounter, AnimActual
   .dw #0                                                               ;; actualPos
   .db #0                                                               ;; AICounter
   .db #6, #4                                                           ;; delWitdh, delHeight

initPUBullet: 
   .db #ETypeRenderable | #ETypeColisionable | #ETypeMovable | #ETypeAnimated ;; Type     
   .db #0, #0, #-1, #0                                                        ;; x, y, vx, vy
   .db #5, #12                                                                ;; width, height
   .dw #0                                                                     ;; AI
   .dw #sysColisionPUBullet, #sysColisionsDestroy                             ;; Colision, Physics
   .dw #_spr_powerup1, #0xc000                                                ;; Sprite, prevPos
   .db #0, #AITypePU | #RenderTypeStatic                                      ;; score, subtype
   .dw #animationPUBullet                                                     ;; Anim
   .db #5, #0                                                                 ;; AnimCounter, AnimActual
   .dw #0                                                                     ;; actualPos
   .db #0                                                                     ;; AICounter
   .db #5, #12                                                                ;; delWitdh, delHeight

initPUScore: 
   .db #ETypeRenderable | #ETypeColisionable | #ETypeMovable | #ETypeAnimated ;; Type    
   .db #0, #0, #-1, #0                                                        ;; x, y, vx, vy
   .db #5, #12                                                                ;; width, height
   .dw #0                                                                     ;; AI
   .dw #sysColisionPUScore, #sysColisionsDestroy                              ;; Colision, Physics
   .dw #_spr_doblescore1, #0xc000                                             ;; Sprite, prevPos
   .db #0, #AITypePU | #RenderTypeStatic                                      ;; score, subtype
   .dw #animationPUScore                                                      ;; Anim
   .db #5, #0                                                                 ;; AnimCounter, AnimActual
   .dw #0                                                                     ;; actualPos
   .db #0                                                                     ;; AICounter
   .db #5, #12                                                                ;; delWitdh, delHeight

initInterf: 
   .db #ETypeRenderable       ;; Type  
   .db #0, #144, #0, #0       ;; x, y, vx, vy
   .db #20, #56               ;; width, height
   .dw #0                     ;; AI
   .dw #0, #0                 ;; Colision, Physics
   .dw #_spr_hud_0, #0xc000   ;; Sprite, prevPos

initInterf2: 
   .db #ETypeRenderable       ;; Type  
   .db #20, #144, #0, #0      ;; x, y, vx, vy
   .db #20, #56               ;; width, height
   .dw #0                     ;; AI
   .dw #0, #0                 ;; Colision, Physics
   .dw #_spr_hud_1, #0xc000   ;; Sprite, prevPos

initInterf3: 
   .db #ETypeRenderable       ;; Type  
   .db #40, #144, #0, #0      ;; x, y, vx, vy
   .db #20, #56               ;; width, height
   .dw #0                     ;; AI
   .dw #0, #0                 ;; Colision, Physics
   .dw #_spr_hud_2, #0xc000   ;; Sprite, prevPos

initInterf4: 
   .db #ETypeRenderable       ;; Type  
   .db #60, #144, #0, #0      ;; x, y, vx, vy
   .db #20, #56               ;; width, height
   .dw #0                     ;; AI
   .dw #0, #0                 ;; Colision, Physics
   .dw #_spr_hud_3, #0xc000   ;; Sprite, prevPos

initFloor1: 
   .db #ETypeRenderable | #ETypeAnimated  ;; Type
   .db #0, #Fila3, #0, #0                 ;; x, y, vx, vy
   .db #40, #11                           ;; width, height
   .dw #0                                 ;; AI
   .dw #0, #0                             ;; Colision, Physics
   .dw #_spr_floor1, #0xc000              ;; Sprite, prevPos
   .db #0, #RenderTypeStatic              ;; score, subtype
   .dw #animationFloor1                   ;; Anim
   .db #5, #0                             ;; AnimCounter, AnimActual

initFloor2: 
   .db #ETypeRenderable | #ETypeAnimated  ;; Type
   .db #0, #Fila2, #0, #0                 ;; x, y, vx, vy
   .db #40, #11                           ;; width, height
   .dw #0                                 ;; AI
   .dw #0, #0                             ;; Colision, Physics
   .dw #_spr_floor11, #0xc000             ;; Sprite, prevPos
   .db #0, #RenderTypeStatic              ;; score, subtype
   .dw #animationFloor11                  ;; Anim
   .db #5, #0                             ;; AnimCounter, AnimActual


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

   ld hl, #initFloor1
   call sysGeneratorTmpl

   ld hl, #initFloor2
   call sysGeneratorTmpl

   ld ix, #initFloor1
   ld a, #40
   ld indX(ix), a
   ld hl, #initFloor1 
   call sysGeneratorTmpl

   ld ix, #initFloor2
   ld a, #40
   ld indX(ix), a
   ld hl, #initFloor2 
   call sysGeneratorTmpl

   ld hl, #initPlayer
   call sysGeneratorTmpl

   ;;DIBUJADO INICIAL DE LA INTERFAZ
   ld ix, #initInterf
   call sysRenderDrawOnce

   ld ix, #initInterf2
   call sysRenderDrawOnce

   ld ix, #initInterf3
   call sysRenderDrawOnce

   ld ix, #initInterf4
   call sysRenderDrawOnce

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

   ret nz                     ;; Si no da 0, no genera enemigos

   ld a, (#minTime2Generate)
   ld (#time2Generate), a


   ld a, (#numberEnemies)
   or a
   
   jp nz, skipResetEnemies           ;; Si no quedan enemigos por generar, aumenta la velocidad y los enemigos.

   ld a, (#maxNumberEnemies)
   ld c, #MaxNumberEnemies
   cp c

   jp z, skipToTimer

   ld b, #AddNumberEnemies
   add a, b

;; CAMBIO DE VELOCIDAD

   ld b, #SpeedUp2
   cp b

   jp z, changeSpeed2

   ld b, #SpeedUp1
   cp b

   jp z, changeSpeed1

   jp skipToTimer

changeSpeed2:

   push af

   ld a, (#speedAILeft)
   dec a
   ld (speedAILeft), a
   
   pop af

   jp skipToTimer

changeSpeed1:

   push af

   ld a, (#aiCounter)
   dec a
   ld (aiCounter), a
   
   pop af
   
skipToTimer:
   ld (numberEnemies), a
   ld (maxNumberEnemies), a

   ld a, (#minTime2Generate)
   ld c, #MinTime2Generate
   cp c

   jp z, skipToEnemies

   ld b, #SubTime2Generate
   sub a, b

skipToEnemies:
   ld (minTime2Generate), a
   ld (time2Generate), a

skipResetEnemies:

   ld a, (#numberEnemies)
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