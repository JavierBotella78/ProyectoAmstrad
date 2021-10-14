.include "ai.h.s"
.include "../man/entity.h.s"


speedAILeft::
    .db #-1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      UpdateOne
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Modifica las entidades que son movibles segun su vx y vy
sysAIUpdateOne:

    ld h, indAI1(ix)
    ld l, indAI2(ix)

    ld bc, #salirAI
    push bc

    jp (hl)

    salirAI:

ret

sysAIMoveLeft:

    ld a, (#speedAILeft)
    ld indVx(ix), a
    
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysPhysicsUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la modificacion de posicion de todas las entidades.
sysAIUpdate::

    ld hl, #sysAIUpdateOne
    ld a, #ETypeAI
    call manEntityForAll

ret