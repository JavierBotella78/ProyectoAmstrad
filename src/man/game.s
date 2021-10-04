.include "cpctelera.h.s"
.include "../entityInfo.s"

.globl cpct_waitVSYNC_asm
.globl cpct_memcpy_asm

.globl sysInputUpdate
.globl sysPhysicsUpdate
.globl sysRenderUpdate
.globl sysColisionsUpdate

.globl manEntityCreate
.globl manEntityDestroyDead

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
   .db #ETypeRenderable | #ETypeAI | #ETypeMovable | #ETypeColisionable   
   .db #60
   .db #10
   .db #0
   .db #0
   .db #2
   .db #8
   .db #0xff
   .dw #0xc000


initBala:
   .db #ETypeRenderable | #ETypeBullet | #ETypeMovable    
   .db #13
   .db #0
   .db #2
   .db #0
   .db #1
   .db #2
   .db #0xff
   .dw #0xc000


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