/* 
COMMENTING IS MORE IMPORTANT THAN CODING!!!
USING THE COMMENTS ONE CAN CODE IN ANY LANGUAGE ONE PREFERS.
COMMENTING IS JUST ANOTHER NAME FOR PROGRAMMING.
CODING IS JUST TRANSLATING THE PROGRAMMING INTO A PARTICULAR LANGUAGE.
*/

/*
What remains is adding a visualizer.
What components will there be?
Two axes:
  X: Will contain each word
  Y: Time taken to type each word

So, first of all, a simple line graph is needed.
*/
// The required globals
StringList words = new StringList();
FloatList times = new FloatList();
float speed = 0.0;
String current_word = "";
int start_time = 0;
boolean typing_started = false;

void plot(){
  float x_start = 0;
  float y_start = height;
  float x_end = width;
  float y_end = 0;
  float x_offset = 50;
  float y_offset = 50;
  float spacing = 10;
  stroke(230,230,250);
  strokeWeight(3);
  line(x_start, y_start-y_offset, x_end, y_start-y_offset);
  line(x_start+x_offset, y_start, x_start+x_offset, y_end);
  
  
  strokeWeight(1.5);
  
  textSize(16);
  fill(230,230,250);
  for(int i=0; i < times.size(); i++) {
    if(i==0) {
      line(x_offset, y_start-y_offset, x_offset+(i+1)*spacing, y_start-y_offset-(float)times.get(i)/100);
      text(words.get(i), x_offset+(i+1)*spacing+10, y_start-y_offset-(float)times.get(i)/100);
    }
    else {
      line(x_offset+(i)*spacing, y_start-y_offset-(float)times.get(i-1)/100, x_offset+(i+1)*spacing, y_start-y_offset-(float)times.get(i)/100);
      text(words.get(i), x_offset+(i+1)*spacing+10, y_start-y_offset-(float)times.get(i)/100);
    }  
  }
}


void setup() {
  size(800,800);
  background(20,20,45);
  noLoop();
}



// Visualize
void draw() {
  fill(130,25,80);
  rect(50,50,300,300);
  fill(0,0,0);
  textSize(16);
  text(str(words.size()), 100, 100);
  textSize(36);
  text(str(speed), 100, 200);
  textSize(16);
  text(str(millis()/1000), 200, 100);
  textSize(16);
  text(current_word, 300, 100);
  plot();
  
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
  
  // when backspace is pressed and current word is not empty, remove the last typed key
  if(key == BACKSPACE) {
    if(current_word == "") return;
    
    current_word = current_word.substring(0,current_word.length()-1);
    println(current_word);
    return;
  }
  // user has started typing
  if(!typing_started){
    start_time = millis();
    typing_started = true;
    println(start_time);
  }
  
  // keep constructing the current word with every keystroke until the spacebar is pressed
  current_word += str(key);
  
  // when the spacebar is pressed, append the word and the time when the word is done constructing
  if(key==' '){
    words.append(current_word);
    times.append(millis());
    // reset the current word to construct a new word 
    current_word = "";
    
    // calculate the typing speed
    speed = words.size()/(float)(millis()-start_time)*60*1000;
    println(speed);
  }
  
}
