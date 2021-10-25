.include "cpctelera.h.s"

.include "gameOver.h.s"
.include "entity.h.s"
.include "interruptions.h.s"

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
    .dw #4000

softResetJump:
    .dw #0

gameOverTimer:
    .dw #20000


manGameOverInit::

    ld (softResetJump), hl

    ld a, #0
    ld (gameOverCoin), a

    ld a, #0
    ld (boolGameOverLoop), a

    ld a, #9
    ld (gameOverCount), a

    ld hl, #4000
    ld (gameOverSubCount), hl

    ld hl, #20000
    ld (#gameOverTimer), hl

    call sysGeneratorInitGameOver

    ld a, (#gameOverCount)
    call sysRenderGameOverCount
    call sysPreRenderUpdate

ret



manGameOverLoop::

    call manGameOverCheckInput
    call manGameOverUpdate

    ld a, (#boolGameOverLoop)
    or a
    
    jp z, manGameOverLoop

    ld a, #0
    ld (boolGameOverLoop), a

    call sysGeneratorInitGameOver2

manGameOverLoop2:

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

    ld hl, #4000
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

    ld hl, #Key_Space
    call cpct_isKeyPressed_asm

    jr nz, spaceGameOverPulsada

    ret

cGameOverPulsada:

    ld a, (#gameOverCoin)
    or a
    
    ret nz

    inc a
    ld (#gameOverCoin), a

    ret

spaceGameOverPulsada:

    ld a, (#gameOverCoin)
    or a
    
    ret z

    ld a, (#gameOverCoin)
    dec a
    ld (gameOverCoin), a

    ld hl, (#softResetJump)
    jp (hl)

ret




manGameOverCheckInput2:

    call cpct_scanKeyboard_asm

    ld hl, #Key_P
    call cpct_isKeyPressed_asm

    jr nz, pGameOverPulsada

    ret

pGameOverPulsada:

    ld a, #1
    ld (boolGameOverLoop), a

ret

