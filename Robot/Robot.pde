import processing.serial.*;
//DECLARACION DE VARIABLES y OBJETOS

String PathSerial = "conf/Serial.txt"; //Dirección del fichero de configuracion del serial
Serial port;//Puerto por el que se mandará la información
Estructura Barras[];  //Estructura que contendrá las barras, nombre, grado y demás información de los servos
BufferedReader reader; 
//Listas de Control
int cambios[];//Para controlar los cambios en los servos en cada iteracción
//Nombre de cada Servo
String nombres[]={"Hombro Izq","Hombro Drc","Brazo Izq","Brazo Drc","Codo Izq", "Codo Drc", "Cadera Izq", "Cadera Drc", "Pierna Izq", "Pierna Drc", "Rodilla Izq", "Rodilla Drc", "Pie Izq", "Pie Drc", "Tobillo Izq", "Tobillo Drc"};
//Nombre de las fotos de cada Servo
String fotos[]={"HombroIzq","HombroDrc","BrazoIzq","BrazoDrc","CodoIzq", "CodoDrc", "CaderaIzq", "CaderaDrc", "PiernaIzq", "PiernaDrc", "RodillaIzq", "RodillaDrc", "PieIzq", "PieDrc", "TobilloIzq", "TobilloDrc"};
//Posición de las fotos de cada servo
int posicion[][]={{433,20},{688,11},{419,70},{714,43},{394,123},{727,108},{566,261},{681,267},{498,266},{635,284},{554,410},{691,419},{552,540},{707,575},{553,476},{697,492}};
//Posición inicial de cada servo
int posicionIni[]={90,90,0,90,75,45,39,90,90,180,90,90,0,90,180,90};
MenuDesplegable MenuSerial;  //Declaración del menú desplegable para los puertos Serial
Movimiento movimientos; //Declaración de la clase que contendrá los movimientos de cada servo

//Variables para el control de acceso a los botones de la interfaz principal
  PImage Robot, fondo, Informacion, Ayuda; 
  boolean reproducir;
  int pos;
  int contReproducir;
Object e = new Object(); //Objeto para tratar las distintas excepciones

//String[] lista = {"COM0", "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7"}; LISTA DE PRUEBA PARA EL MENU DE LOS SERIALS
Botonera Play, Stop, Reset, Info, Nosotros, Guardar; //Declaracion de los botones de la interfaz.
void setup()
{
  //Abrimos el fichero de configuración y leemos el puerto escogido
  reader = createReader(PathSerial); 
  String COM = leerSerial(reader);
  //Declaracion de los botones de la interfaz
  Play = new Botonera(1100,600,"img/icons/play.png","../img/icons/play2.png");
  Stop = new Botonera(1150,600,"img/icons/stop.png","../img/icons/stop2.png");
  Reset = new Botonera(1196,596,"img/icons/reset.png","../img/icons/reset2.png");
  Guardar  = new Botonera(1246,600,"img/icons/guardar.png","../img/icons/guardar2.png");
  Info = new Botonera(1150,1,"img/icons/info.png","../img/icons/info2.png");
  Nosotros = new Botonera(1220,1,"img/icons/nosotros.png","../img/icons/nosotros2.png");
  Ayuda = loadImage("img/Informacion/Funciones.png");
  Informacion = loadImage("img/Informacion/Nosotros.png");
  //Indicamos que no se está reproduciendo ningún movimiento.
  reproducir = false;
  //Se declara la cantidad de movimientos para la reproducción y la posicion donde se representará los cuadros de la reproducción
  movimientos = new Movimiento(16,950,660); 
  contReproducir = 0;
  pos = 0;
  //CONEXION a través del puerto serial.
 try{
      port = new Serial(this, COM, 9600);
  }catch(Exception e){
    println("Puerto Ocupado");  
  }
  MenuSerial = new MenuDesplegable(Serial.list(), 1050,10,75,20, port);
  
  //Cargamos el robot de la interfaz principal.
  Robot = loadImage("img/Completo1.png");
  
  //INICIALIZACION DE LOS SCROLLBARS
  size(1366,720);
  Barras = new Estructura[16];
  for(int i = 0 ; i < 16; i++){
    Barras[i] = new Estructura(i+1, 100, (i+1)*40, nombres[i],posicion[i][0], posicion[i][1],fotos[i], posicionIni[i]) ;

  }
  //POSICIONAMIENTO INICIAL
  //INICIALIZAMOS LOS SERVOS A SU GRADO CORRESPONDIENTE
  for(int i = 1; i < 17; i++){
    String cadena="";
    if(i<10){cadena=+00+""+i;}
    else{cadena=""+i;}
    if(posicionIni[i-1] <10){cadena+="00"+posicionIni[i-1];}
    else if(posicionIni[i-1] < 100){cadena+="0"+posicionIni[i-1];}
    else{cadena+=""+posicionIni[i-1];}
    
    try{      
      println(cadena);
      port.write(cadena);
      delay(200);
    }catch(Exception e){}
  }
  //Cambiamos los cambios para que estén según la posición principal de cada servo.
  cambios = posicionIni;
  
}

