.include "../entityInfo.s"

.globl manEntityDestroy
.globl manEntityForAll


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysColisionsUpdateOne
;; Requisitos:
;;      ix -> Posicion inicial de memoria de la entidad bala
;;      iy -> Posicion inicial de memoria de la entidad colisionable
;; Return:
;;    -
;; Descripcion:
;;    Comprueba si dos entidades han colisionado o no
sysColisionsUpdateOne:

;; TODO
;; Comprobar que las entidades colisionables chocan con la bala
;;
;; Un bucle que recorra el array de entidades 
;; mediante x, y, width y height, comprobar si han chocado
;; Si chocan, se marcan ambos para destruir y se termina el bucle

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
    ld a, #ETypeBullet
    call manEntityForAll

ret