.include "cpctelera.h.s"
.include "entityInfo.s"

.globl manEntityForAll
.globl manGameCreatorBala

.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysInputUpdateOne
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Modifica la vx y/o vy de las entidades si se ha pulsado un boton 
sysInputUpdateOne:

    ld a, indType(ix)      ;; tipo de la entidad
    ld b, #ETypeInput
    and b

    jr z, salirSysInputUpdateOne ;; si invalido, salir

    ld indVy(ix), #0

    call cpct_scanKeyboard_asm

    ld hl, #Key_S
    call cpct_isKeyPressed_asm

    jr nz, sPulsada
    
    ld hl, #Key_W
    call cpct_isKeyPressed_asm

    jr nz, wPulsada

    ld hl, #Key_K
    call cpct_isKeyPressed_asm

    jr nz, kPulsada

    jp salirSysInputUpdateOne

wPulsada:

    ld indVy(ix), #-4

    jp salirSysInputUpdateOne

kPulsada:

    call manGameCreatorBala

    jp salirSysInputUpdateOne

sPulsada:

    ld indVy(ix), #4

salirSysInputUpdateOne:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysPhysicsUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la modificacion de posicion de todas las entidades.
sysInputUpdate::

    ld hl, #sysInputUpdateOne
    call manEntityForAll

ret