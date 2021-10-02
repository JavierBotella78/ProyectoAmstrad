.include "entityInfo.s"

.globl manEntityDestroy
.globl manEntityForAll


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysPhysicsUpdateOne
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Modifica las entidades que son movibles segun su vx y vy
sysPhysicsUpdateOne:

    ld a, indType(ix)      ;; tipo de la entidad
    ld b, #ETypeMovable
    and b

    jr z, salirSysPhysicsUpdateOne ;; si invalido, salir

    ld a, indX(ix)
    ld b, indVx(ix)
    add a, b
    ld indX(ix), a

    ld a, indY(ix)
    ld b, indVy(ix)
    add a, b
    ld indY(ix), a

salirSysPhysicsUpdateOne:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysPhysicsUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la modificacion de posicion de todas las entidades.
sysPhysicsUpdate::

    ld hl, #sysPhysicsUpdateOne
    call manEntityForAll

ret