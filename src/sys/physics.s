.include "physics.h.s"
.include "../man/entity.h.s"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysPhysicsUpdateOne
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Modifica las entidades que son movibles segun su vx y vy
sysPhysicsUpdateOne:

        ;; Mover x

    ld a, indX(ix)
    ld b, indVx(ix)
    add a, b

    push af
    ld a, #MaxX
    pop de  
    cp d

    jp c, destroy       ;; Si sale por la der, se marca para destruir

    ld indX(ix), d

        ;; Mover y

    ld a, indY(ix)
    ld b, indVy(ix)
    add a, b

    ld c, #MaxY

    ;; a = y + vy

    ;;  Por arriba
    
    dec a
    cp c
    
    ret nc
 
    inc a
    ld indY(ix), a

    ret

destroy:

    ld h, indPhysics1(ix)
    ld l, indPhysics2(ix)
    
    ld bc, #salirPhysics
    push bc

    jp (hl)

    salirPhysics:

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
    ld a, #ETypeMovable
    call manEntityForAll

ret