void draw()
{
  //Cargamos fondo y robot en la interfaz principal
  background(255);
  image(Robot, 450, 50);
  //MOSTRAMOS y ACTUALIZAMOS OBJETOS INICIALIZADOS
      MenuSerial.Display();
      MenuSerial.Update();
      Play.display();
      Play.update();
      Stop.display();
      Stop.update();
      Reset.display();
      Reset.update();
      Guardar.display();
      Guardar.update();
      Info.display();
      Info.update();
      Nosotros.display();
      Nosotros.update();
      movimientos.display();
      movimientos.update();
      for(int i = 0; i < 16; i++){
        Barras[i].display();
        Barras[i].update();
      }
  //OPCIONES AL PRESIONAR BOTONES
  if(Nosotros.isPressed()){ //Boton Nosotros
    image(Informacion, 450,75);
  }
  if(Info.isPressed()){    //Boton Información
    image(Ayuda, 300,75);
  }
  if(Play.isPressed() && movimientos.SetMoves()>=1){reproducir = true;}  //Boton Reproducir
    if(Stop.isPressed() || contReproducir>movimientos.SetMoves()){reproducir = false;contReproducir=0;}  //Boton Stop
    //Comprobación si alguno de los botones está presionado
    if(reproducir==true){
      if(Stop.isPressed() || contReproducir>movimientos.SetMoves()){reproducir = false;contReproducir=0;}
        delay(100);
        movimientos.reproducir(contReproducir);
        contReproducir++;
  }
   if(Reset.isPressed()){//Resetea todos los valores y lo pone el 
    for(int i = 0; i <16;i++){
      Barras[i].Reset();
      movimientos.ResetMove();
      pos=0;
    }
  }
  if(Guardar.isPressed()){//Guarda los movimientos cuando se pulsa
    delay(200);
    int []MovAux = new int[16];
    for(int i = 0; i < 16; i++){
      MovAux[i]=Barras[i].getPosition();
    }
    movimientos.AddMove(MovAux,pos);
    pos++;
  }
  
  
  
  //MOVIMIENTOS DE LOS SERVOS cuando se realizan uno a uno
  
  for(int i = 0; i < 16; i++){
    //Buscamos el grado de cada servo y comprobamos si se han realizado cambios sobre dicho servo
    if(cambios[i]!=Barras[i].getPosition()){
      //Si se han realizado, formateamos la información para generar la cadena en el formato necesario
        String cadena="";
        int id = Barras[i].IdEstructura();//Dada el indice del servo y el grado que queremos mandar
        //los formateamos según el formato IDGRADO Ejmplo(01180)
        int grados = Barras[i].getPosition();
          if(id<10){cadena=+00+""+id;}
          else{cadena=""+id;}
          if(grados <10){cadena+="00"+grados;}
          else if(grados < 100){cadena+="0"+grados;}
          else{cadena+=""+grados;}
          try{
        port.write(cadena);//Enviamos la información de cada servo cuando este es modificado
          }catch(Exception e){//println("Error al enviar los datos");
          }
       cambios[i] = grados; //los grados antiguos se igualan con los recientes
    }
  }
 for(int i = 0; i < 180; i++){
    try{
    
    }catch(Exception e){print("Error al leer fichero");} 
  }
  
}
  