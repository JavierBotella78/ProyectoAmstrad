.include "cpctelera.h.s"
.include "input.h.s"
.include "render.h.s"

.include "../man/game.h.s"
.include "../man/entity.h.s"

.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

delayMovement:
    .db #ConstDelayMovement    ;; frames

changeRenderable::
    .db #0

playerY:
    .db #0

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

    call sysInputChangeRenderable
    call sysInputChangeAnimation

    ld indVy(ix), #0

    call cpct_scanKeyboard_asm


    ld a, (#delayMovement)
    or a

    jr z, comprobarTeclas

    dec a
    ld (delayMovement), a
    
    jr nz, seguirComprobando

comprobarTeclas:


    ld hl, #Key_A
    call cpct_isKeyPressed_asm

    jr nz, sPulsada
    
    ld hl, #Key_Q
    call cpct_isKeyPressed_asm

    jr nz, wPulsada

    jp seguirComprobando

wPulsada:

    ld indVy(ix), #-inputSpeed
    ld a, #ConstDelayMovement
    ld (delayMovement), a

    ld a, (#playerY)
    or a
    
    jp z, seguirComprobando

    dec a
    ld (playerY), a

    jp seguirComprobando

sPulsada:

    ld indVy(ix), #inputSpeed
    ld a, #ConstDelayMovement
    ld (delayMovement), a

    ld a, (#playerY)
    ld b, #2
    cp b
    
    jp z, seguirComprobando

    inc a
    ld (playerY), a

    jp seguirComprobando

kPulsada:

    call manGameBulletCreator

    ret

seguirComprobando:

    ld hl, #Key_P
    call cpct_isKeyPressed_asm

    jr nz, kPulsada

ret

sysInputChangeRenderable:

    ld a, (#changeRenderable)
    or a
    
    ret z

    ld a, #0
    ld (changeRenderable), a

    ld a, indType(ix)
    ld b, #ETypeRenderable
    xor b
    ld indType(ix), a

    call sysRenderBorrado

ret

sysInputChangeAnimation:

;; Comprobar que sea 0 1 o 2 y cambiar la animacion

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