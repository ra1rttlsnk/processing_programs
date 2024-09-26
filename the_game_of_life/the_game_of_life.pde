boolean can_draw = false;
float EXTENT = 1000;
float SPACING = 10;
int number = int(EXTENT)/int(SPACING);
int [][]boxes = new int[number][number];
int [][]affected_boxes = new int[number][number];
float DENSITY = 1;
int GENERATION = 0;

void graph(float L, float spacing_x, float spacing_y) {
  
  for(int n=0; n<int(L/spacing_x); n++) {
    float x = spacing_x*n;
    float y0 = 0.0;
    float y1 = y0+L;
    line(x, y0, x, y1);
  }
  
  for(int n=0; n<int(L/spacing_y); n++) {
    float y = spacing_x*n;
    float x0 = 0.0;
    float x1 = x0+L;
    line(x0, y, x1, y);
  }
}

int index_to_coordinate(int index) {
  return int(index*SPACING+SPACING/2);
}

void populate_box() {
  for(int i=0; i<number; i++){
    for(int j=0; j<number; j++){
      float val = random(10);
      if(val < DENSITY){
        boxes[i][j] = 1;
        affected_boxes[i][j] = 1;
      }
    }
  }
}

void draw_box() {
  for(int i=0; i<number; i++){
    for(int j=0; j<number; j++){
      int x = index_to_coordinate(i);
      int y = index_to_coordinate(j);
      
      rectMode(CENTER);
      if(boxes[i][j]==1)
        rect(x, y, SPACING, SPACING);
    }
  }
}

void clear_box() {
  for(int i=0; i<number; i++){
    for(int j=0; j<number; j++){
       boxes[i][j] = 0;
       affected_boxes[i][j] = 0;
    }
  }
}

void update_box() {
  for(int i=0; i<number; i++){
    for(int j=0; j<number; j++){
       boxes[i][j] = affected_boxes[i][j];
    }
  }
}

void check_box() {
  //1 alone = 0
  //1 two/three neighbours = 1
  //0 surrounded by 3 1's = 1
  //1 >3 neighbours = 0
  
  for(int i=0; i<number; i++){
    for(int j=0; j<number; j++){
       int neighbours = 0;
       
       int up = i-1;
       int down = i+1;
       int left = j-1;
       int right = j+1;
       
       if(up >= 0 && boxes[up][j]==1) neighbours += 1;
       if(left >= 0 && boxes[i][left]==1) neighbours += 1;
       if(right < number && boxes[i][right]==1) neighbours += 1;
       if(down < number && boxes[down][j]==1) neighbours += 1;
       if(up >= 0 && right < number && boxes[up][right]==1) neighbours += 1;
       if(up >= 0 && left >= 0 && boxes[up][left]==1) neighbours += 1;
       if(down < number && right < number && boxes[down][right]==1) neighbours += 1;
       if(down < number && left >= 0 && boxes[down][left]==1) neighbours += 1;
       
       if(boxes[i][j] == 0 && neighbours == 3) affected_boxes[i][j] = 1;
       else if(boxes[i][j] == 1 && neighbours == 0) affected_boxes[i][j] = 0;
       else if(boxes[i][j] == 1 && (neighbours == 2 || neighbours == 3)) affected_boxes[i][j] = 1;
       else if(boxes[i][j] == 1 && neighbours > 3) affected_boxes[i][j] = 0;
       else if(boxes[i][j] == 1 && neighbours < 2) affected_boxes[i][j] = 0;  
         
    }
  }
}

void setup() {
  size(1000, 1000);
  background(20,20,50);
  int col = 150;
  stroke(col,col,col+20);
  graph(EXTENT, SPACING, SPACING);
  populate_box();
  noLoop();
  
  
  
}

void draw() {
  
  background(20,20,50);
  graph(EXTENT, SPACING, SPACING);
  
  draw_box();
  
  textSize(100);
  text(str(GENERATION), 800, 900);
  //if(can_draw){
  //  int offset_x = int(SPACING)/2 - mouseX%int(SPACING);
  //  int offset_y = int(SPACING)/2 - mouseY%int(SPACING);
  //  rectMode(CENTER);
  //  rect(mouseX+offset_x, mouseY+offset_y, SPACING, SPACING);
  //}
  noLoop();
}

void mousePressed() {
  
}

void keyPressed(){
  if((key == 'r')||(key=='R')){
    println("Key pressed!!");
    clear_box();
    populate_box();
    GENERATION = 0;
    redraw();
  }
  if((key == 'w')||(key=='W')) {
    check_box();
    update_box();
    GENERATION++;
    redraw();
  }
}
