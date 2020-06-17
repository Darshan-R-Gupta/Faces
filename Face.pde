class Eye{
  PVector eye_loc;  //The location of whole eye
  PVector loc;//The location of iris
  float size; 
  float iris_size;
  Eye(float x, float y, float s){
    eye_loc = new PVector(x,y);
    loc = new PVector(0,0);  //with reference to eye's location
    size = s;   
    iris_size = size/5;
  }
  void display(){
    fill(255);
    rectMode(CENTER);
    pushMatrix();
    translate(eye_loc.x, eye_loc.y);
    rect(0, 0, size, size, size/10);  //For a bit rounded eyes;
    fill(0);
    rect(loc.x, loc.y, iris_size, iris_size, 20);
    popMatrix();
  }
  void update(PVector dloc){
    checkEdges(dloc);
    loc.add(dloc);
  }
  void checkEdges(PVector dloc){
    PVector next= PVector.add(loc,dloc);
    if(next.x < -size/2 + iris_size/2 +3  || next.x > size/2 - iris_size/2 -3){
      dloc.x =0; 
    }
    if(next.y < -size/2 + iris_size/2 +3 || next.y > size/2- iris_size/2 -3){
      dloc.y =0;
    }
  } 
};
class eyeBrow{
  PVector loc;  //Leftmost point of the brow;
  PVector end;
  float len;   //Length of the brow;
  float b1,b2;  //The upper and lower bound's y values
  eyeBrow(float x, float y,float ex, float ey){
    loc = new PVector(x,y);
    end = new PVector(ex,ey);
    len = dist(loc.x, loc.y, end.x, end.y);
    b1 = loc.y - 40;
    b2 = loc.y + 40;
  }
  void display(){
    strokeWeight(10);
    line(loc.x, loc.y, end.x, end.y);
    strokeWeight(1);
  }
  
}
class mouth{
  PVector loc;
  float size;
  float mood;  //<0 for sad 0 for neutral and >0 for happy
  mouth(float x, float y){
      loc = new PVector(x,y);
      size = 300;
      mood = 0;
  }
  void display(){
      noFill();
      strokeWeight(5);
      if(mood < 0){
          float x= map(mood, -20,0, size, 0);
          arc(width/2 , 3*height/4 , size, x, -PI,0);
      }
      else if(mood > 0){
        float x = map(mood,0,20 ,0,size);
        arc(width/2 , 3*height/4 , size, x, 0,PI);
      }
      else{
        line(width/2-size/2, 3*height/4, width/2+size/2, 3*height/4);
      }
      strokeWeight(1);
 }
}
class Face{
  Eye e1,e2;
  eyeBrow b1,b2;
  mouth m;
  Face(){
    e1 = new Eye(width/3, height/4, 200);
    e2 = new Eye(2*e1.eye_loc.x, height/4,200);
    float start1x =e1.eye_loc.x - e1.size/2-10;
    float start2x = e2.eye_loc.x + e2.size/2+10;
    float start1y = e1.eye_loc.y - e1.size/2-30;
    float start2y =  e2.eye_loc.y - e2.size/2-30;
    
    b1 = new eyeBrow(start1x, start1y,start1x+e1.size+20, start1y +30);
    b2 = new eyeBrow(start2x,start2y,start2x -e2.size-20, start2y +30);
    m = new mouth(width/2, height/2);
  }
  void display(){
    e1.display();
    e2.display();
    
    b2.display();
    b1.display();
    m.display();
  }
  void update(){
    PVector mouse = new PVector(mouseX, mouseY);
    PVector pmouse = new PVector(pmouseX, pmouseY);
    PVector dloc = PVector.sub(mouse ,pmouse);
    dloc.normalize();
    dloc.mult(10);
    e1.update(dloc); 
    e2.update(dloc);
    if(keyPressed){
      if(key == CODED){ 
        if(keyCode == UP){
           if(b1.end.y >= b1.b1){ 
             b1.end.y-=2;
             b2.end.y-=2;
           }
         }
         else if(keyCode == DOWN){
           if(b1.end.y <= b1.b2){
             b1.end.y+= 2;
             b2.end.y+= 2;
           }
         }
      }
      if(key == 'W' || key == 'w'){
        m.mood-=0.7;
        if(m.mood < -20){
          m.mood = -20;
        }
        
      }
      if(key == 'S' || key == 's'){
        m.mood += 0.7;
        if(m.mood > 20){
          m.mood = 20;
        }
      }
    }
  }
}
