.include "cpctelera.h.s"
.include "../entityInfo.s"

.globl manEntityForAll
.globl manGameBulletCreator

.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm

ConstDelayMovement=4

inputSpeed=40

delayMovement:
    .db #ConstDelayMovement    ;; frames


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      UpdateOne
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Modifica la vx y/o vy de las entidades si se ha pulsado un boton 
;;
sysInputUpdateOne:

    ld indVy(ix), #0

    call cpct_scanKeyboard_asm


    ld a, (#delayMovement)
    or a

    jr z, comprobarTeclas

    dec a
    ld (delayMovement), a
    
    jr nz, seguirComprobando

comprobarTeclas:


    ld hl, #Key_S
    call cpct_isKeyPressed_asm

    jr nz, sPulsada
    
    ld hl, #Key_W
    call cpct_isKeyPressed_asm

    jr nz, wPulsada

    jp seguirComprobando

wPulsada:

    ld indVy(ix), #-inputSpeed
    ld a, #ConstDelayMovement
    ld (delayMovement), a

    jp seguirComprobando

sPulsada:

    ld indVy(ix), #inputSpeed
    ld a, #ConstDelayMovement
    ld (delayMovement), a

    jp seguirComprobando

kPulsada:

    call manGameBulletCreator

    jp salirSysInputUpdateOne

seguirComprobando:

    ld hl, #Key_K
    call cpct_isKeyPressed_asm

    jr nz, kPulsada

salirSysInputUpdateOne:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Update
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la modificacion de posicion de todas las entidades.
sysInputUpdate::

    ld hl, #sysInputUpdateOne
    ld a, #ETypeInput
    call manEntityForAll

ret