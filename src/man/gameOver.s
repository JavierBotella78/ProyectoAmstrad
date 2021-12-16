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

.include "gameOver.h.s"
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

.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm

gameOverCoin:
    .db #0

boolGameOverLoop:
    .db #0

gameOverCount:
    .db #9

gameOverSubCount:
    .dw #0

softResetJump:
    .dw #0

gameOverTimer:
    .dw #0

blinkGameOverTimer:
    .dw #0

boolGameOverBlink:
    .db #1


manGameOverInit::

    ld (softResetJump), hl

    ld a, #0
    ld (gameOverCoin), a

    ld a, #0
    ld (boolGameOverLoop), a

    ld a, #9
    ld (gameOverCount), a

    ld hl, #KGOSUBCOUNT
    ld (gameOverSubCount), hl

    ld hl, #KGOTIMER
    ld (#gameOverTimer), hl

    ld hl, #KBLINKGOTIMER
    ld (#blinkGameOverTimer), hl

    ld a, #1
    ld (#boolGameOverBlink), a

    call manGameGetScoreWin

    or a
    
    jp nz, skipGameOverGen

    call sysGeneratorInitGameOver

    ld a, (#gameOverCount)
    call sysRenderGameOverCount

    ret

skipGameOverGen:

    call sysGeneratorInitYouWin

ret



manGameOverLoop::

    call manGameGetScoreWin

    or a
    
    jp nz, manGameOverLoop2

    call manGameOverCheckInput
    call manGameOverUpdate

    loopGOBlink:
    ld a, (#numI)
    cp #1
    jr nz, loopGOBlink
    call manGameOverCheckBlink

    call waitHalt
    

    ld a, (#boolGameOverLoop)
    or a
    
    jp z, manGameOverLoop

    ld a, #0
    ld (boolGameOverLoop), a

    call sysGeneratorInitGameOver2

manGameOverLoop2:
    call waitHalt

    call manGameOverCheckInput2

    ld hl, (#gameOverTimer)
    dec hl
    ld (gameOverTimer), hl

    ld a, h
    or a

    jp nz, skipGameOverTimer

    ld a, l
    or a

    jp nz, skipGameOverTimer

    ld a, #1
    ld (boolGameOverLoop), a

skipGameOverTimer:

    ld a, (#boolGameOverLoop)
    or a

    jp z, manGameOverLoop2

ret

manGameOverUpdate:

    ld hl, (#gameOverSubCount)
    dec hl
    ld (gameOverSubCount), hl

    ld a, h
    or a
    
    ret nz

    ld a, l
    or a

    ret nz

    ;; Reset gameOverSubCount

    ld hl, #KGOSUBCOUNT
    ld (gameOverSubCount), hl

    ld a, (#gameOverCount)
    or a
    
    jp z, finishGameOver

    dec a
    ld (gameOverCount), a
    
    call sysRenderGameOverCount

    ret

    finishGameOver:

    ld a, #1
    ld (boolGameOverLoop), a

ret



manGameOverCheckInput:

    call cpct_scanKeyboard_asm

    ld hl, #Key_C
    call cpct_isKeyPressed_asm

    jr nz, cGameOverPulsada

    ret

cGameOverPulsada:

    ld a, (#gameOverCoin)
    dec a
    ld (gameOverCoin), a

    ld hl, (#softResetJump)
    jp (hl)

ret




manGameOverCheckInput2:

    call cpct_scanKeyboard_asm

    ld hl, #Key_Space
    call cpct_isKeyPressed_asm

    jr nz, pGameOverPulsada

    ret

pGameOverPulsada:

    ld a, #1
    ld (boolGameOverLoop), a

ret



manGameOverCheckBlink:

    ld hl, (#blinkGameOverTimer)
    dec hl
    ld (blinkGameOverTimer), hl

    ld a, h
    or a

    ret nz

    ld a, l
    or a

    ret nz

    ld a, (#boolGameOverBlink)
    or a

    jp z, blinkGameOverDraw

    ld hl, #KBLINKGOTIMER2
    ld (blinkGameOverTimer), hl

    ld a, #0
    ld (boolGameOverBlink), a

    call sysGeneratorMenuErase

    ret

blinkGameOverDraw:

    ld hl, #KBLINKGOTIMER
    ld (blinkGameOverTimer), hl


    ld a, #1
    ld (boolGameOverBlink), a

    ld a, (#gameOverCoin)
    or a

    jp z, blinkGameOverDrawInsert

    call sysGeneratorMenuSpace

    ret

blinkGameOverDrawInsert:

    call sysGeneratorMenuInsertCoin

ret