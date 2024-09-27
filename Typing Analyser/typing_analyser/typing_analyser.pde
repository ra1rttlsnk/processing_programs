/* 
COMMENTING IS MORE IMPORTANT THAN CODING!!!
USING THE COMMENTS ONE CAN CODE IN ANY LANGUAGE ONE PREFERS.
COMMENTING IS JUST ANOTHER NAME FOR PROGRAMMING.
CODING IS JUST TRANSLATING THE PROGRAMMING INTO A PARTICULAR LANGUAGE.
*/
// What remains is adding a visualizer

// The required globals
StringList words = new StringList();
FloatList times = new FloatList();
float speed = 0.0;
String current_word = "";
int start_time = 0;
boolean typing_started = false;

void setup() {
  size(800,800);
  noLoop();
}

// Visualize
void draw() {
  background(20,20,45);
  textSize(16);
  text(str(words.size()), 100, 100);
  textSize(36);
  text(str(speed), 100, 200);
  textSize(16);
  text(str(millis()/1000), 200, 100);
  textSize(16);
  text(current_word, 300, 100);
  
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
    times.append(millis());
  }
  typing_started = true;
  
  // keep constructing the current word with every keystroke until the spacebar is pressed
  current_word += str(key);
  
  // when the spacebar is pressed, append the word and the time when the word is done constructing
  if(key==' '){
    words.append(current_word);
    
    // reset the current word to construct a new word 
    current_word = "";
    
    // calculate the typing speed
    speed = words.size()/(millis()-times.get(0))*60*1000;
  }
  
}
