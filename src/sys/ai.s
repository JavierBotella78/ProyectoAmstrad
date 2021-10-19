.include "ai.h.s"
.include "../man/entity.h.s"
.include "generator.h.s"


speedAILeft::
    .db #-1

aiCounter::
    .db #1

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

sysAIMoveLeft::

    ld a, (#speedAILeft)
    ld indVx(ix), a
    
ret

sysAIEnemy:

    ld indVx(ix), #0
    call sysAICheckCounter

ret

sysAIEnemy1::

    call sysAIEnemy

ret

sysAIEnemy2::

    call sysAIEnemy

ret

sysAIEnemy3::

    call sysAIEnemy

ret

sysAICheckCounter:

    ld a, indAICounter(ix)
    or a
        
    jp z, resetAICounter
 
    dec indAICounter(ix)

    ret 

resetAICounter:

    ld a, (#aiCounter)
    ld indAICounter(ix), a

    call sysAIMoveLeft

ret


sysAIExplosion::

    ld a, indAICounter(ix)
    dec a

    jp z, sysAIExplosionDestroy

    ld indAICounter(ix), a

    ret

sysAIExplosionDestroy:

    call manEntityMarkToDestroy
    call sysGeneratorPU

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