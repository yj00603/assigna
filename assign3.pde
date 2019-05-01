final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

boolean idle = true;
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;

PImage soilPImage[] = new PImage[6];
int soilY0 = 160, soilY = 0, soilsize = 80;

int groundhogX, groundhogY, groundhogSpeed, groundhogSize = 80, groundhogX0 = 320, groundhogY0 = 80; 
int lifes = 5, lifeX = 10,lifeY = 10, lifeSpace = 20, lifeSize = 50;

PImage bg,gameover,groundhogDown,groundhogIdle,groundhogLeft,groundhogRight;
PImage life,restartHovered,restartNormal,startHovered,startNormal,title;
PImage stone1, stone2;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  frameRate(60);
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  playerHealth = 2;
	bg = loadImage("img/bg.jpg");
  life = loadImage("img/life.png");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  for (int i= 0; i<6; i++){
    soilPImage[i] = loadImage("img/soil" +i+ ".png");
  }
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  groundhogX = groundhogX0;
  groundhogY = groundhogY0;
  groundhogSpeed = 80/16;
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case 0: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

		image(startHovered, START_BUTTON_X, START_BUTTON_Y);
		if(mousePressed){
			gameState = 1;
			mousePressed = false;
			}
		}else{
			image(startNormal, START_BUTTON_X, START_BUTTON_Y);
		}
		break;

		case 1: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	  stroke(255,255,0);
	  strokeWeight(5);
	  fill(253,184,19);
	  ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, soilY0 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		for(int x = 0; x < width; x += soilsize){
      for(int j = 0; j < 24; j++){ 
        soilY = soilY0 + soilsize*j;
        image(soilPImage[(int)(j/4)], x, soilY);
      }
    }
    //first stone
    int x1 = 0, y1 = 0; 
    for(int i = 0; i < 8; i ++){
      y1 = soilY0 + i*soilsize;
        image(stone1,i*soilsize,y1); 
    }
    //second stone
    int y2;
    for(int x2 = 0; x2 < soilsize*2; x2 +=soilsize){
       for(int j = 8; j < 24*2/3; j++){
         y2 = soilY0 + j*soilsize;
         if(j==8 ||j==11 ||j==12 ||j==15){
         image(stone1,x2+soilsize,y2);
         image(stone1,x2+soilsize*5,y2);
         }
         if(j==9 ||j==10 ||j==13 ||j==14){
         image(stone1,x2-soilsize,y2);
         image(stone1,x2+soilsize*3,y2);
         image(stone1,x2+soilsize*7,y2);
       }
       }
    }
     //third stone
     int y3;
     for(int x3 = 0; x3 < soilsize*8; x3 +=soilsize*3){
        for(int j = 16; j < 24*3; j++){
          y3 = soilY0 + j*soilsize;;
          if(j==16 ||j==19 ||j==22){
          image(stone1,x3+soilsize,y3);
          image(stone1,x3+soilsize*2,y3);
          image(stone2,x3+soilsize*2,y3);
          }
          if(j==17 ||j==20 ||j==23){
          image(stone1,x3,y3);
          image(stone1,x3+soilsize,y3);
          image(stone2,x3+soilsize,y3);
          }
          if(j==18 ||j==21){
          image(stone1,x3,y3);
          image(stone1,x3+soilsize*2,y3);
          image(stone2,x3,y3);
       }
       }
    }
    
    // Player boundary detection
    if(groundhogX<0){
      leftPressed = false;
      idle = true;
      groundhogX = 0;
    }
    if(groundhogX>width-groundhogSize){
      rightPressed = false;
      idle = true;
      groundhogX = width-groundhogSize;
    }
    if(groundhogY>height-groundhogSize){
      downPressed = false;
      idle = true;
      groundhogY = height-groundhogSize;
    }

		// Player
   if(idle){
      image(groundhogIdle,groundhogX,groundhogY);
    }
   if(downPressed){
     if(groundhogY<height-groundhogSize){
      idle = false;
      leftPressed = false;
      rightPressed = false;
      image(groundhogDown,groundhogX,groundhogY);
      if(groundhogY < soilY0+1520){
       soilY0 -= groundhogSpeed;
        if(soilY0 % 80 == 0){
        downPressed = false;
        idle = true;
        }
      }
       else{
          groundhogY += groundhogSpeed;
          if(groundhogY % 80 == 0){
          downPressed = false;
          idle = true;
          }
        } 
      }
      else{
        downPressed = false;
        idle = true;
      }
    }
    if(leftPressed){
      if(groundhogX > 0){
        idle = false;
        downPressed = false;
        rightPressed = false;
        image(groundhogLeft,groundhogX,groundhogY);
        groundhogX -= groundhogSpeed;
        if(groundhogX % 80 == 0){
          leftPressed = false;
          idle = true;
        }
      }
      else{
        leftPressed = false;
        idle = true;
      }

    }
    
    if(rightPressed){
      if(groundhogX<width-groundhogSize){
        idle = false;
        leftPressed = false;
        downPressed = false;
        image(groundhogRight,groundhogX,groundhogY);
        groundhogX += groundhogSpeed;
        if(groundhogX % 80 == 0){
          rightPressed = false;
          idle = true;
        }
      }
      else{
        rightPressed = false;
        idle = true;
      }
    }
    
    
    
    
		// Health UI
    for (int z=0; z<playerHealth; z++){
    image(life,lifeX+70*(z+1)-70,lifeY);
    
    }
    
		break;

		case 2: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = 1;
        groundhogX = groundhogX0;
        groundhogY = groundhogY0;
        playerHealth = 2;
        soilY0 = 160;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{
			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
		}
		break;		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
    if(key == CODED){
      switch(keyCode){
        case DOWN:
          if(groundhogX%80 == 0 && groundhogY%80 == 0 && soilY0%80 == 0){
            downPressed = true;
            leftPressed = false;
            rightPressed = false;
          }
          break;
        case LEFT:
          if(groundhogX%80 == 0 && groundhogY%80 == 0 && soilY0%80 == 0){
            leftPressed = true;
            downPressed = false;
            rightPressed = false;
          }
          break;
        case RIGHT:
          if(groundhogX%80 == 0 && groundhogY%80 == 0 && soilY0%80 == 0){
            rightPressed = true;
            leftPressed = false;
            downPressed = false;
          }
          break;
      }
    }
      

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}
