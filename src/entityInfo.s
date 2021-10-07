EntitySize=11  ;; 0->type, 1->x, 2->y, 3->vx , 4->vy, 5->ancho(w), 6->alto(h), 7->color, 8-9->prevPos
EntityArraySize=40
EntityArrayBytesSize=EntitySize*EntityArraySize

indType=0
indX=1
indY=2
indVx=3
indVy=4
indWidth=5
indHeight=6
indSprite2=7
indSprite1=8
indPrevPos2=9
indPrevPos1=10

ETypeInvalid=0x00
ETypeRenderable=0x01
ETypeMovable=0x02
ETypeInput=0x04
ETypeAI=0x08
ETypeColisionable=0x10
ETypeBullet=0x20
ETypeDead=0x80
ETypeDefault=0x7f