.include "entity.h.s"
.include "../sys/render.h.s"


.globl cpct_memset_asm
.globl cpct_memcpy_asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

posicionActual:
.ds 2

freeSpace:
.ds 2

mEntities:
   .ds EntityArrayBytesSize 
   .db #0

mNextFreeEntity:
   .ds 2

funcionInversion:
   .ds 2

signature:
   .ds 1

signature2:
   .ds 1



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manEntityInit
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Crea el array de entidades.
;;
manEntityInit::

   ld bc, #EntityArrayBytesSize ;; size

   ld a, #0 ;; value

   ld de, #mEntities ;; puntero al array, primer valor

   call cpct_memset_asm

   ld hl, #mEntities
   ld (mNextFreeEntity), hl

   ld hl, #EntityArrayBytesSize
   ld (#freeSpace), hl

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manEntityCreate
;; Requisitos:
;;    -
;; Return:
;;    hl -> Devuelve el puntero al principio de la entidad creada
;; Descripcion:
;;    Mueve el puntero de siguiente entidad libre y devuelve el principio de la primera entidad libre
;;
manEntityCreate::
   ld bc, (mNextFreeEntity) 

   ld a, #ETypeDefault
   ld (bc), a

   ld hl, #EntitySize
   add hl, bc
   ld (mNextFreeEntity), hl 
   ld l, c
   ld h, b

   push hl

   ld bc, #-EntitySize
   ld hl, (#freeSpace)
   add hl, bc
   ld (#freeSpace), hl

   pop hl


ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manEntityDestroy
;; Requisitos:
;;    ix -> puntero al inicio de la entidad
;; Return:
;;    -
;; Descripcion:
;;    Destruye una entidad del array.
;;
manEntityDestroy::

   ld bc, #EntitySize
   ld hl, (#freeSpace)
   add hl, bc
   ld (#freeSpace), hl

   call sysRenderBorrado

   ld bc, #-EntitySize
   ld (posicionActual), ix
   ld hl, (#posicionActual)
   ld d, h
   ld e, l
   ld hl, (#mNextFreeEntity)

   add hl, bc

   ld (mNextFreeEntity), hl

   ld bc, #EntitySize

   call cpct_memcpy_asm

   ld bc, #EntitySize;; size

   ld a, #0 ;; value

   ld de, (#mNextFreeEntity) ;; puntero al array, primer valor

   call cpct_memset_asm

   ld ix, (#posicionActual)
   ld bc, #-EntitySize 
   add ix, bc

ret

manEntityMarkToDestroy::

   ld a, indType(ix)
   ld b, #ETypeDead

   or b

   ld indType(ix), a

ret

manEntityDestroyDead::

   ld hl, #manEntityDestroy
   ld a, #ETypeDead

   call manEntityForAll

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manEntityForAll
;; Requisitos:
;;    hl -> funcion a la que llamara para todas las entidades
;;    a  -> firma para dejar pasar solo los tipo de entidades deseadas
;; Return:
;;    -
;; Descripcion:
;;    Recorre todas las entidades y ejecuta la funcion que se le pasa por parametro
;;
manEntityForAll::

   ld (funcionInversion), hl
   ld ix, #mEntities

   ld (signature), a

   bucleForAll:

      ld a, indType(ix)      ;; tipo de la entidad
      or a

      ret z

      ld b, indType(ix)      ;; tipo de la entidad
      ld a, (#signature)
      and b

         jr z, salidaBucleForAll ;; si invalido, no se llama a la funcion

      ld hl, (#funcionInversion)

      ld bc, #salidaBucleForAll
      push bc
      
      jp (hl) ;;hl=direccion de la funcion a la que hay que llamar
salidaBucleForAll:

      ld bc, #EntitySize
      add ix, bc

   jr bucleForAll

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    manEntityForAllMatching
;; Requisitos:
;;    hl -> funcion a la que llamara para todas las entidades
;;    a  -> firma 1 para dejar pasar solo los tipo de entidades deseadas
;;    b  -> firma 2 para dejar pasar solo los tipo de entidades deseadas
;; Return:
;;    -
;; Descripcion:
;;    Recorre todas las entidades y ejecuta la funcion que se le pasa por parametro
;;
manEntityForAllMatching::

   ld (funcionInversion), hl
   ld ix, #mEntities

   ld (signature), a
   ld a, b
   ld (signature2), a

   bucleForAllMatching:

      ld iy, #mEntities
         
      ld a, indType(ix)      ;; tipo de la entidad 1
      or a

      ret z

      ld b, indType(ix)      ;; tipo de la entidad 1
      ld a, (#signature)
      and b

      jr z, salidaBucleForAllMatching ;; si invalido, no se llama a la funcion

      bucleForAllMatching2:

            ld a, indType(iy)      ;; Si la entidad es invalida, sale del bucle
            or a

            jr z, salidaBucleForAllMatching

            ld b, indType(iy)      ;; Si la entidad no coincide, siguiente entidad
            ld a, (#signature2)
            and b

            jr z, salidaBucleForAllMatching2 

            ld hl, (#funcionInversion)

            ld bc, #salidaBucleForAllMatching2
            push bc
            
            jp (hl)        ;; hl=direccion de la funcion a la que hay que llamar

            salidaBucleForAllMatching2:

            ld bc, #EntitySize
            add iy, bc

      jr bucleForAllMatching2


salidaBucleForAllMatching:

      ld bc, #EntitySize
      add ix, bc

   jr bucleForAllMatching

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; getFreeSpace
;; Requisitos:
;;    -
;; Return:
;;    hl -> Espacio libre en memoria
;; Descripcion:
;;    Devuelve el espacio libre en memoria del array de entidades
;;
getFreeSpace::
   ld hl, (#freeSpace)
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; getFreeSpace
;; Requisitos:
;;    -
;; Return:
;;    hl -> Espacio libre en memoria
;; Descripcion:
;;    Devuelve el espacio libre en memoria del array de entidades
;;
getNextFreeEntity::
   ld ix, (#mNextFreeEntity)
ret
