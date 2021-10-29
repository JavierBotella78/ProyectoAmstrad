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

.globl cpct_getScreenPtr_asm


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysRenderUpdateOne
;; Requisitos:
;;    ix -> Posicion inicial de memoria de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Dibuja los objetos dibujables como cajas. Además borra su posicion anterior
sysPreRenderUpdateOne::


    ld h, indActualPos1(ix) 
    ld l, indActualPos2(ix)

    ld indPrevPos1(ix), h
    ld indPrevPos2(ix), l

    ld de, #0xc000
    ld c, indX(ix)
    ld b, indY(ix)

    call cpct_getScreenPtr_asm


    ld indActualPos1(ix), h
    ld indActualPos2(ix), l

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sysPreRenderUpdate
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Inversion de control para el dibujado de todas las entidades.
sysPreRenderUpdate::

    ld hl, #sysPreRenderUpdateOne
    ld a, #ETypeRenderable
    call manEntityForAll

ret

