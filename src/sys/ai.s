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

.include "ai.h.s"
.include "../man/entity.h.s"
.include "generator.h.s"
.include "animations.h.s"


speedAILeft:
    .db #-1

aiCounter:
    .db #1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIInit
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIInit::

    ld a, #1
    ld (aiCounter), a

    ld a, #-1
    ld (speedAILeft), a

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIUpdateOne
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIUpdateOne:

    ld h, indAI1(ix)
    ld l, indAI2(ix)

    ld bc, #salirAI
    push bc

    jp (hl)

    salirAI:

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIMoveLeft
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIMoveLeft::

    ld a, (#speedAILeft)
    ld indVx(ix), a
    
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy:

    ld indVx(ix), #0
    call sysAICheckCounter

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy1
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy1::

    call sysAIEnemy

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy2
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy2::

    call sysAIEnemy

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy3
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy3::

    call sysAIEnemy

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy5_1
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy5_1::

    ld a, #-1
    ld indVx(ix), a

    ld hl, #sysAIEnemy5_2
    ld de, #animationEnemy5_2
    ld bc, #_spr_knight1
    ld a, #10
    call sysAIEnemy5Counter

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy5_2
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy5_2::

    ld a, #0
    ld indVx(ix), a

    
    ld hl, #sysAIEnemy5_1
    ld de, #animationEnemy5_1
    ld bc, #_spr_knight2
    ld a, #20
    call sysAIEnemy5Counter

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy5Counter
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy5Counter:

    push af
    ld a, indAICounter(ix)
    or a

    jp z, changeEnemy5State

    dec a
    ld indAICounter(ix), a
    pop af

    ret

changeEnemy5State: 
    pop af
    ld indAICounter(ix), a

    ld indAI1(ix), h
    ld indAI2(ix), l

    ld indSprite1(ix), b
    ld indSprite2(ix), c

    ld indAnim1(ix), d
    ld indAnim2(ix), e

    ld a, indSubType(ix)
    ld b, #AITypeInmortal
    xor a, b
    ld indSubType(ix), a

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy6_1
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy6_1::

    ld a, #-1
    ld indVx(ix), a

    ld hl, #sysAIEnemy6_2
    ld de, #animationEnemy6_2
    ld bc, #_spr_newrobot4
    ld a, #10
    call sysAIEnemy6Counter

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy6_2
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy6_2::

    ld a, #0
    ld indVx(ix), a
    
    ld hl, #sysAIEnemy6_1
    ld de, #animationEnemy6_1
    ld bc, #_spr_newrobot1
    ld a, #30
    call sysAIEnemy6Counter

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy5Counter
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy6Counter:

    push af
    ld a, indAICounter(ix)
    or a

    jp z, changeEnemy6State

    dec a
    ld indAICounter(ix), a
    pop af

    ret

changeEnemy6State: 
    pop af
    ld indAICounter(ix), a

    ld indAI1(ix), h
    ld indAI2(ix), l

    ld indSprite1(ix), b
    ld indSprite2(ix), c

    ld indAnim1(ix), d
    ld indAnim2(ix), e

    ld a, indType(ix)
    ld b, #ETypeColisionable
    xor a, b
    ld indType(ix), a

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy7
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy7_1::

    ld indVx(ix), #-1

    ld a, indAICounter(ix)
    or a

    jp z, changeEnemy7State

    dec a
    ld indAICounter(ix), a

    ret

changeEnemy7State:

    ld hl, #sysAIEnemy7_2

    ld indAI1(ix), h
    ld indAI2(ix), l

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemy7_2
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemy7_2::

    ld indVx(ix), #0

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIEnemyBullet
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIEnemyBullet::

    ld indVx(ix), #-1

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAICheckCounter
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAICheckCounter:

    ld a, indAICounter(ix)
    or a
        
    jp z, resetAICounter
 
    dec indAICounter(ix)

    ret 

resetAICounter:

    ld a, (#aiCounter)
    ld indAICounter(ix), a

    call sysAIMoveLeft

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIExplosion
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIExplosion::

    ld a, indAICounter(ix)
    dec a

    jp z, sysAIExplosionDestroy

    ld indAICounter(ix), a

    ret

sysAIExplosionDestroy:

    call manEntityMarkToDestroy
    call sysGeneratorPU

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      sysAIExplosion2
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAIExplosion2::

    ld a, indAICounter(ix)
    dec a

    jp z, sysAIExplosionDestroy2

    ld indAICounter(ix), a

    ret

sysAIExplosionDestroy2:

    call manEntityMarkToDestroy

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysPhysicsUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la modificacion de posicion de todas las entidades.
;;
sysAIUpdate::

    ld hl, #sysAIUpdateOne
    ld a, #ETypeAI
    call manEntityForAll

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysAISetAICounter
;; Requisitos:
;;      a -> New ai counter
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAISetAICounter::

    ld (aiCounter), a

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysAISetAICounter
;; Requisitos:
;;      a -> New ai counter
;; Return:
;;      -
;; Descripcion:
;;      -
;;
sysAISetSpeedAILeft::

    ld (speedAILeft), a

ret