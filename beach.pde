import processing.sound.*;
SoundFile beachf;
PinkNoise pnoise;
float sun_pos = height*2;
float moon_pos_x;
float moon_pos_y;
int colormod = 10;

class Point { 
  int x;
  int y;
 
  Point (int x_, int y_) { 
    x = x_; 
    y = y_;
  }
}

Point[] stars;


void setup(){
  size(800,600);
  moon_pos_x = width + 40;
  moon_pos_y = 0;
  frameRate(60);
  stars = new Point [200];
  for (int i = 0; i < stars.length; i++) 
    stars[i] = new Point(int(random(0, width)), int(random(0, height - 250)));
  beachf = new SoundFile(this, "beach.wav");
  pnoise = new PinkNoise(this);
}


void scene_1(){
  if(!pnoise.isPlaying()){ 
    pnoise.play();
  }
  int square_size = 4;

  for(int i = 0; i < width/square_size; i++){
    for(int j = 0; j < height/square_size; j++){
      int col = int(random(0,255));
      noStroke();
      fill(col, col, col);
      square(i*square_size, j*square_size % width, square_size);
    }
  }
}


void beach_scene(){
  pnoise.stop();
  if(!beachf.isPlaying()){ 
    beachf.play();
  }

  int s = int(millis()/1000);
  colormod = s*6;

  if(colormod > 204){
    colormod = 204;
  }

  // Cielo
  background(95 - colormod, 202 - colormod, 212 - colormod);

  // Estrellas
  if(colormod >= 162){
    int start_color = 70;
    for (int i = 0; i < stars.length; i++) {
      stroke(random(start_color,255), random(start_color,255), random(start_color,255));
      point(stars[i].x, stars[i].y);
    }
  }

  // Sol
  noStroke();
  fill(252, 202, 3);
  circle(width/2, sun_pos, 40);
  sun_pos += 0.1;

  // Mar
  noStroke();
  fill(72 - colormod, 171 - colormod, 169 - colormod);
  float x = 0;
  float y = 0;
  beginShape();
  while(x < width){
    // point(x, 50 + random(-10, 10));
    y = height - 250 + 2*noise(x/20);
    vertex(x, y);
    x += 1;
    //fill(235, 196, 89);
  }
  vertex(width, height);
  vertex(0, height);

  endShape();

  // Playa
  noStroke();
  fill(235 - colormod, 196 - colormod, 89 - colormod);
  x = 0;
  y = 0;
  beginShape();
  while(x < width){
    // point(x, 50 + random(-10, 10));
    y = height - 150 + 14*noise(x/20);
    vertex(x, y);
    x += 1;
  }
  vertex(width, height);
  vertex(0, height);
  endShape();
  
  if(s >= 50){
    // Luna
    noStroke();
    fill(229, 229, 229);
    circle(moon_pos_x, moon_pos_y, 40);
    moon_pos_x -= 0.1;
    moon_pos_y += 0.05;

    if(moon_pos_x < -800){
      moon_pos_x = width + 40;
      moon_pos_y = 0;
    }

    textSize(32);
    fill(255);
    text("Fin", width/2 - 20, height/3);
  }
}


void draw(){
  background(#eeeeee);
  int s = int(millis()/1000);

  if(s < 10) scene_1();
  // else if(s >= 3 && s < 5) scene2(); 
  else if(s >= 10) beach_scene();
  //else if(s >= 5 && s < 45) beach_scene();
  //else if(s >= 45) endScene();
}
