.include "cpctelera.h.s"
.include "render.h.s"
.include "../man/entity.h.s"

.globl cpct_setVideoMode_asm
.globl cpct_setPALColour_asm

.globl _main_palette
.globl cpct_setPalette_asm

.globl cpct_drawSolidBox_asm
.globl cpct_drawSprite_asm
.globl cpct_getScreenPtr_asm
.globl cpct_drawSpriteMaskedAlignedTable_asm


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

    ld h, indActualPos1(ix)
    ld l, indActualPos2(ix)
    ex de, hl

    ;;ld b, indSprite1(ix)
    ;;ld c, indSprite2(ix)
;;
    
;;
    ;;ld hl, #0	
;;
    ;;ld a, indWidth(ix)
    ;;ld__ixl_a
;;
    ;;ld a, indHeight(ix)
    ;;ld__ixh_a
;;
    ;;call cpct_drawSpriteMaskedAlignedTable_asm
    
    ld h, indSprite1(ix)
    ld l, indSprite2(ix)
    ld c, indWidth(ix)
    ld b, indHeight(ix)

    call cpct_drawSprite_asm
    

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysRenderDrawOnce
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Dibuja los objetos dibujables como cajas. Además borra su posicion anterior
sysRenderDrawOnce::

    ld de, #0xc000
    ld c, indX(ix)
    ld b, indY(ix)

    call cpct_getScreenPtr_asm

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
