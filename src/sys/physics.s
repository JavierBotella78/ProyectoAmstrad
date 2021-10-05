.include "../entityInfo.s"

.globl manEntityMarkToDestroy
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

        ;; Mover x

    ld a, indX(ix)
    ld b, indVx(ix)
    add a, b

    jp c, destroy       ;; Si sale por la izq, se marca para destruir

    push af
    ld a, #80
    pop de  
    cp d

    jp c, destroy       ;; Si sale por la der, se marca para destruir

    ld indX(ix), d

        ;; Mover y

    ld a, indY(ix)
    ld b, indVy(ix)
    add a, b

    ld c, #200

    ;; a = y + vy

    ;;  Por arriba
    
    cp c
    
    jp nc, salirSysPhysicsUpdateOne
    

    ;; TODO: Comprobar que no se salga de pantalla en la y

    ld indY(ix), a

    jp salirSysPhysicsUpdateOne

destroy:

    call manEntityMarkToDestroy

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
    ld a, #ETypeMovable
    call manEntityForAll

ret