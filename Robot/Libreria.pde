


//Clase ScrollBar que genera una estructura Barra de Scrol
class HScrollbar {
  int posini;
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos,o_spos,o_newpos;    // x position of slider
  float sposMin, sposMax,o_sposMin,o_sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  int[] PColor;
  PImage imagen;
  
  //Agregamos un elemento figura al scrollbar
  int fposx,fposy;
  Botonera front, back;
  //Constructor de la clase que recibe, la posición donde estará, el tamaño de la barra, 
  //la posición de la imagen asociada que se mostrara cuando se utilice y la imagen de la pieza a mostrar
  HScrollbar (float xp, float yp, int sw, int sh, int l, int fx, int fy, String f, int pini) {
    posini = pini;
    swidth = sw;
    sheight = sh;
    imagen = loadImage("img/Robot/"+f+".png");
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    fposx = fx;
    fposy = fy;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + posini*((float)swidth/(180+sheight/1.6));
    o_newpos = newspos = spos;
    o_sposMin = sposMin = xpos;
    o_sposMax = sposMax = xpos + swidth - sheight;
    loose = l;
    
    front = new Botonera((int)(xpos+swidth),(int)(ypos-5),"img/icons/front.png","img/icons/front1.png");
    back = new Botonera((int)(xpos-25),(int)(ypos-5),"img/icons/back.png","img/icons/back1.png");
  }
  //Metodo que modifica el estado del scrollbar en la interfaz
  void update() {
    //Botones adelante y atras para mover el cursor mediante las flechas adelante y atras
    front.update();
    if(front.isPressed()){
      delay(100);
      image(imagen,fposx, fposy); //Indicamos la pieza a mover
      //Movemos 
      if(newspos < xpos+swidth-15){
      newspos += 1*((float)swidth/(180+sheight/1.6));
      }
    }
    back.update();
    if(back.isPressed()){
      
      delay(100);
      image(imagen,fposx, fposy); //Indicamos la pieza a mover
      //Movemos 
      if(newspos > xpos+1){
      newspos -= 1*((float)swidth/(180+sheight/1.6));
      }
        
    }
    //Comprobamos los estados de la barra, si el raton está encima, y si está presionando la barra
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if(mousePressed && !over){
      locked = false;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }
  //Metodo que devuelve la posición a traves de los valores de la posicion actual del cursor, la minima y la máxima
  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }
  //Metodo que devuelve el scrollbar a su posición original
  void Reset(){
    int widthtoheight = swidth - sheight;
    ratio = (float)swidth / (float)widthtoheight;
    spos = xpos + posini*((float)swidth/(180+sheight/1.6));
    newspos = o_newpos;

    }

   
    //Metodo que comprueba si el ratón está sobre el scrollbar 
  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }
  //Metodo que inicializa el scrollbar a sus valores predeterminados durante el proceso de ejecución.
  void display() {

    noStroke();
    front.display();
    back.display();
    fill(0);
    rect(xpos-3, ypos-3, swidth+6, sheight+6);
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(199,81,58);
      image(imagen,fposx, fposy);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }
  //Metodo que devuelve el valor del puntero del scrollbar
  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return (spos * ratio)-xpos;
  }
  //Metodo que devuelve el valor máximo que puede tener el puntero
  float getPMin(){return sposMin;}
  ///Metodo que devuelve el valor mínimo que puede tener el puntero
  float getPMax(){return sposMax;}
  
}

//Clase que envuelve mediante una estructura, el escrollbar el nombre, el grado y la imagen de cada servo
class Estructura{

