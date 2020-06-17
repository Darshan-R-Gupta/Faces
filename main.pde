import processing.net.*;

Face f;
Server s;
Client c;
String input;
String eyes,mood,brows;
float data[];
void setup(){
  fullScreen();
  f = new Face();
  s= new Server(this, 12345); 

}
void draw(){
  
  background(255,255,0);
  eyes = f.e1.loc.x + " " + f.e1.loc.y + " " + f.e2.loc.x + " " + f.e2.loc.y;
  brows = " "+ (f.b1.end.y -f.b1.loc.y) + " " + (f.b2.end.y - f.b2.loc.y);
  mood = " " + f.m.mood + "\n";
  s.write(eyes + brows + mood);
  f.update();
  f.display();
}
