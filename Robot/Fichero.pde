

//Metodo Que recibe un fichero, y devuelve una cadena con el contenido de dicho fichero
String leerSerial(BufferedReader reader)
{
    String com ="";
  String line;
    try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    // Stop reading because of an error or file is empty
    noLoop();  
  } else {
    String[] pieces = split(line, TAB);
    
    //int y = int(pieces[1]);
    com = pieces[0];
  }
  return com;
}
//Metodo que dado una dirección de un fichero, y una cadena con información, Guarda los datos en el fichero especificado en el primer parámetro
void escribirSerial(String path, String COM)
{
   String[] list = split(COM, ' ');
  // Writes the strings to a file, each on a separate line
  saveStrings(path, list);
}