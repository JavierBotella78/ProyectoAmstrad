
.globl manEntityCreate
.globl getFreeSpace

.globl cpct_getRandom_mxor_u8_asm
.globl cpct_memcpy_asm

initE: ;; entity constante para copias
.db #1      ;; type
.db #79     ;; x
.db #1      ;; y  
.db #-1     ;; vx
.db #0xff   ;; color
.dw #0xc000 ;; prevPos

posicionCrearG:
   .ds 2

sysGeneratorUpdate::

    call getFreeSpace
    ld a, h

    or l
    
    jp z, salirGen

    call manEntityCreate

    ld (posicionCrearG), hl

    ld d, h
    ld e, l

    ld hl, #initE

    ld bc, #7
    
    call cpct_memcpy_asm

    ld hl, (#posicionCrearG)

    inc hl   ;; x
    inc hl   ;; y

    ld (posicionCrearG), hl

    call cpct_getRandom_mxor_u8_asm

    ld a, l
    ld c, a
    ld b, #0x80

    and b

    jr z, valido

    ld a, c
    ld b, #0x40

    and b

    jr z, valido

    ld a, c
    ld b, #0xc7

    and b
    jp validoTotal

valido:
    ld a, c

validoTotal:
    ld hl, (#posicionCrearG)
    ld (hl), a

    inc hl   ;; vx

    ld (posicionCrearG), hl

    call cpct_getRandom_mxor_u8_asm

    ld a, l
    ld b, #0x03

    and b ;; 0-3
    ld b, a
    inc b ;; 1-4
    ld a, #0

    sub b

    ld hl, (#posicionCrearG)
    ld (hl), a


salirGen:
ret