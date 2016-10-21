

void setup() {
  size(400, 300);
  background(255);
  smooth();
    
  plot(20,20,200,100, -20, 30);
  
  //plot(0,0,400,300, -20, 30);
  
}

double targetFunc(double x) {
  //return x*x;
  //return 100/x;
  //return log((float)x)-sin((float)x);
  return sin((float)x);
}

void plot(int scrX, int scrY, int scrW, int scrH, float fx1, float fx2) {
    
  // just a future patch, maybe
  int tStartX=0, tStartY=0;
  
  // creat a new canvas
  PGraphics pg;
  pg = createGraphics(scrW+1, scrH+1);
  pg.beginDraw();
  pg.background(250);
  
  // draw the graph boundary
  //pg.stroke(128);  
  //pg.rectMode(CORNER);
  //pg.rect(tStartX, tStartY, scrW, scrH);
  
  //-- plot the graph
  pg.stroke(0); 
  
  // make some calc
  
  // just make sure
  float x1 = min(fx1, fx2);
  float x2 = max(fx1, fx2);
  
  double deltaX = x2 - x1;
  deltaX = deltaX/scrW;
  double deltaY = deltaX; // currently we use the same steps of both X and Y.
  
  int lastX=-1, lastY=-1;
  
  for(int sX=tStartX; sX<tStartX+scrW; sX++) { 
    
    // a conversion from screen-X to math-X
    double tFuncX = (sX-tStartX) * deltaX + fx1;
    
    //println("sX="+sX+"; fX="+tFuncX);
    
    double tFuncY=-1;
    boolean isFailed = false;
    try 
    {
      tFuncY = targetFunc(tFuncX);    
    } catch(Exception e) {
      println("Exception when x=="+tFuncX+",with: "+e);
      isFailed = true;
    } 
    
    if (!isFailed) {
      
      // a conversion from math-Y to screen-Y
      int sY = (int)(-(tFuncY / deltaY) + tStartY + scrH);  
      
      if (lastX!=-1) {  // skip the first time and the failed ones
        // connect the new point and the previous point with a line
        pg.line((float)lastX, (float)lastY, (float)sX, (float)sY);
      }else{
        pg.ellipse(sX, sY, 1, 1);
      }  
      
      lastX = sX;
      lastY = sY;
    
    }
          
  } // end for  
  
  pg.stroke(160); 
  // draw a X axie
  pg.line(tStartX, tStartY+scrH, tStartX+scrW+5, tStartY+scrH);
  // draw a Y axie  
  int scrX_o = (int)(((double)(0 - fx1)) / deltaX + tStartX); 
  pg.line(scrX_o, tStartY-5, scrX_o, tStartY+scrH);
  
  pg.endDraw();
  image(pg, scrX, scrY); 
  
}

void draw() {
   
}