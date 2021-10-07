.include "cpctelera.h.s"
.include "game.h.s" 
.include "entity.h.s"

.include "../sys/render.h.s"
.include "../sys/colisions.h.s"
.include "../sys/input.h.s"
.include "../sys/physics.h.s"
.include "../sys/ai.h.s"

.globl cpct_waitVSYNC_asm
.globl cpct_memcpy_asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  TEMPLATES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

initPlayer: 
   .db #ETypeRenderable | #ETypeInput | #ETypeMovable ;; Type
   .db #10                                            ;; x
   .db #10                                            ;; y
   .db #0                                             ;; vx
   .db #0                                             ;; vy
   .db #0x04                                          ;; width
   .db #0x10                                          ;; height
   .dw #0                                             ;; AI
   .dw #_spr_idle                                     ;; Sprite
   .dw #0xc000                                        ;; prevPos


initEnemigo:
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable ;; Type
   .db #60                                                              ;; x
   .db #10                                                              ;; y
   .db #0                                                               ;; vx
   .db #0                                                               ;; vy
   .db #0x04                                                            ;; width
   .db #0x10                                                            ;; height
   .dw #sysAIMoveLeft                                                   ;; AI   
   .dw #_spr_idle                                                       ;; Sprite
   .dw #0xc000                                                          ;; prevPos


initBala:
   .db #ETypeRenderable | #ETypeBullet | #ETypeMovable   ;; Type     
   .db #13                                               ;; x
   .db #0                                                ;; y
   .db #2                                                ;; vx
   .db #0                                                ;; vy
   .db #0x04                                             ;; width
   .db #0x10                                             ;; height
   .dw #0                                                ;; AI
   .dw #_spr_idle                                        ;; Sprite
   .dw #0xc000                                           ;; prevPos



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Init
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inicializa el juego
;;
manGameInit::

   call manEntityInit ;; Iniciamos todos los valores del array a 0
   call sysRenderInit 

   ld hl, #initPlayer
   call manGameCreator

   ld hl, #initEnemigo
   call manGameCreator

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Play
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    loop principal del juego
;;
manGamePlay::

mainLoop:
   call manEntityDestroyDead

   call sysInputUpdate
   call sysAIUpdate

   call sysPhysicsUpdate
   
   call sysRenderUpdate
   call sysColisionsUpdate
   
   call esperar


loop:
   jr    mainLoop
   
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Creator
;; Requisitos:
;;    hl -> Plantilla de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Crea una entidad apartir de una plantilla
;;
manGameCreator:

   push hl

   call manEntityCreate  

   ex de, hl
   pop hl
   ld bc, #EntitySize

   call cpct_memcpy_asm

ret

manGameBulletCreator::

   ld iy, #initBala

   ld a, indY(ix)
   ld b, #3
   add a, b
   ld indY(iy), a 

   ld hl, #initBala

   call manGameCreator

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    esperar
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Hace pausas en la ejecución del programa entre ciclos
;;
esperar:
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