// PANTALLA MENÚ
TitleScreen tScreen;
PImage z;            // Contenedor de imagen de fondo
int titlesX = 150;   // Posición X de los rótulos
int newGameY = 200;
int loadGameY = 230;
int creditsY = 260;
int exitY = 290;
boolean[] posCursor = new boolean[4];
// Dimensiones de la pantalla
final int dimm = 500;
// Objetos serpiente
SnakeHead head;
SnakeBodies body;
ArrayList<SnakeBodies> bodies;
// Parámetros de la pelota (alimento)
Ball ball;
boolean eaten = false;  // True = no hay (generar nueva pelota); false = hay pelota en el campo
// Puntos
int score = 0; // Define los puntos conseguidos por el jugador, 1 punto por cada bolita consumida
// Extras
boolean initGame = false;  // Variable para iniciar la partida
boolean toggle = false;    // Activa/Desactiva estadísticas de debug
String k = "";             // Variable de almacenamiento de teclas pulsadas

void settings() {
  //fullScreen();
  /* Esta función determina las dimensiones de la ventana, o "Canvas". Los números pasados por parámetro equivalen a píxeles,
   * siendo cada unidad 1 píxel. NOTA: En condiciones normales, esta instrucción se utiliza dentro de la función setup(), pero
   * si queremos que las dimensiones de la ventana se puedan definir mediante variables, hemos de incluir esta instrucción
   * en la función settings(), disponible en Processing 3
   */
  size(dimm, dimm);
}

void setup(){
  // INICIALIZACIÓN PANTALLA DE MENÚ
  tScreen = new TitleScreen();
  z = tScreen.getBackground();
  for(int i = 0; i < posCursor.length; i++){
    posCursor[i] = false;
  }
  posCursor[0] = true;
  // INICIALIZACIÓN PANTALLA DE JUEGO
  int pos = 50;
  // Creamos la instancia de la cabeza de serpiente
  head = new SnakeHead(pos,50,1,20,"d");
  // Creamos tres segmentos del cuerpo por defecto
  bodies = new ArrayList<SnakeBodies>();
  for(int i = 0; i < 3; i++){
    bodies.add(new SnakeBodies(pos-10,50,1,20,"d"));
    pos -= 10;
  }
  // Situamos una pelota en una zona aleatoria del tablero
  ball = new Ball(random(5,496),random(5,496),10);
}

