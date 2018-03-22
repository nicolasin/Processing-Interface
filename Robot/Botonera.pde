//Clase que a través de una posición y dos imagenes realiza un boton en una zona específica de la interfaz.
class Botonera {
  PImage img1,img2;
  int xpos, ypos, bwidth, bheight;
  boolean over, locked;
//Constructor de la clase  
  Botonera(int xp, int yp, String icon1, String icon2){
    img1 = loadImage(icon1);
    img2 = loadImage(icon2);
    xpos = xp;
    ypos = yp;
    bwidth = 40;
    bheight = 40;
    locked = false;
    over = false;
   }
   //Metodo que devuelve si el boton está o no siendo presionado
    boolean isPressed(){
      if (mousePressed && overEvent()) {    
        return true;
      }
      else{
        return false;
      }
  }
  //Funcion que actualiza al boton
   void update() {
    if (mousePressed && overEvent()) {      
      locked = true;    }
    if (!mousePressed) {      locked = false;    }
    if (locked) {      image(img2,xpos,ypos);    }
  }
  //Funcion que indica si el cursor está encima del boton
  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+bwidth &&
       mouseY > ypos && mouseY < ypos+bheight) {
      return true;
    } else {
      return false;
    }
  }
 //Boton que inicializa los valores del boton
  void display() {
    noStroke();
    if (over || locked) {
      image(img2,xpos,ypos);
    } else {      
      image(img1,xpos,ypos);    
    }

  }
}

//Clase Movimiento, que guarda y reproduce los movimientos de los servos
class Movimiento{
  int Mov[][]; //Donde lo guardaremos
  private int cont;
  private int tam, xpos, ypos;
  //Constructor de la clase
  //Recibe el numero de movimientos que se van a guardar en la estructura, y la posicion donde aparecerán los cuadros de los movimientos
  Movimiento(int n, int xp, int yp){
    tam = n;
    xpos = xp;
    ypos = yp;
    Mov = new int[tam][tam];
    cont=0;
    for(int i = 0; i < tam; i++){
      for(int j = 0; j<tam;j++){
        Mov[i][j]=90;
      }
    }
   }
   void display(){
     
   }
   //Metodo que reproduce los movimientos que están guardado en la matriz en una posicion j y los envias por el puerto serial 
   void reproducir(int j){
     int k = j+1;
     String cadena="";
     if(k <= cont){
           strokeWeight(1);
           fill(179,47,47);
           rect(xpos+(k*20)+25,ypos,15,15);
            for(int i = 1; i < 17; i++){
                   if(i<10){cadena=+00+""+i;}
                  else{cadena=""+i;}
                  if(Mov[j][i-1] <10){cadena+="00"+Mov[j][i-1];}
                  else if(Mov[j][i-1] < 100){cadena+="0"+Mov[j][i-1];}
                  else{cadena+=""+Mov[j][i-1];}
                  
                  try{      
                    println(cadena);
                    port.write(cadena);
                    delay(25);
                  }catch(Exception e){}
                }
     }
  }
  //Metodo que actualiza el estado de los movimientos
   void update(){
     for(int i = 1; i < tam+1; i++){
       if(i <= cont){
           strokeWeight(1);
           fill(0);
           rect(xpos+(i*20)+25,ypos,15,15);
           text("Movimientos Guardados: "+cont, xpos+200,ypos+40);
       }
     }
   }
   //Metodo que permite agregar un secuencia de movimiento a la matriz
  void AddMove(int m[]){
    if(m.length==16 && cont < tam){
      for(int i = 0; i < 16; i++){
        Mov[cont][i]=m[i];
      }
    cont++;
    }
  }
   //Metodo que permite agregar un secuencia de movimiento a la matriz en una posición.
  void AddMove(int m[],int p){
    if(m.length==16 && cont < tam){
      for(int i = 0; i < 16; i++){
        Mov[p][i]=m[i];
      }
    cont++;
    }
  }
  //Devuelve el número de movimientos guardados
  int SetMoves(){return cont;}  
  //Resetea todos los movimientos y se borra la matriz guardada
  void ResetMove(){
    cont=0;
    for(int i = 0; i < tam; i++){
      for(int j = 0; j<16;j++){
        Mov[i][j]=90;
      }
    }
  }
}