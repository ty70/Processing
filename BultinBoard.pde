final String inFile = "ABCtitle.txt";  // ABC の問題タイトルテキスト
final String boxFile = "boxcolor.txt"; // 問題のボックスの色が格納されている 
final int side = 25;                   // 行間隔
final int offsetx = 120;               // 問題タイトルを書き出す最初の位置
int N;                                 // ABC の回数
String[][] Titles;                     // Titles[i][0]: i 行目のABCコンテスト名 Titles[i][1..4]: A,B,C,D の問題タイトル 
int[][] BoxColor;                      // 問題のボックスの色 0: まだ手を付けていない 1:AC 2:自力で出来なかった 3:やったけどまだ無理

void setup(){
 size(1636, 768);
 surface.setTitle("ABCTitle");
 colorMode(RGB,255);
 String[] inLines = loadStrings(inFile);
 N = inLines.length;
 Titles = new String[N][30];

// println("N: " + N);
 for (int i = 0; i < N; ++i){
   String[] titles = splitTokens(inLines[i]);
//   print("n: " + titles.length + " ");
   for (int j = 0; j < titles.length; ++j){
//     print(titles[j] + " ");
     Titles[i][j] = titles[j];
   } // end for
   println("");
 } // end for
 
 BoxColor = new int[N][4];
 String[] boxLines = loadStrings(boxFile);
 for (int i = 0; i < N; ++i){
   String[] boxColors = splitTokens(boxLines[i]);
   for (int j = 0; j < 4; ++j){
     BoxColor[i][j] = Integer.parseInt(boxColors[j]);
   } // end for
 } // end for
}

void draw(){
  stroke(220,220,220);
  for (int i = 0; i < N; ++i){
    fill(255,255,255);
    rect(0, i * side, offsetx, side);
    for (int j = 0; j < 4; ++j){
      int col = BoxColor[i][j];
      switch(col){
        case 0:
          fill(255,255,255);
          break;
        case 1: // 自信を持って出来る問題
          fill(222,240,216);
          break;
        case 2: // 自分で出来なかった問題
          fill(252,165,216);
          break;
        case 3: // やったけどまだ無理
          fill(252,248,227);
          break;
        default:
          fill(255,255,255);
          break;
      } // end switch
      rect(offsetx + 400 * j, i * side, 400, 200);
    } // end for
    println("");
  } // end for
  textSize(side);
  fill(81,138,185);
  for (int i = 0; i < N; ++i){
    text(Titles[i][0], 10, i * side);
    for (int j = 1; j < 5; ++j){
      text(Titles[i][j], offsetx + 400*(j-1), (i+1) * side);
    } // end for
  } // end for
//  println("mouseX: " + mouseX + " mouseY: " + mouseY);
}

void mousePressed(){
 int x = mouseX;
 int y = mouseY;
 x = x - offsetx;
 x /= 400;
 y /= side;
 BoxColor[y][x] = (BoxColor[y][x] + 1) % 4;
}

void keyPressed(){
  if (key == 's'){
    PrintWriter file;
    file = createWriter(boxFile);
    for (int i = 0; i < N; ++i){
      for (int j = 0; j < 4; ++j){
        file.print(BoxColor[i][j]);
        if (j != 4 - 1){
          file.print(" ");
        }else{
          file.println("");
        } // end if
      } // end for
    } // end for
    file.flush();
    file.close();
    println("save boxcolor.txt");
    delay(1500);
  } // end if
}
