.include "cpctelera.h.s"
.include "entityInfo.s"

.globl cpct_waitVSYNC_asm
.globl cpct_memcpy_asm

.globl sysInputUpdate
.globl sysPhysicsUpdate
.globl sysRenderUpdate

.globl manEntityCreate

.globl manEntityInit 
.globl sysRenderInit 


initPlayer: 
   .db #ETypeRenderable | #ETypeInput | #ETypeMovable ;; Type
   .db #10                                            ;; x
   .db #10                                            ;; y
   .db #0                                             ;; vx
   .db #0                                             ;; vy
   .db #2                                             ;; width
   .db #8                                             ;; height
   .db #0xff                                          ;; Color
   .dw #0xc000                                        ;; prevPos


initEnemigo:
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable   
   .db #60
   .db #10
   .db #0
   .db #0
   .db #2
   .db #8
   .db #0xff
   .dw #0xc000


initBala:
   .db #ETypeRenderable | #ETypeColisionable | #ETypeMovable    
   .db #13
   .db #0
   .db #2
   .db #0
   .db #1
   .db #2
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
   call sysInputUpdate
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
;;
manGameCreator:

   push hl

   call manEntityCreate  

   ex de, hl
   pop hl
   ld bc, #EntitySize

   call cpct_memcpy_asm

ret

manGameCreatorBala::

   ld iy, #initBala

   ld a, indY(ix)
   ld indY(iy), a

   ld hl, #initBala

   call manGameCreator

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