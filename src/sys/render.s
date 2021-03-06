;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of Cosmic Gatlin: An Amstrad CPC Game 
;;  Authors: 
;;      Javier Botella Martínez (@javierbotella)
;;      Francesc Martinez Torregrosa (@mellamofrancesc)
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;------------------------------------------------------------------------------

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
.globl _myDrawCharM0
.globl cpct_setDrawCharM0_asm

ptrScreenScore1:
    .dw #0
ptrScreenScore2:
    .dw #0
ptrScreenScore3:
    .dw #0
ptrScreenScore4:
    .dw #0

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

    ld hl, #0x000f
    call cpct_setDrawCharM0_asm

    cpctm_clearScreen_asm 0

   ld de, #0xc000
   ld c, #41
   ld b, #185

   call cpct_getScreenPtr_asm

   ld (ptrScreenScore1), hl

   ld bc, #4
   add hl, bc

   ld (ptrScreenScore2), hl

   ld bc, #4
   add hl, bc

   ld (ptrScreenScore3), hl

   ld bc, #4
   add hl, bc

   ld (ptrScreenScore4), hl

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysRenderInit
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inicializa el render
sysRenderInitMenu::

    ld de, #0xc000
    ld c, #57
    ld b, #90

    call cpct_getScreenPtr_asm

    ld (ptrScreenScore1), hl

    ld bc, #4
    add hl, bc

    ld (ptrScreenScore2), hl

    ld bc, #4
    add hl, bc

    ld (ptrScreenScore3), hl

    ld bc, #4
    add hl, bc

    ld (ptrScreenScore4), hl

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
;; sysRenderDrawOnce
;; Requisitos:
;;    hl -> score to print
;; Return:
;;    -
;; Descripcion:
;;    Draw the score in the screen
sysRenderScore::

    ld b, h
    ld c, l
    
    ld a, b
    rra
    rra
    rra
    rra
    and #0x0F
    add #48


    ld e, a
    ld hl, (#ptrScreenScore1)

    push bc
    push ix
    call _myDrawCharM0
    pop ix
    pop bc


    ld a, b
    and #0x0F
    add #48

    ld e, a
    ld hl, (#ptrScreenScore2)
    push bc
    push ix
    call _myDrawCharM0
    pop ix
    pop bc


    ld a, c
    rra
    rra
    rra
    rra
    and #0x0F
    add #48

    ld e, a
    ld hl, (#ptrScreenScore3)
    push bc
    push ix
    call _myDrawCharM0
    pop ix
    pop bc


    ld a, c
    and #0x0F
    add #48

    ld e, a
    ld hl, (#ptrScreenScore4)
    push bc
    push ix
    call _myDrawCharM0
    pop ix
    pop bc

ret

sysRenderGameOverCount::

    push af

    ld de, #0xc000
    ld c, #38
    ld b, #80

    call cpct_getScreenPtr_asm

    pop af

    and #0x0F
    add #48

    ld e, a
    call _myDrawCharM0

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
    ld c, indDelWitdh(ix)
    ld b, indDelHeight(ix)

    call cpct_drawSolidBox_asm

ret
