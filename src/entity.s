
.globl cpct_memset_asm
.globl cpct_memcpy_asm

posicionActual:
.ds 2

freeSpace:
.ds 2

eTypeInvalid=0x00
eTypeStar=0x01
eTypeDead=0x80
eTypeDefault=0x7f

mEntities:
   .ds 350 ;;0->type, 1->x, 2->y, 3->vx , 4->color, 5-6->prevPos
   .db #0

mNextFreeEntity:
   .ds 2

funcionInversion:
   .ds 2


manEntityInit::

   ld bc, #350 ;; size

   ld a, #0 ;; value

   ld de, #mEntities ;; puntero al array, primer valor

   call cpct_memset_asm

   ld hl, #mEntities
   ld (mNextFreeEntity), hl

   ld hl, #350
   ld (#freeSpace), hl

   ret

manEntityCreate::
   ld bc, (mNextFreeEntity) 

   ld a, #eTypeDefault
   ld (bc), a

   ld hl, #0x0007
   add hl, bc
   ld (mNextFreeEntity), hl 
   ld l, c
   ld h, b

   push hl

   ld bc, #0xfff9
   ld hl, (#freeSpace)
   add hl, bc
   ld (#freeSpace), hl

   ld bc, #0xfff9

   pop hl


   ret

manEntityDestroy::

   push hl

   ld bc, #7
   ld hl, (#freeSpace)
   add hl, bc
   ld (#freeSpace), hl

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

   ld bc, #0xfff9
   ld (posicionActual), hl
   ld d, h
   ld e, l
   ld hl, (#mNextFreeEntity)

   add hl, bc

   ld (mNextFreeEntity), hl

   ld bc, #7

   call cpct_memcpy_asm

   ld bc, #7;; size

   ld a, #0 ;; value

   ld de, (#mNextFreeEntity) ;; puntero al array, primer valor

   call cpct_memset_asm

   ld hl, (#posicionActual)

   ret

manEntityForAll::

   ld (funcionInversion), hl
   ld hl, #mEntities

bucleForAll:

   ld a, (hl)      ;; tipo de la entidad
   or a

   jr z, salir ;; si invalido, salir

   ld bc, #salidaSalto
   push bc

   push hl
   ld hl, (#funcionInversion)
   
   jp (hl) ;;hl=direccion de la funcion a la que hay que llamar
   salidaSalto:

   ld bc, #7
   add hl, bc

   jr bucleForAll

salir:
ret

getFreeSpace::
   ld hl, (#freeSpace)
ret

