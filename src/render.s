.include "cpctelera.h.s"
.globl cpct_getScreenPtr_asm
.globl cpct_setVideoMode_asm
.globl cpct_setPALColour_asm
.globl manEntityForAll

sysRenderInit:

    ld c, #0
   call cpct_setVideoMode_asm

   cpctm_setBorder_asm HW_BLACK

   ld l, #0
   ld h, #HW_BLACK
   call cpct_setPALColour_asm

ret

sysRenderUpdateOne:
    pop hl

    ld bc, #5
    add hl, bc  ;;prevPos1

    ld e, (hl)
    inc hl      ;;prevPos2
    ld d, (hl)

    dec hl  ;;prevPos1
    dec hl  ;;color
    dec hl  ;;vx
    dec hl  ;;y
    dec hl  ;;x
    dec hl  ;;tipo

    push hl

    ld h, d
    ld l, e
    ld (hl), #0

    pop hl

    ld de, #0xc000

    inc hl      ;;x
    ld c, (hl)

    inc hl      ;;y
    ld b, (hl)

    inc hl      ;;vx
    inc hl      ;;color
    ld a, (hl)

    push hl
    push af

    call cpct_getScreenPtr_asm

    pop af
    
    ld (hl), a  ;; Se carga el color en la memoria de video
    ld d, h
    ld e, l

    pop hl

    inc hl      ;;prevPos1
    ld (hl), e
    inc hl      ;;prevPos2
    ld (hl), d



    dec hl  ;;prevPos1
    dec hl  ;;color
    dec hl  ;;vx
    dec hl  ;;y
    dec hl  ;;x
    dec hl  ;;tipo

ret

sysRenderUpdate::

    ld hl, #sysRenderUpdateOne
    call manEntityForAll

ret
