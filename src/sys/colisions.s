.include "../entityInfo.s"

.globl manEntityDestroy
.globl manEntityForAll
.globl manEntityMarkToDestroy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsUpdateOne
;; Requisitos:
;;      ix -> Posicion inicial de memoria de la entidad bala
;; Return:
;;    -
;; Descripcion:
;;    Hace de puente para comprobar las colisiones
;;
sysColisionsUpdateOne:



    push ix
    pop iy

    ld hl, #sysColisionComprobarColision
    ld a, #ETypeColisionable
    call manEntityForAll

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionComprobarColision
;; Requisitos:
;;      ix -> Posicion inicial de memoria de la entidad colisionable
;;      iy -> Posicion inicial de memoria de la entidad bala
;; Return:
;;    -
;; Descripcion:
;;    Comprueba si dos entidades han colisionado o no
;;
sysColisionComprobarColision:

    ;; x dentro de rango?

    ld a, indX(ix)      ;; x del colisionable
    dec a
    ld b, indX(iy)      ;; x de la bala
    cp b

    jp nc, finSysColisionComprobarColision ;; No hay carry-> x de la bala < x del colisionable  

    inc a
    ld c, indWidth(ix)
    add a, c

    cp b

    jp c, finSysColisionComprobarColision ;; No hay carry-> x + width de colisionable < x de la bala


    ;; y dentro de rango?

    ld a, indY(ix)      ;; y del colisionable
    dec a
    ld b, indY(iy)      ;; y de la bala
    cp b

    jp nc, finSysColisionComprobarColision ;; No hay carry-> y de la bala < y del colisionable  

    inc a
    ld c, indHeight(ix)
    add a, c

    cp b

    jp c, finSysColisionComprobarColision ;; No hay carry-> x + width de colisionable < x de la bala

    call manEntityMarkToDestroy

    push iy
    pop ix
    
    call manEntityMarkToDestroy


finSysColisionComprobarColision:
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysColisionsUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la colision de todas las entidades.
;;
sysColisionsUpdate::

    ld hl, #sysColisionsUpdateOne
    ld a, #ETypeBullet
    call manEntityForAll

ret