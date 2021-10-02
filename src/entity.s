.include "entityInfo.s"

.globl cpct_memset_asm
.globl cpct_memcpy_asm

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manEntityInit
;; Requisitos:
;;    -
;; Return:
;;    -
;; Descripcion:
;;    Crea el array de entidades.
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

   ld bc, #-EntitySize

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
manEntityDestroy::

;; TODO

;; Aumentar el freeSpace
;; Borrar de memoria la entidad, tipo a 0
;; bajar el puntero de mNextFreeEntity

   ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manEntityForAll
;; Requisitos:
;;    hl -> funcion a la que llamara para todas las entidades
;; Return:
;;    -
;; Descripcion:
;;    Recorre todas las entidades y ejecuta la funcion que se le pasa por parametro
manEntityForAll::

   ld (funcionInversion), hl
   ld ix, #mEntities

bucleForAll:

   ld a, indType(ix)      ;; tipo de la entidad
   or a

   jr z, salir ;; si invalido, salir

   ld bc, #salidaSalto
   push bc

   ld hl, (#funcionInversion)
   
   jp (hl) ;;hl=direccion de la funcion a la que hay que llamar
   salidaSalto:

   ld bc, #EntitySize
   add ix, bc

   jr bucleForAll

salir:
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; getFreeSpace
;; Requisitos:
;;    -
;; Return:
;;    hl -> Espacio libre en memoria
;; Descripcion:
;;    Devuelve el espacio libre en memoria del array de entidades
getFreeSpace::
   ld hl, (#freeSpace)
ret

