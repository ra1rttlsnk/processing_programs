// I'm finally aiming to create a physics engine that has 
// advanced collision detection. Need to research to be able
// to implement such a system. But this time everything will
// be built, so as to they can be improved upon.
import g4p_controls.*;

float g = 0;
float TIME_INTERVAL = 1; //1 means using the frame time.
GSlider time_slider;

void setup() {
  size(800,800);
  background(30,10,10);
  time_slider = new GSlider(this, width-200, 100, 200, 50, 20);
  time_slider.addEventHandler(this, "timeSliderEventHandler");
  time_slider.setValue(1.0);
  time_slider.setLimits(-1.0,1.0);
  time_slider.setPrecision(5);
  
}

public void timeSliderEventHandler(GSlider slider, GEvent event) {
  float value = time_slider.getValueF();
  TIME_INTERVAL = 1*value;
}

class LinearMotion {
  private PVector position;
  private PVector velocity;
  private PVector acceleration;
  private float mass;
  
  LinearMotion() {
    position = new PVector(100, 100, 0);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector();
  }
  
  public void update() {
    velocity.add(acceleration.copy().mult(TIME_INTERVAL));
    position.add(velocity.copy().mult(TIME_INTERVAL));
    acceleration.mult(0);
  } 
  
  public void applyForce(PVector force) {
    acceleration.add(force.div(mass));
  }
  
  public void applyAcceleration(PVector accl) {
    acceleration.add(accl);
  }
  
  public void control(char k) {
    float amount = 0.5;
    if (k == 'w')
      acceleration.y -= amount;
    if (k == 's')
      acceleration.y += amount;
    if (k == 'd')
      acceleration.x += amount;
    if (k == 'a')
      acceleration.x -= amount;
  }
  
}

class Ball {
  private LinearMotion linearMotion;
  private float diameter;
  
  Ball() {
    linearMotion = new LinearMotion();
    diameter = 50.0;
  }
  
  void drawShape() {
    fill(20,20,150);
    strokeWeight(2);
    ellipse(linearMotion.position.x, linearMotion.position.y, diameter, diameter);
  }
  
  void applyGravity() {
    linearMotion.applyAcceleration(new PVector(0.0, g));
  }
  
  void enableBoundary() {
    if (linearMotion.position.y+diameter/2 >= height) {
      linearMotion.acceleration.mult(0);
      linearMotion.position.y = height-diameter/2;
      linearMotion.velocity.y *= -1;
    }
  }
  
  void update() {
    
    applyGravity();
    enableBoundary();
    linearMotion.update();
    drawShape();
  }
  
}

Ball ball1 = new Ball();

void draw() {
  background(30,10,10);
  fill(255,255,255);
  text(TIME_INTERVAL, width-100, 100);
  ball1.update();
  println(ball1.linearMotion.velocity);
}

void keyPressed() {
  if (keyCode == UP)
    TIME_INTERVAL += 0.001;
  if (keyCode == DOWN)
    TIME_INTERVAL -= 0.001;
  if (keyCode == RIGHT)
    TIME_INTERVAL += 0.01;
  if (keyCode == LEFT)
    TIME_INTERVAL -= 0.01;
  
  time_slider.setValue(TIME_INTERVAL);
  
  ball1.linearMotion.control(key);  
  
}
