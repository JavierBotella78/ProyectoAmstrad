.include "entityInfo.s"

.globl manEntityDestroy
.globl manEntityForAll


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysColisionsUpdateOne
;; Requisitos:
;;      ix -> Posicion inicial de memoria de la entidad 1
;;      iy -> Posicion inicial de memoria de la entidad 2
;; Return:
;;    -
;; Descripcion:
;;    Comprueba si dos entidades han colisionado o no
sysColisionsUpdateOne:


salirSysColisionsUpdateOne:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysColisionsUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la colision de todas las entidades.
sysColisionsUpdate::

    ld hl, #sysColisionsUpdateOne
    call manEntityForAll

ret