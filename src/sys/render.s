.include "cpctelera.h.s"
.include "render.h.s"
.include "../man/entity.h.s"

.globl cpct_getScreenPtr_asm
.globl cpct_setVideoMode_asm
.globl cpct_setPALColour_asm

.globl _main_palette
.globl cpct_setPalette_asm

.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm
.globl cpct_drawSprite_asm



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysRenderInit
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inicializa el render
sysRenderInit::

    ld c, #0
    call cpct_setVideoMode_asm

    cpctm_setBorder_asm HW_BLACK

    ld l, #0
    ld h, #HW_BLACK
    call cpct_setPALColour_asm

    ld   hl, #_main_palette
    ld   de, #16
    call cpct_setPalette_asm

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysRenderUpdateOne
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Dibuja los objetos dibujables como cajas. Además borra su posicion anterior
sysRenderUpdateOne::

    ld a, indSubType(ix)
    ld b, #RenderTypeStatic
    and b

    jp nz, noBorrado

    call sysRenderBorrado

    noBorrado:
    ld de, #0xc000
    ld c, indX(ix)
    ld b, indY(ix)

    call cpct_getScreenPtr_asm

    ld indPrevPos1(ix), h
    ld indPrevPos2(ix), l

    ex de, hl
    ld h, indSprite1(ix)
    ld l, indSprite2(ix)
    ld c, indWidth(ix)
    ld b, indHeight(ix)

    call cpct_drawSprite_asm

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysRenderUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para el dibujado de todas las entidades.
sysRenderUpdate::

    ld hl, #sysRenderUpdateOne
    ld a, #ETypeRenderable
    call manEntityForAll

ret

sysRenderBorrado::

    ld d, indPrevPos1(ix)
    ld e, indPrevPos2(ix)
    ld a, #0
    ld c, indWidth(ix)
    ld b, indHeight(ix)

    call cpct_drawSolidBox_asm

ret
