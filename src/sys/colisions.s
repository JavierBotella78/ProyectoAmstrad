
.include "colisions.h.s"
.include "../man/entity.h.s"



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysColisionsUpdateOne
;; Requisitos:
;;      ix -> Posicion inicial de memoria de la entidad colisionable
;;      iy -> Posicion inicial de memoria de la entidad bala
;; Return:
;;    -
;; Descripcion:
;;    Comprueba si dos entidades han colisionado o no
;;
sysColisionsUpdateOne:

    ;; x dentro de rango?

    ld a, indX(iy)      ;; x del colisionable
    dec a
    ld b, indX(ix)      ;; x de la bala
    cp b

    ret nc ;; No hay carry-> x de la bala < x del colisionable  

    inc a
    ld c, indWidth(iy)
    add a, c

    cp b

    ret c ;; No hay carry-> x + width de colisionable < x de la bala


    ;; y dentro de rango?

    ld a, indY(iy)      ;; y del colisionable
    dec a
    ld b, indY(ix)      ;; y de la bala
    cp b

    ret nc ;; No hay carry-> y de la bala < y del colisionable  

    inc a
    ld c, indHeight(iy)
    add a, c

    cp b

    ret c ;; No hay carry-> x + width de colisionable < x de la bala

        ;;TODO: Hacer una beheaviour como en la ia, al colisionar pues pasan cosas
    call manEntityMarkToDestroy

    push ix

    push iy
    pop ix
    
    call manEntityMarkToDestroy

    push ix
    pop iy
    
    pop ix

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
    ld b, #ETypeColisionable
    call manEntityForAllMatching

ret