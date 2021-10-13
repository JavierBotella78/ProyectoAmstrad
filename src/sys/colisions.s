
.include "colisions.h.s"
.include "generator.h.s"
.include "../man/entity.h.s"
.include "../man/game.h.s"



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

    push af

    ld a, indX(ix)      ;; x de la bala
    ld b, indWidth(ix)
    add a, b

    ld b, a

    pop af
    cp b

    ret nc ;; No hay carry-> x de la bala < x del colisionable  

    inc a
    ld c, indWidth(iy)
    add a, c

    ld b, indX(ix)      ;; x de la bala
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

    ld a, indSubType(iy)
    
    call sysColisionsBehaviour

    ld a, indSubType(ix)

    push ix         ;; Switch ix and iy
    push iy
    pop ix
    
    call sysColisionsBehaviour

    push ix         ;; Switch ix and iy again
    pop iy
    pop ix

ret


sysColisionsBehaviour:

    ld h, indColision1(ix)
    ld l, indColision2(ix)

    ld bc, #salirColision
    push bc

    jp (hl)

    salirColision:

ret

sysColisionsDestroy:

    call manEntityMarkToDestroy

ret

sysColisionsEnemy:

    call sysGeneratorPU
    call manEntityMarkToDestroy
    call manGameScore

ret

sysColisionsPlayer:

    ld b, #AITypeEnemy
    and b

    ret z           ;; Si es un enemigo, llama a la funcion

    call manGamePlayerColision

ret

sysColisionsBullet:

    ld b, #AITypePU
    and b

    ret nz       ;; Si es un power-up, NO llama a la funcion

    call sysColisionsDestroy

ret

sysColisionPUScore:

    ld b, #AITypeBullet
    and b

    ret nz       ;; Si es una bala, NO llama a la funcion

    call manGamePUScoreColision
    call manEntityMarkToDestroy

ret

sysColisionPUBullet:

    ld b, #AITypeBullet
    and b

    ret nz       ;; Si es una bala, NO llama a la funcion

    call manGamePUBulletColision
    call manEntityMarkToDestroy

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
    ld a, #ETypeColider
    ld b, #ETypeColisionable
    call manEntityForAllMatching

ret