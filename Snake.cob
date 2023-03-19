IDENTIFICATION DIVISION.
PROGRAM-ID. SNAKE-GAME.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 SNAKE.
   05 LENGTH PIC 9(2) VALUE 1.
   05 BODY OCCURS 50 TIMES.
      10 X PIC 9(2).
      10 Y PIC 9(2).
01 FOOD.
   05 X PIC 9(2).
   05 Y PIC 9(2).
01 DIRECTION PIC X.
01 BOARD OCCURS 20 TIMES.
   05 ROW OCCURS 20 TIMES.
      10 PIXEL PIC X VALUE '.'.
01 GAME-OVER PIC X VALUE 'N'.
PROCEDURE DIVISION.
   PERFORM INITIALIZATION.
   PERFORM GAME-LOOP UNTIL GAME-OVER = 'Y'.
   STOP RUN.
INITIALIZATION.
   MOVE 10 TO SNAKE(BODY,1).X
   MOVE 10 TO SNAKE(BODY,1).Y
   MOVE 0 TO FOOD.X
   MOVE 0 TO FOOD.Y
   MOVE 1 TO LENGTH
   MOVE 'R' TO DIRECTION
   PERFORM DRAW-BOARD.
   PERFORM DRAW-SNAKE.
   PERFORM DRAW-FOOD.
GAME-LOOP.
   PERFORM HANDLE-INPUT.
   PERFORM MOVE-SNAKE.
   PERFORM CHECK-COLLISIONS.
   PERFORM DRAW-BOARD.
   PERFORM DRAW-SNAKE.
   PERFORM DRAW-FOOD.
HANDLE-INPUT.
   ACCEPT DIRECTION.
MOVE-SNAKE.
   IF DIRECTION = 'R' THEN ADD 1 TO SNAKE(BODY,1).X
   ELSE IF DIRECTION = 'L' THEN SUBTRACT 1 FROM SNAKE(BODY,1).X
   ELSE IF DIRECTION = 'U' THEN ADD 1 TO SNAKE(BODY,1).Y
   ELSE IF DIRECTION = 'D' THEN SUBTRACT 1 FROM SNAKE(BODY,1).Y
   PERFORM MOVE-BODY.
CHECK-COLLISIONS.
   IF SNAKE(BODY,1).X < 1 OR SNAKE(BODY,1).X > 20
      OR SNAKE(BODY,1).Y < 1 OR SNAKE(BODY,1).Y > 20
      THEN SET GAME-OVER TO 'Y'
   IF SNAKE(BODY,1).X = FOOD.X AND SNAKE(BODY,1).Y = FOOD.Y
      THEN PERFORM EAT-FOOD.
   PERFORM CHECK-SELF-COLLISION.
EAT-FOOD.
   ADD 1 TO LENGTH
   COMPUTE FOOD.X = FUNCTION RANDOM(20)
   COMPUTE FOOD.Y = FUNCTION RANDOM(20)
CHECK-SELF-COLLISION.
   COMPUTE I = 2
   PERFORM UNTIL I > LENGTH
      IF SNAKE(BODY,1).X = SNAKE(BODY,I).X AND SNAKE(BODY,1).Y = SNAKE(BODY,I).Y
         THEN SET GAME-OVER TO 'Y'
      ADD 1 TO I
      END-PERFORM.
MOVE-BODY.
   COMPUTE I = LENGTH
   PERFORM UNTIL I < 2
      MOVE SNAKE(BODY,I-1) TO SNAKE(BODY,I)
      SUBTRACT 1 FROM I
