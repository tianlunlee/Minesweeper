

import de.bezier.guido.*;
final static int NUM_ROWS = 30;
final static int NUM_COLS = 30;
boolean yaLost = false;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public ArrayList <MSButton> notBombs = new ArrayList <MSButton>();
void setup ()
{
    size(540, 600);
    textSize(10);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );

     buttons = new MSButton[NUM_ROWS][NUM_COLS];
   
    for(int j = 0; j < NUM_ROWS; j++){
        for(int i = 0; i < NUM_COLS; i++) {
            buttons[j][i] = new MSButton(j,i);
        }
    }

    //declare and initialize buttons
    setBombs();
}
public void setBombs()
{
    int row, col, num;
    num = (int)(Math.random()*5)+80;
    //num = 2;
    for(int q = 0; q < num; q++) {
        row = (int)(Math.random()*NUM_ROWS);
        col = (int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[row][col])){
            bombs.add(buttons[row][col]);
    }
    }

    


}
public void draw ()
{
    background( 0 );
    fill(100);
    rect(0,540, 540, 600);
    if(yaLost == true) 
        displayLosingMessage();

    if(isWon() && yaLost == false)
            displayWinningMessage();
}
    
  
public boolean isWon()
{
    //your code here

    int buttCount = 0;
        for (int j = 0; j < NUM_ROWS; j++) {
            for (int i = 0; i < NUM_COLS; i++) {
                if(!bombs.contains(buttons[j][i])) {
                    if (buttons[j][i].isClicked() == true) {
                        buttCount++;
                    }
                }
            }
        }

    
if(buttCount == (NUM_ROWS*NUM_COLS) - bombs.size()) {
    return true;

}

    return false;
}
public void displayLosingMessage()
{
    //your code here


    fill(255, 0, 0);
    textSize(32);
    text("congratulations, you lost", 270, 570);
    for (int r = 0; r < NUM_ROWS; r++) {
        for (int c = 0; c < NUM_COLS; c++) {
            if (bombs.contains(buttons[r][c]) && !buttons[r][c].isClicked()) {
                buttons[r][c].mousePressed();
            }
        }

    }
    textSize(10);

}
public void displayWinningMessage()
{
    //your code here
    fill(100);

    fill(0);
    textSize(32);
    text("win == true", 270, 570);
    textSize(10);
}


public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 540/NUM_COLS;
        height = 540/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    public void setClicked() {
        clicked = true;
    }
    public void mousePressed () 
    {
        if(mousePressed && mouseButton == RIGHT && !clicked) {
            marked = !marked;
        }
        else{

            clicked = true;
        if (bombs.contains(this)) {
            yaLost = true;

            displayLosingMessage();
        }
        else if (countBombs(r, c) > 0) {
            setLabel(str(countBombs(r, c)));
        
        }

        else {

            if(isValid(r,c-1) && !buttons[r][c-1].isClicked()) {
                buttons[r][c-1].mousePressed();
          }
            if(isValid(r,c+1) && !buttons[r][c+1].isClicked()) {
                buttons[r][c+1].mousePressed();
          }
            if(isValid(r+1,c) && !buttons[r+1][c].isClicked()) {
                buttons[r+1][c].mousePressed();
          }
            if(isValid(r-1,c) && !buttons[r-1][c].isClicked()){
                buttons[r-1][c].mousePressed();

        }
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked()) {
                buttons[r-1][c-1].mousePressed();
          }
            if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked()) {
                buttons[r+1][c+1].mousePressed();
          }
            if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked()) {
                buttons[r+1][c-1].mousePressed();
          }
            if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked()){
                buttons[r-1][c+1].mousePressed();

        }
}
    }
}

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);

        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r >= 0&& c >= 0 && r < NUM_ROWS && c < NUM_COLS) {
            return true;
        }

        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here

        //may need to check to see if neighboring buttons are valid
        for(int j = -1; j < 2; j++) {
            for (int i = -1; i< 2; i++) {
                if(isValid(row+j,col+i)&&bombs.contains(buttons[row+j][col+i])) {
                    numBombs++;
                    
                 } 
            }
        }
     
        return numBombs;
    }
    public void notBombs() {
        for (int j = 0; j < NUM_ROWS; j++) {
            for (int i = 0; i < NUM_COLS; i++) {
                if (!bombs.contains(buttons[j][i])) {
                    notBombs.add(buttons[j][i]);
                }
            }
        }
    }
}



