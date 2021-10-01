
.globl manEntityDestroy
.globl manEntityForAll

sysPhysicsUpdateOne:

    pop hl
    inc hl
    ld b, (hl) ;; x

    inc hl 
    inc hl  
    ld a, (hl) ;; vx negativo

    dec hl
    dec hl
    dec hl

    add a, b ;; vx + x
    cp b

    jr nc, llamadaDestroy

    inc hl
    ld (hl), a
    dec hl
    jr finSysPhysicsUpdateOne

llamadaDestroy:
    call manEntityDestroy
    
finSysPhysicsUpdateOne:
    ret

sysPhysicsUpdate::

    ld hl, #sysPhysicsUpdateOne
    call manEntityForAll

ret