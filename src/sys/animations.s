.include "generator.h.s"
.include "animations.h.s"
.include "../man/entity.h.s"
.include "../man/game.h.s"


animationEnemy1:
    .db #5                  ;;actual=0
    .dw #_spr_drone
    .db #5                  ;;actual=3
    .dw #_spr_drone2
    .db #0
    .dw #animationEnemy1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAnimationsUpdateOne
;; Requisitos:
;;      ix -> Posicion inicial de memoria de la entidad colisionable
;; Return:
;;    -
;; Descripcion:
;;    Comprueba si dos entidades han colisionado o no
;;
sysAnimationsUpdateOne:

    dec indAnimCounter(ix)
    
    ret nz 

    ld a, indAnimActual(ix)
    ld b, #AnimSize
    add a, b
    ld indAnimActual(ix), a

loadAnim:

    ld h, indAnim1(ix)
    ld l, indAnim2(ix)
    ld b, #0
    ld c, indAnimActual(ix)

    add hl, bc      ;; hl=nextSprite

    ld a, (hl)
    or a
    
    jp z, resetAnim

    ld indAnimCounter(ix), a

    inc hl
    ld a, (hl)
    ld indSprite2(ix), a
    inc hl
    ld a, (hl)
    ld indSprite1(ix), a

    ret

resetAnim:

    ld indAnimActual(ix), #0
    jp loadAnim


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysAnimationsUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la colision de todas las entidades.
;;
sysAnimationsUpdate::

    ld hl, #sysAnimationsUpdateOne
    ld a, #ETypeAnimated
    call manEntityForAll

ret