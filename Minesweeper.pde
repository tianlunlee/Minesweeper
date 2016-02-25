

import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
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
    num = (int)(Math.random()*60)+30;

    for(int q = 0; q < num; q++) {
        row = (int)(Math.random()*20);
        col = (int)(Math.random()*20);
        if(!bombs.contains(buttons[row][col])){
            bombs.add(buttons[row][col]);
    }
    }
    System.out.print(bombs.size());
    


}
public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
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
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(keyPressed == true) {
            clicked = !clicked;
        }
        else if (bombs.contains(this)) {
            displayLosingMessage();
        }
        else if (countBombs(r, c) >0) {
            setLabel(Integer.toString(countBombs(r, c)));
        
        }
        if(!bombs.contains(buttons[r][c])) {

            if(isValid(r,c-1) && !buttons[r][c-1].isMarked()) {
                buttons[r][c-1].mousePressed();
          }
            if(isValid(r,c+1) && !buttons[r][c+1].isMarked()) {
                buttons[r][c+1].mousePressed();
          }
            if(isValid(r+1,c) && !buttons[r+1][c].isMarked()) {
                buttons[r+1][c].mousePressed();
          }
            if(isValid(r-1,c) && !buttons[r-1][c].isMarked()){
                buttons[r-1][c].mousePressed();

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
        if(r >= 0&& c >= 0 && r < 20 && c < 20) {
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
}



