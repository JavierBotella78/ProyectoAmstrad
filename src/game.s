.include "cpctelera.h.s"
.include "entityInfo.s"

.globl cpct_waitVSYNC_asm
.globl cpct_memcpy_asm

.globl sysPhysicsUpdate
.globl sysRenderUpdate

.globl manEntityCreate

.globl manEntityInit 
.globl sysRenderInit 


initPlayer: ;; 0->type, 1->x, 2->y, 3->vx , 4->vy, 5->ancho(w), 6->alto(h), 7->color, 8-9->prevPos
   .db #7      ;;Renderable, Movable, Input
   .db #10
   .db #10
   .db #0
   .db #0
   .db #2
   .db #8
   .db #0xff
   .dw #0xc000


initEnemigo:
   .db #11      ;;Renderable, Movable, AI
   .db #60
   .db #10
   .db #-1
   .db #0
   .db #2
   .db #8
   .db #0xff
   .dw #0xc000


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manGameInit
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inicializa el juego
manGameInit::

   call manEntityInit ;; Iniciamos todos los valores del array a 0
   call sysRenderInit 

   ld hl, #initPlayer
   call manGameCreator

   ld hl, #initEnemigo
   call manGameCreator

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manGamePlay
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    loop principal del juego
manGamePlay::

mainLoop:
   call sysPhysicsUpdate
   call sysRenderUpdate
   
   call esperar


loop:
   jr    mainLoop
   
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manGameCreator
;; Requisitos:
;;    hl -> Plantilla de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Crea una entidad apartir de una plantilla
manGameCreator:

   push hl

   call manEntityCreate 

   ex de, hl
   pop hl
   ld bc, #EntitySize

   call cpct_memcpy_asm

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; esperar
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Hace pausas en la ejecución del programa entre ciclos
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