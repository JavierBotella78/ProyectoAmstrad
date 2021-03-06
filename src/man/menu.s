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

.include "menu.h.s"
.include "entity.h.s"
.include "interruptions.h.s"
.include "game.h.s"

.include "../sys/render.h.s"
.include "../sys/prerender.h.s"
.include "../sys/colisions.h.s"
.include "../sys/input.h.s"
.include "../sys/physics.h.s"
.include "../sys/ai.h.s"
.include "../sys/generator.h.s"
.include "../sys/animations.h.s"

.include "../banger2.h.s"

.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm

.globl cpct_akp_musicInit_asm
.globl cpct_akp_musicPlay_asm
.globl cpct_akp_stop_asm

menuCoin:
    .db #0

boolMenuLoop:
    .db #0

controlsTimer:
    .dw #0

blinkMenuTimer:
    .dw #0

boolMenuBlink:
    .db #1

manMenuInit::

    ld a, #0
    ld (#boolMenuLoop), a

    ld a, #0
    ld (#menuCoin), a

    ld hl, #KCONTROLSTIMER
    ld (#controlsTimer), hl

    ld hl, #KBLINKMENUTIMER
    ld (#blinkMenuTimer), hl

    ld a, #1
    ld (#boolMenuBlink), a

    call sysRenderInit 
    call sysRenderInitMenu
    call sysGeneratorInitMenu

    ld de, #_cancion2
    call cpct_akp_musicInit_asm

ret



manMenuLoop::

    call manMenuCheckInput

loopMenuBlink:
    ld a, (#numI)
    cp #1
    jr nz, loopMenuBlink
    call manMenuCheckBlink

    call cpct_akp_musicPlay_asm


    call waitHalt


    ld a, (#boolMenuLoop)
    or a
    
    jp z, manMenuLoop

    ld a, #0
    ld (boolMenuLoop), a

    call cpct_akp_stop_asm

    call sysGeneratorInitMenu2

manMenuLoop2:

    call waitHalt

    call manMenuCheckInput2
    

    ld hl, (#controlsTimer)
    dec hl
    ld (controlsTimer), hl

    ld a, h
    or a

    jp nz, skipControlTimer

    ld a, l
    or a

    jp nz, skipControlTimer

    ld a, #1
    ld (boolMenuLoop), a

skipControlTimer:

    ld a, (#boolMenuLoop)
    or a

    jp z, manMenuLoop2

ret



manMenuCheckInput:

    call cpct_scanKeyboard_asm

    ld hl, #Key_C
    call cpct_isKeyPressed_asm
   
   

    jr nz, cMenuPulsada
    
    ld hl, #Key_Space
    call cpct_isKeyPressed_asm

    jr nz, enterMenuPulsada

   

    ret

cMenuPulsada:

    ld a, (#menuCoin)
    or a
    
    ret nz

    inc a
    ld (#menuCoin), a

    call sysGeneratorInitMenuCredit
    

    ret

enterMenuPulsada:

    ld a, (#menuCoin)
    or a
    
    ret z

    ld a, (#menuCoin)
    dec a
    ld (menuCoin), a

    ld a, #1
    ld (boolMenuLoop), a

ret



manMenuCheckInput2:

    call cpct_scanKeyboard_asm

    ld hl, #Key_P
    call cpct_isKeyPressed_asm

    jr nz, pMenuPulsada

    ret

pMenuPulsada:

    ld a, #1
    ld (boolMenuLoop), a

ret



manMenuCheckBlink:

    ld hl, (#blinkMenuTimer)
    dec hl
    ld (blinkMenuTimer), hl

    ld a, h
    or a

    ret nz

    ld a, l
    or a

    ret nz

    ld a, (#boolMenuBlink)
    or a

    jp z, blinkMenuDraw

    ld hl, #KBLINKMENUTIMER2
    ld (blinkMenuTimer), hl

    ld a, #0
    ld (boolMenuBlink), a

    call sysGeneratorMenuErase


    ret

blinkMenuDraw:

    ld hl, #KBLINKMENUTIMER
    ld (blinkMenuTimer), hl


    ld a, #1
    ld (boolMenuBlink), a

    ld a, (#menuCoin)
    or a

    jp z, blinkMenuDrawInsert

    call sysGeneratorMenuSpace

    ret

blinkMenuDrawInsert:

    call sysGeneratorMenuInsertCoin

ret

