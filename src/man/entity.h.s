;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CONSTANTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; ENTITY INFO
EntitySize=15  ;; 0->type, 1->x, 2->y, 3->vx , 4->vy, 5->ancho(w), 6->alto(h), 7->color, 8-9->prevPos
EntityArraySize=40
EntityArrayBytesSize=EntitySize*EntityArraySize

    ;; INDEX FOR IX/IY
indType=0
indX=1
indY=2
indVx=3
indVy=4
indWidth=5
indHeight=6
indAI2=7
indAI1=8
indColision2=9
indColision1=10
indSprite2=11
indSprite1=12
indPrevPos2=13
indPrevPos1=14

    ;; ENTITY TYPES
ETypeInvalid=0x00
ETypeRenderable=0x01
ETypeMovable=0x02
ETypeInput=0x04
ETypeAI=0x08
ETypeColisionable=0x10
ETypeBullet=0x20
ETypeDead=0x80
ETypeDefault=0x7f

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  PUBLIC FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.globl manEntityInit
.globl manEntityCreate
.globl manEntityDestroy
.globl manEntityMarkToDestroy
.globl manEntityDestroyDead
.globl manEntityForAll
.globl manEntityForAllMatching
.globl getFreeSpace