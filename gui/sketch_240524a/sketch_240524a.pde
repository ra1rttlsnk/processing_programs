import g4p_controls.*;

GButton btn0;
GSlider sl0;
void setup() {
  size(300, 200);
  sl0 = new GSlider(this, 40, 20, 100, 50, 10);
  sl0.addEventHandler(this, "handleSl0");
}

void draw() {
  background(240);
}

public void handleSl0(GSlider slider, GEvent event) {
  println(slider.getValueF());
}
