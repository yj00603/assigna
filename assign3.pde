final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage soilPImage[] = new PImage[6];
int soils = 24;
int lifes = 5;

boolean upPressed,downPressed,rightPressed,leftPressed;

int groundhogIdleX,groundhogIdleY,groundhogIdleX1,groundhogIdleY1,t;
int groundhogIdleSpeed = 80 ;
int speedX = 2;
int soilY = 0;
int soilsize = 80;
int lifeSize = 50;
int lifeSpace = 20;
int lifeX = 10;
int lifeY = 10;
int groundhogSize = 80;

PImage bg,gameover,groundhogDown,groundhogIdle,groundhogLeft,groundhogRight;
PImage life,restartHovered,restartNormal,startHovered,startNormal,title;
PImage soil0, soil1, soil2, soil3, soil4, soil5, stone1, stone2;

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
  groundhogIdleX = width/2-groundhogSize/2;
  groundhogIdleY = height/6;
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  soilPImage[0] = loadImage("img/soil0.png");
  soilPImage[1] = loadImage("img/soil1.png");
  soilPImage[2] = loadImage("img/soil2.png");
  soilPImage[3] = loadImage("img/soil3.png");
  soilPImage[4] = loadImage("img/soil4.png");
  soilPImage[5] = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
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

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

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
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		for(int x = 0; x < width; x += soilsize){
      for(int j = 0; j < soils; j++){

        int y= 160+soilsize*(j+1)-80;
        if(j<4){
        image(soilPImage[0], x,y ,soilsize,soilsize);
         }
        if(j>=4 && j<8){
        image(soilPImage[1], x,y ,soilsize,soilsize);
        }
        if(j>=8 && j<12){
        image(soilPImage[2], x,y ,soilsize,soilsize);
        }
        if(j>=12 && j<16){
        image(soilPImage[3], x,y ,soilsize,soilsize);
        }
        if(j>=16 && j<20){
        image(soilPImage[4], x,y ,soilsize,soilsize);
        }
        if(j>=20){
        image(soilPImage[5], x,y ,soilsize,soilsize);
        }
      }
    }
    //first stone
    int x1 = 0, y1 = 0; 
    for(int i = 0; i < 8; i ++){
        x1 = i*soilsize ;
        image(stone1,x1,y1+160);
        y1 += soilsize;  
    }
    //second stone
    for(int x2 = 0; x2 < soilsize*2; x2 +=soilsize){
       for(int j = 8; j < soils*2/3; j++){
       int y2= 160+soilsize*(j+1)-80;
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
    for(int x2 = 0; x2 < soilsize*8; x2 +=soilsize*3){
       for(int j = 16; j < soils*3; j++){
       int y2= 160+soilsize*(j+1)-80;
       if(j==16 ||j==19 ||j==22){
       image(stone1,x2+soilsize,y2);
       image(stone1,x2+soilsize*2,y2);
       image(stone2,x2+soilsize*2,y2);
       }
       if(j==17 ||j==20 ||j==23){
       image(stone1,x2,y2);
       image(stone1,x2+soilsize,y2);
       image(stone2,x2+soilsize,y2);
       }
       if(j==18 ||j==21){
       image(stone1,x2,y2);
       image(stone1,x2+soilsize*2,y2);
       image(stone2,x2,y2);
       }
       }
    }
		// Player
    image(groundhogIdle,groundhogIdleX,groundhogIdleY);
    if(downPressed){
      t = 0;
      t++;
      if (t >= 1 && t <=1000){
        image(groundhogDown,groundhogIdleX,groundhogIdleY);
      }else{
        image(groundhogIdle,groundhogIdleX,groundhogIdleY);
      }
      groundhogIdleY += groundhogIdleSpeed;
        if(groundhogIdleY + groundhogSize >(soils+2)*soilsize)groundhogIdleY = (soils)*soilsize- groundhogSize;
         downPressed = false;
      }
     if(leftPressed){
       groundhogIdleX -= groundhogIdleSpeed;
         if(groundhogIdleX < 0 )groundhogIdleX = 0;
          leftPressed = false;
      }
     if(rightPressed){
       groundhogIdleX += groundhogIdleSpeed;
        if(groundhogIdleX + groundhogSize > width)groundhogIdleX = width - 80;
         rightPressed = false;
      }
      
		// Health UI
    for (int z=0; z<playerHealth; z++){
    image(life,lifeX+70*(z+1)-70,lifeY);
    
    }
    
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
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
 switch(keyCode){
    case UP:
    upPressed = true;
    break;
    case DOWN:
    downPressed = true;
    break;
    case RIGHT:
    rightPressed = true;
    break;
    case LEFT:
    leftPressed = true;
    break;
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

void keyReleased(){
  switch(keyCode){
    case UP:
    upPressed = false;
    break;
    case DOWN:
    downPressed = false;
    break;
    case RIGHT:
    rightPressed = false;
    break;
    case LEFT:
    leftPressed = false;
    break;
  }
}
