.include "difficulty.h.s"

.include "../sys/AI.h.s"




difficultyLvl:
    .db #0

difficultyArray:
    .dw #manDifficultyLvl0  ;;0
    .dw #manDifficultyLvl1  ;;2
    .dw #manDifficultyLvl2  ;;4
    .dw #manDifficultyLvl3  ;;6
    .dw #manDifficultyLvl4  ;;8
    .dw #manDifficultyLvl5  ;;10


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyUpdate
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyUpdate::

    ld a, (#difficultyLvl)
    ld hl, #difficultyArray

    ld c, l
    ld e, #0

    add c
    ld l, a
    
    ld a, h
    adc e
    ld h, a

    ld e, (hl)
    inc hl
    ld d, (hl)

    ex de, hl
    
    ld bc, #endDifficultyUpdate
    push bc
    
    jp (hl)

endDifficultyUpdate:
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyIncrease
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyIncrease::

    ld a, (#difficultyLvl)
    inc a
    inc a

    ;; Comprobar que no se salga de rango
    ld (#difficultyLvl), a

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl0
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl0:

    ld a, #1
    call sysAISetAICounter

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl1
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl1:

    ld a, #0
    call sysAISetAICounter
    ld a, #-1
    call sysAISetSpeedAILeft

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl2
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl2:

    ;; Cambiar algún enemigo

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl3
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl3:

    ;; Cambiar algún enemigo

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl4
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl4:

    ;; Cambiar algún enemigo

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; manDifficultyLvl5
;; Requisitos:
;;      -
;; Return:
;;      -
;; Descripcion:
;;      -
;;
manDifficultyLvl5:

    ld a, #-2
    call sysAISetSpeedAILeft

ret