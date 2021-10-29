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


speedAILeft:
    .db #-1

aiCounter:
    .db #1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      init
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    -
sysAIInit::

    ld a, #1
    ld (aiCounter), a

    ld a, #-1
    ld (speedAILeft), a

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      UpdateOne
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Modifica las entidades que son movibles segun su vx y vy
sysAIUpdateOne:

    ld h, indAI1(ix)
    ld l, indAI2(ix)

    ld bc, #salirAI
    push bc

    jp (hl)

    salirAI:

ret

sysAIMoveLeft::

    ld a, (#speedAILeft)
    ld indVx(ix), a
    
ret

sysAIEnemy:

    ld indVx(ix), #0
    call sysAICheckCounter

ret

sysAIEnemy1::

    call sysAIEnemy

ret

sysAIEnemy2::

    call sysAIEnemy

ret

sysAIEnemy3::

    call sysAIEnemy

ret

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