void draw(){
  if(initGame){
    // Pinta el campo
    field();
    // Filtra la entrada de datos por teclado, limitándola a 5 botones
    if(keyPressed){
      k = String.valueOf(key).toLowerCase();
      //print("Before: "+k+"\n");
      // Comprueba que sólo se haya pulsado una de las teclas aceptadas para el juego
      if(k.equals("w") || k.equals("a") || k.equals("s") || k.equals("d")){
        // Impide que la cabeza de serpiente se superponga al resto de su cuerpo
        if(k.equals("w") && !head.getDir().equals("s")){
          // Asigna la dirección a la cabeza de serpiente
          head.setDir(k);
          /* Agrega la misma dirección a las secciones existentes, añadiendo además
           * el punto en el que ha cambiado el rumbo */
          for(int i = 0; i < bodies.size(); i++){
            bodies.get(i).setNextDir(k);
            bodies.get(i).setNextPoint(head.getX(),head.getY());
          }
        }else if(k.equals("s") && !head.getDir().equals("w")){
          head.setDir(k);
          for(int i = 0; i < bodies.size(); i++){
            bodies.get(i).setNextDir(k);
            bodies.get(i).setNextPoint(head.getX(),head.getY());
          }
        }else if(k.equals("a") && !head.getDir().equals("d")){
          head.setDir(k);
          for(int i = 0; i < bodies.size(); i++){
            bodies.get(i).setNextDir(k);
            bodies.get(i).setNextPoint(head.getX(),head.getY());
          }
        }else if(k.equals("d") && !head.getDir().equals("a")){
          head.setDir(k);
          for(int i = 0; i < bodies.size(); i++){
            bodies.get(i).setNextDir(k);
            bodies.get(i).setNextPoint(head.getX(),head.getY());
          }
        }
      }else if(k.equals("e")){
        if(toggle){
          toggle = false;
        }else{
          toggle = true;
        }
      }
    }
    // Escoge la acción a realizar en función de la tecla capturada
    //switch(dir){
    switch(head.getDir()){
      case "w":
        /* Obtiene la coordenada Y de la cabeza y le resta el valor de la velocidad. Finalmente, reasigna a la coordenada Y 
         * el resultado obtenido */
        head.setY(head.getY()-head.getVel());
        // Realiza el efecto de looping en el extremo superior de la pantalla
        if(head.getY() < -head.getSize()/2){
          head.setY(dimm + head.getSize()/2);
        }
        // Realiza el movimiento de las secciones del cuerpo
        for(int i = 0; i < bodies.size(); i++){
          // Comprueba si la actual ha llegado al punto en el que ha girado la cabeza
          /*ArrayList<Float> nextPoint = bodies.get(i).getNextPoint();
          if(bodies.get(i).getX() == nextPoint.get(0) && bodies.get(i).getY() == nextPoint.get(1)){
            bodies.get(i).setY(bodies.get(i).getY()-bodies.get(i).getVel());
            // Realiza el efecto de looping en el extremo superior de la pantalla
            if(bodies.get(i).getY() < -bodies.get(i).getSize()/2){
              bodies.get(i).setY(dimm + bodies.get(i).getSize()/2);
            }
          }else{
            
          } */
          //bodies.get(i).setY(bodies.get(i).getY()-bodies.get(i).getVel());
          bodies.get(i).update();
          // Realiza el efecto de looping en el extremo superior de la pantalla
          if(bodies.get(i).getY() < -bodies.get(i).getSize()/2){
            bodies.get(i).setY(dimm + bodies.get(i).getSize()/2);
          }
        }
      break;
      case "a":
        head.setX(head.getX()-head.getVel());
        if(head.getX() < -head.getSize()/2){
          head.setX(500 + head.getSize()/2);
        }
        for(int i = 0; i < bodies.size(); i++){
          //bodies.get(i).setX(bodies.get(i).getX()-bodies.get(i).getVel());
          bodies.get(i).update();
          if(bodies.get(i).getX() < -bodies.get(i).getSize()/2){
            bodies.get(i).setX(dimm + bodies.get(i).getSize()/2);
          }
        }
      break;
      case "s":
        head.setY(head.getY()+head.getVel());
        if(head.getY() > dimm+head.getSize()/2){
          head.setY(-head.getSize()/2);
        }
        for(int i = 0; i < bodies.size(); i++){
          //bodies.get(i).setY(bodies.get(i).getY()+bodies.get(i).getVel());
          bodies.get(i).update();
          if(bodies.get(i).getY() > dimm+bodies.get(i).getSize()/2){
            bodies.get(i).setY(-bodies.get(i).getSize()/2);
          }
        }
      break;
      case "d":
        head.setX(head.getX()+head.getVel());
        if(head.getX() > dimm+head.getSize()/2){
          head.setX(-head.getSize()/2);
        }
        for(int i = 0; i < bodies.size(); i++){
          //bodies.get(i).setX(bodies.get(i).getX()+bodies.get(i).getVel());
          bodies.get(i).update();
          if(bodies.get(i).getX() > dimm+bodies.get(i).getSize()/2){
            bodies.get(i).setX(-bodies.get(i).getSize()/2);
          }
        }
      break;
      default:
      break;
    }
    // Si no hay pelota, se generan coordenadas aleatorias para la posición de la nueva
    if(eaten){
      ball.setX(random(5,496));
      ball.setY(random(5,496));
      eaten = false;
    }
    // Pinta la pelota sobre la posición asignada
    ball.print();
    // Pinta la cabeza de la serpiente en la posición actualizada
    head.print();
    // Pinta 
    for(int i = 0; i < bodies.size(); i++){
      bodies.get(i).print();
    }
    // Evalúa si hay colisión entre la cabeza de serpiente y la pelota
    if(collide()){
      // Ejecuta la acción ("Se come" la pelota)
      eaten = eat();
    }
    // Muestra el letrero con la puntuación del jugador
    marks(score);
    // Debug auxiliar (Muestra las coordenadas de la cabeza de serpiente
    if(toggle){
      debug();
    }
  }else{
    // Pintamos el fondo
    fill(255,255,255);
    rect(0,0,500,500);
    fill(0,0,0);
    // Situamos la imagen de fondo de pantalla
    imageMode(CENTER);
    image(z, width/2, height/2, width, height);
    // Situamos el cursor
    arrow();
    // Mostramos los rótulos
    textSize(50);
    text("SNAKE", titlesX, 100);
    textSize(30);
    text("New Game", titlesX, newGameY);
    text("Load Game", titlesX, loadGameY);
    text("Credits", titlesX, creditsY);
    text("Exit", titlesX, exitY);
  }
}
// FUNCIONES -----------------------------------------------------------------------------------------------------------------
// Esta función "limpia" la ventana (usado para los movimientos)
void field(){
  fill(0,250,0);
  rect(0,0,width,height);
  fill(250,250,250);
}

// Define el movimiento de toda la serpiente

