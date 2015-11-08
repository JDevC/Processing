// VARIABLES
int num = 0;
// Objeto serpiente
Snake prot;
// Parámetros de la pelota (alimento)
Ball ball;
float ballX = 0;
float ballY = 0;
boolean eaten = false;  // True = no hay (generar nueva pelota); false = hay pelota en el campo
// Puntos
int score = 0; // Define los puntos conseguidos por el jugador, 1 punto por cada bolita consumida
// Extras
boolean toggle = false;

/* La función setup(), aunque no aparezca por defecto al crear un nuevo sketch, es vital para inicializar constantes, utilizar
 * funciones de carga previa de elementos y disponer todo lo necesario para que el código comience a trabajar en buenas
 * condiciones. Es recomendable dejarlo escrito nada más empezar a programar.
 */
void setup(){
  /* Esta función determina las dimensiones de la ventana, o "Canvas". Los números pasados por parámetro equivalen a píxeles,
   * siendo cada unidad 1 píxel.
   */
  size(500, 500);
  prot = new Snake(50,50,1,20,'d');
  ball = new Ball(random(5,496),random(5,496),10);
}

/* La función draw(), junto con la función setup(), forma el bloque general que debe aparecer en todo código de Processing.
 * Mientras que setup() es una función de paso, destinada a "preparar el terreno" para la ejecución del código, draw() va a ser
 * la función principal que contenga todo el código general del programa, ejecutándose en bucle de forma perpetua hasta su
 * interrupción, o salida del programa. Es recomendable dejarlo escrito nada más empezar a programar, junto con setup().
 */
void draw(){
  // Pinta el campo
  field();
  // Filtra la entrada de datos por teclado, limitándola a 5 botones
  if(keyPressed){
    if(key == 'w' || key == 'a' || key == 's' || key == 'd'){ 
      //dir = key;
      prot.setDir(key);
    }else if(key == 'e'){
      if(toggle){
        toggle = false;
      }else{
        toggle = true;
      }
    }
  }
  // Escoge la acción a realizar en función de la tecla capturada
  //switch(dir){
  switch(prot.getDir()){
    case 'w':
      //posY -= vel;
      prot.setY(prot.getY()-prot.getVel());
    break;
    case 'a':
      //posX -= vel;
      prot.setX(prot.getX()-prot.getVel());
    break;
    case 's':
      //posY += vel;
      prot.setY(prot.getY()+prot.getVel());
    break;
    case 'd':
      //posX += vel;
      prot.setX(prot.getX()+prot.getVel());
    break;
    default:
    break;
  }
  // Si no hay pelota, se generan coordenadas para la posición de la nueva
  if(eaten){
    //ballX = random(0,500);
    //ballY = random(0,500);
    ball.setX(random(5,496));
    ball.setX(random(5,496));
    eaten = false;
  }
  //ellipse(ballX, ballY,10, 10);
  ball.print();
  // Pinta la cabeza de la serpiente en la posición actualizada
  //ellipse(prot.getX(), prot.getY(), prot.getSize(), prot.getSize());
  prot.print();
  // Evalúa si hay colisión entre la cabeza de serpiente y la pelota
  if(collide()){
    // Ejecuta la acción ("Se come" la pelota)
    eaten = eat();
  }
  // Muestra el letrero con la puntuación del jugador
  marks(score);
  // Debug auxiliar
  if(toggle){
    debug();
  }
}

// Esta función "limpia" la ventana (usado para los movimientos)
void field(){
  fill(0,250,0);
  rect(0,0,500,500);
  fill(250,250,250);
}

// Muestra la puntuación en todo momento
void marks(int puntos){
  textSize(32);
  text("Points:"+puntos, 10, 30);
}

// Esta función detalla las instrucciones a ejecutar en caso de colisión cabeza-pelota
boolean eat(){
  stroke(0,250,0);
  fill(0,250,0);
  //ellipse(ballX, ballY,10, 10);
  ball.print();
  stroke(0,0,0);
  fill(250,250,250);
  score++;
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
  //if(abs(ballX - posX) < 15 && abs(ballY - posY) < 15){
  //if(abs(ballX - prot.getX()) < 15 && abs(ballY - prot.getY()) < 15){
    if(abs(ball.getX() - prot.getX()) < 15 && abs(ball.getY() - prot.getY()) < 15){
    return true;
  }
  return false;
}

// Función para debug
void debug(){
  textSize(15);
  //text("Coord X:"+posX, 10, 400);
  //text("Coord Y:"+posY, 10, 430);
  text("Coord X:"+prot.getX(), 10, 400);
  text("Coord Y:"+prot.getY(), 10, 430);
}