  HScrollbar Hs;
  int ini;
  String Nombre;
  int Grado;
  int xpos, ypos;
  float swidth=300, sheigth=15;
  int id;
  //Metodo constructor que recibe la posición, el tamaño del escrolbar, la imagen, el nombre y la posición inicial que debe tener el scrollbar
  //Genera un identificador unico a cada estructura
  Estructura(int identf, int xp, int yp,String n,int fx, int fy, String foto, int pini){
    
    ini = pini;
    id = identf;
    Nombre = n;
    xpos = xp;
    ypos = yp;
    if(ini > 180){ini = 180;}
    if(ini < 0){ ini = 0;}
    Hs = new HScrollbar(xpos, ypos, (int)swidth,(int)sheigth, 1, fx, fy, foto, ini);
    Grado = 90;
    
  }
  //Metodo que devuelve el identificador del objeto
  int IdEstructura(){return id;}
  //Metodo que modifica durante la ejecución los valores de la estructura
  void update(){
    
    float PMin = Hs.getPMin();
    float PMax = Hs.getPMax();
    float Pos = Hs.getPos();
    Hs.update();

      Grado = (int)((PMin/PMax)+Pos*(180/swidth))-3;

    fill(0);
    textSize(15);
    text("Articulacion: "+Nombre+" a "+Grado+" º" , xpos+25, ypos-15);
  }
  void display(){
    Hs.display();
    
  }
  //Metodo que devuelve al valor inicial a la estructura
  void Reset(){
    Hs.Reset();
    Grado = ini;
  }
  //Metodo que devuelve el valor del grado del servo asignado a esa estructura
  int getPosition(){return Grado;}
};

//Clase que dada una lista de cadena, muestra un menú desplegable
class MenuDesplegable{
  String Seleccionado;
  String[] Menu;
  int posX, posY, sWidth, sHeight ;
  int longitud;
  int itemSeleccionado = 0;
  boolean seleccionado = false;
  Serial puerto;
  //Constructor de la clase
  public MenuDesplegable(String[] M, int pX, int pY, int sW, int sH, Serial p){
    Menu = M;
    puerto = p;
    longitud = M.length;
    if(longitud > 0){
    Seleccionado = M[0];
    }
    else{
      Seleccionado = "Menú";
    }
    posX = pX; posY = pY; sWidth = sW; sHeight = sH;
  }
  //Metodo que actualiza el estado del menú.
  public void Update(){
    
    if(isSelected(posX, posY, sWidth, sHeight)){
      seleccionado = true;
    }
    if(seleccionado){
      fill(#FFFFFF);//Pintamos el fondo en Blanco
      stroke(#000000); //Pintamos la linea en Negro
      rect(posX, posY, sWidth, sHeight);
      //Pintamos el texto en negro
      fill(#000000);
      text(Seleccionado, posX+10,posY +15);
      for(int i = 0; i < longitud; i++){
        fill(#939090);
        if(isOver(posX+15, posY+20*(i+1), sWidth, sHeight)){
          fill(#FFFFFF);}
        stroke(#000000); 
        rect(posX+15, posY+20*(i+1), sWidth, sHeight);
        fill(#000000);
        text(Menu[i], posX+20,posY+20*(i+1)+15);
        if(isSelected(posX+15, posY+20*(i+1), sWidth, sHeight)){
          itemSeleccionado = i;
          Seleccionado = Menu[i];
          seleccionado = false;
          escribirSerial(PathSerial, Seleccionado);
        }
      }
    }
  }
  //Metodo que inicializa el menú
  public void Display(){
    fill(#939090);//Pintamos el fondo en Gris
    stroke(#000000); //Pintamos la linea en Negro
    rect(posX, posY, sWidth, sHeight);
    //Pintamos el texto en negro
    fill(#000000);
    text(Seleccionado, posX+10,posY +15);
  }
  //Metodo que comprueba si el menú esta seleccionado
  private boolean isSelected(int px, int py, int sw, int sh){
    return (isOver(px, py, sw, sh) && mousePressed);
  }
  //Metodo que comprueba si el raton está sobre el menú.
  private boolean isOver(int px, int py, int sw, int sh){
    return (mouseX > px && mouseX < px+sw &&
       mouseY > py && mouseY < py+sh ); 
  }
}