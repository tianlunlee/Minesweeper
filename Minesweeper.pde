

import de.bezier.guido.*;
final static int NUM_ROWS = 30;
final static int NUM_COLS = 30;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public ArrayList <MSButton> notBombs = new ArrayList <MSButton>();
void setup ()
{
    size(540, 540);
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

    for(int q = 0; q < num; q++) {
        row = (int)(Math.random()*NUM_ROWS);
        col = (int)(Math.random()*NUM_COLS);
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

        for (int i = 0; i < notBombs.size(); i++) {
            if (notBombs[i].isClicked() == false) {
                return false;
            }
    
    }


    return true;
}
public void displayLosingMessage()
{
    //your code here


}
public void displayWinningMessage()
{
    //your code here
    System.out.println("win");
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
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(keyPressed == true) {
            marked = !marked;
        }
        else if (bombs.contains(this)) {
            displayLosingMessage();
        }
        else if (countBombs(r, c) >0) {
            setLabel(Integer.toString(countBombs(r, c)));
        
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



