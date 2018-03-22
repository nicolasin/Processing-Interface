
//Clase que encapsula los metodos y variables necesarias para mover un servo PFM
class ServoPFM {
private: 
   const int pul = 20;
   const int limiteAlto = 2000;
   const int limiteBajo = 1000;
  int grados;
  int pin;
  float freq;
public:  
  //Constructor de la clase que recibe un entero que será el pin donde está conectado.
  ServoPFM(int p){
    pin = p;
    pinMode(pin, OUTPUT);
    
    }
//Metodo que através de un grado, genera el movimiento del servo
void write(int grad){
         grados = grad;
         freq = map(grad, 180, 0, limiteAlto, limiteBajo);
         digitalWrite(pin, HIGH);
         delayMicroseconds(pul);
         digitalWrite(pin, LOW);
         delayMicroseconds(freq);
    }
    //Metodo que devuelve la posición actual del servo
int read(){ return grados;}  
};

unsigned long contador = millis();

ServoPFM  Servos1(0);
ServoPFM  Servos2(1);
ServoPFM  Servos3(2);
ServoPFM  Servos4(3);
ServoPFM  Servos5(4);
ServoPFM  Servos6(5);
ServoPFM  Servos7(6);
ServoPFM  Servos8(7);
ServoPFM  Servos9(8);
ServoPFM  Servos10(9);
ServoPFM  Servos11(10);
ServoPFM  Servos12(11);
ServoPFM  Servos13(12);
ServoPFM  Servos14(13);
ServoPFM  Servos15(14);
ServoPFM  Servo16(15);
int aux[16];
void setup() {
  Serial.begin(9600);

}

void loop() {
  String op ;
  String  angulo;
  String cadena;
  
  //Comprobamos si el puerto está libre
  while(Serial.available()){
    delay(3);
    //Si hay datos pendientes de leer en el puerto se leen 
    //caracter a caracter y se guardan en una cadena
    if(Serial.available()>0){
    char c = Serial.read();
    cadena +=c;
    }
  }
  //La cadena resultante se trata y se saca la información del servo y los grados a mover
  //y se guarda en variables de tipo int
    op = cadena.substring(0,2);
    angulo = cadena.substring(2, 5);
   int o = op.toInt();
   int grado = angulo.toInt();
    
   
   contador = millis();
   switch(o){
    case 1:
      while(millis() < (contador+500)){
          Servos1.write(grado);
      }
       contador = millis();
    break;
    case 2:    
      while(millis() < (contador+500)){
          Servos2.write(grado);
      }
       contador = millis();
    break;
    case 3:
      while(millis() < (contador+500)){
          Servos3.write(grado);
      }
       contador = millis();
    break;
    case 4:
      while(millis() < (contador+500)){
          Servos4.write(grado);
      }
       contador = millis();
    break;
    case 5:    
      while(millis() < (contador+500)){
          Servos5.write(grado);
      }
       contador = millis();
    break;
    case 6:
      while(millis() < (contador+500)){
          Servos6.write(grado);
      }
       contador = millis();
    break;
    case 7:
      while(millis() < (contador+500)){
          Servos7.write(grado);
      }
       contador = millis();
    break;
    case 8:    
      while(millis() < (contador+500)){
          Servos8.write(grado);
      }
       contador = millis();
    break;
    case 9:
      while(millis() < (contador+500)){
          Servos9.write(grado);
      }
       contador = millis();
    break;
    case 10:
      while(millis() < (contador+500)){
          Servos10.write(grado);
      }
       contador = millis();
    break;
    case 11:    
      while(millis() < (contador+500)){
          Servos11.write(grado);
      }
       contador = millis();
    break;
    case 12:
      while(millis() < (contador+500)){
          Servos12.write(grado);
      }
       contador = millis();
    break;
    case 13:
      while(millis() < (contador+500)){
          Servos13.write(grado);
      }
       contador = millis();
    break;
    case 14:    
      while(millis() < (contador+500)){
          Servos14.write(grado);
      }
       contador = millis();
    break;
    case 15:
      while(millis() < (contador+500)){
          Servos15.write(grado);
      }
       contador = millis();
    break;
    case 16:
      while(millis() < (contador+500)){
          Servos16.write(grado);
      }
       contador = millis();
    break;
}
}