// Esta función detalla las instrucciones a ejecutar en caso de colisión cabeza-pelota
boolean eat(){
  SnakeBodies b = new SnakeBodies();
  switch(bodies.get(bodies.size()-1).getDir()){
    case "w":
      b = new SnakeBodies(
        bodies.get(bodies.size()-1).getX(),
        bodies.get(bodies.size()-1).getY()+10,
        bodies.get(bodies.size()-1).getVel(),
        20,
        bodies.get(bodies.size()-1).getDir());
    break;
    case "a":
      b = new SnakeBodies(
        bodies.get(bodies.size()-1).getX()+10,
        bodies.get(bodies.size()-1).getY(),
        bodies.get(bodies.size()-1).getVel(),
        20,
        bodies.get(bodies.size()-1).getDir());
    break;
    case "s":
      b = new SnakeBodies(
        bodies.get(bodies.size()-1).getX(),
        bodies.get(bodies.size()-1).getY()-10,
        bodies.get(bodies.size()-1).getVel(),
        20,
        bodies.get(bodies.size()-1).getDir());
    break;
    case "d":
      b = new SnakeBodies(
        bodies.get(bodies.size()-1).getX()-10,
        bodies.get(bodies.size()-1).getY(),
        bodies.get(bodies.size()-1).getVel(),
        20,
        bodies.get(bodies.size()-1).getDir());
    break;
  }
  b.setDirs(bodies.get(bodies.size()-1).getDirs());
  b.setArrayX(bodies.get(bodies.size()-1).getArrayX());
  b.setArrayY(bodies.get(bodies.size()-1).getArrayY());
  bodies.add(b);
  /*bodies.add(new SnakeBodies(
    bodies.get(bodies.size()-1).getX()-10,
    bodies.get(bodies.size()-1).getY(),
    bodies.get(bodies.size()-1).getVel(),
    20,
    bodies.get(bodies.size()-1).getDir()));*/
  // Se pinta el espacio de la pelota en "blanco", dando la impresión de que ha desaparecido
  stroke(0,250,0);
  fill(0,250,0);
  ball.print();
  stroke(0,0,0);
  fill(250,250,250);
  // Se suman al marcador los puntos obtenidos al obtener la pelota 
  score += ball.getScore();
  // Si has conseguido alcanzar una puntuación múltiplo de 10, conseguirás más puntos, pero avanzarás más rápido
  if(score % 10 == 0){
    ball.addPoint();
    head.setVel(head.getVel()+1);
    for(int i = 0; i < bodies.size(); i++){
      //bodies.get(i).setVel(bodies.get(i).getVel()+1);
      bodies.get(i).setVel(head.getVel());
    }
  }
  return true;
}

// Función simple para detectar colisiones
boolean collide(){
  /* Primero, comprueba la distancia entre coordenadas, mediante:
   *   abs(x1 - x2);
   *   abs(y1 - y2);
   * - No sabemos cuál de ambos valores es mayor, así que en vista de que el resultado pueda salir negativo, utilizamos
   *   la función abs(), que devuelve el valor absoluto de ese resultado (es decir, sin signo)
   * 
   * A continuación, comprobamos que ambas distancias sean menores que la distancia entre el centro de ambos cuerpos (la cabeza
   * de serpiente y la pelota, en este caso). 
   *
   */
  if(abs(ball.getX() - head.getX()) < 15 && abs(ball.getY() - head.getY()) < 15){
    return true;
  }
  return false;
}

// Muestra la puntuación en todo momento
void marks(int puntos){
  fill(0,0,0);
  textSize(32);
  text("Points:"+puntos, 10, 30);
  fill(255,255,255);
}

// Se lanza al pulsar una tecla del teclado
void keyPressed(){
  // Detecta tecla de subida en la pantalla de menú
  if(!initGame){
    if(key == 'w'){
      // Comprueba que no sea la primera opción de todas
      if(posCursor[0] != true){
        // Busca la posición del cursor
        for(int i = 1; i < posCursor.length; i++){
          // Si la encuentra, la pone a false, y pone a true la opción superior  
          if(posCursor[i] == true){
            posCursor[i] = false;
            posCursor[i-1] = true;
            break;
          }
        }
      }
    }else if(key == 's'){
      // Comprueba que no sea la primera opción de todas
      if(posCursor[posCursor.length-1] != true){
        // Busca la posición del cursor
        for(int i = 0; i < posCursor.length-1; i++){
          // Si la encuentra, la pone a false, y pone a true la opción superior  
          if(posCursor[i] == true){
            posCursor[i] = false;
            posCursor[i+1] = true;
            break;
          }
        }
      }
    }else if(key == ENTER){
      if(posCursor[0] == true){
        initGame = true;
      }else if(posCursor[3] == true){
        System.exit(0);
      }
    }
  }
}

// Pinta el cursor del menú de inicio
void arrow(){
  if(posCursor[0]){
    triangle(titlesX,newGameY-10,120,newGameY+10,120,newGameY-30);
    stroke(0,0,0);
    fill(255,255,255);
    rect(titlesX, newGameY+5,170,-30);
  }else if(posCursor[1]){
    triangle(titlesX,loadGameY-10,120,loadGameY+10,120,loadGameY-30);
    fill(255,255,255);
    rect(titlesX, loadGameY+5,170,-30);
  }else if(posCursor[2]){
    triangle(titlesX,creditsY-10,120,creditsY+10,120,creditsY-30);
    fill(255,255,255);
    rect(titlesX, creditsY+5,170,-30);
  }else if(posCursor[3]){
    triangle(titlesX,exitY-10,120,exitY+10,120,exitY-30);
    fill(255,255,255);
    rect(titlesX, exitY+5,170,-30);
  }
  fill(0,0,0);
}
// Función para debug
void debug(){
  fill(0,0,0);
  textSize(15);
  text("Coord X:"+head.getX(), 10, 400);
  text("Coord Y:"+head.getY(), 10, 420);
  text("Velocity:"+head.getVel(), 10, 440);
  text("Bodies:"+bodies.size(), 10, 460);
  fill(255,255,255);
}