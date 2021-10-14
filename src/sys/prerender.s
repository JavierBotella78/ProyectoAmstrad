.include "cpctelera.h.s"
.include "render.h.s"
.include "../man/entity.h.s"

.globl cpct_getScreenPtr_asm


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysRenderUpdateOne
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Dibuja los objetos dibujables como cajas. Además borra su posicion anterior
sysPreRenderUpdateOne::


    ld h, indActualPos1(ix) 
    ld l, indActualPos2(ix)

    ld indPrevPos1(ix), h
    ld indPrevPos2(ix), l

    ld de, #0xc000
    ld c, indX(ix)
    ld b, indY(ix)

    call cpct_getScreenPtr_asm


    ld indActualPos1(ix), h
    ld indActualPos2(ix), l

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysPreRenderUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para el dibujado de todas las entidades.
sysPreRenderUpdate::

    ld hl, #sysPreRenderUpdateOne
    ld a, #ETypeRenderable
    call manEntityForAll

ret

