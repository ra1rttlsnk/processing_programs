// What remains is adding a visualizer

// The required globals
StringList pressed_keys = new StringList();
FloatList times = new FloatList();
int word_count = 0;
float speed = 0.0;


void setup() {
  size(800,800);
  noLoop();
}

// Visualize
void draw() {
  background(20,20,45);
  textSize(16);
  text(str(word_count), 100, 100);
  textSize(36);
  text(str(speed), 100, 200);
  textSize(16);
  text(str(millis()/1000), 200, 100);
  
}

// Helper functions to show the lists
void showList(StringList listName) {
  for(int i=0; i<listName.size(); i++) {
        println(listName.get(i));
      }
}

void showList(FloatList listName) {
  for(int i=0; i<listName.size(); i++) {
        println(listName.get(i));
      }
}

// Handle keys
void keyTyped() {
  loop();
  pressed_keys.append(str(key));
  times.append(millis());
  
  if(key==' '){
    word_count++;
    speed = word_count/(millis()-times.get(0))*60*1000;
  }
  
}
