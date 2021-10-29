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

.include "physics.h.s"
.include "../man/entity.h.s"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysPhysicsUpdateOne
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Modifica las entidades que son movibles segun su vx y vy
sysPhysicsUpdateOne::

        ;; Mover x

    ld a, indX(ix)
    ld b, indVx(ix)
    add a, b

    push af
    ld a, #MaxX
    pop de  
    cp d

    jp c, destroy       ;; Si sale por la der, se marca para destruir

    ld indX(ix), d

        ;; Mover y

    ld a, indY(ix)
    ld b, indVy(ix)
    add a, b

    ld c, #MaxY

    ;; a = y + vy

    ;;  Por arriba
    
    dec a
    cp c
    
    ret nc
 
    inc a
    ld indY(ix), a

    ret

destroy:

    ld h, indPhysics1(ix)
    ld l, indPhysics2(ix)
    
    ld bc, #salirPhysics
    push bc

    jp (hl)

    salirPhysics:

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysPhysicsUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para la modificacion de posicion de todas las entidades.
sysPhysicsUpdate::

    ld hl, #sysPhysicsUpdateOne
    ld a, #ETypeMovable
    call manEntityForAll

ret