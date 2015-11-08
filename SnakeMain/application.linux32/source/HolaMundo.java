import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class HolaMundo extends PApplet {

// VARIABLES
int num = 0;
// Objeto serpiente
Snake prot;
// Par\u00e1metros de la pelota (alimento)
Ball ball;
float ballX = 0;
float ballY = 0;
boolean eaten = false;  // True = no hay (generar nueva pelota); false = hay pelota en el campo
// Puntos
int score = 0; // Define los puntos conseguidos por el jugador, 1 punto por cada bolita consumida
// Extras
boolean toggle = false;

/* La funci\u00f3n setup(), aunque no aparezca por defecto al crear un nuevo sketch, es vital para inicializar constantes, utilizar
 * funciones de carga previa de elementos y disponer todo lo necesario para que el c\u00f3digo comience a trabajar en buenas
 * condiciones. Es recomendable dejarlo escrito nada m\u00e1s empezar a programar.
 */
public void setup(){
  /* Esta funci\u00f3n determina las dimensiones de la ventana, o "Canvas". Los n\u00fameros pasados por par\u00e1metro equivalen a p\u00edxeles,
   * siendo cada unidad 1 p\u00edxel.
   */
  
  prot = new Snake(50,50,1,20,'d');
  ball = new Ball(random(5,496),random(5,496),10);
}

/* La funci\u00f3n draw(), junto con la funci\u00f3n setup(), forma el bloque general que debe aparecer en todo c\u00f3digo de Processing.
 * Mientras que setup() es una funci\u00f3n de paso, destinada a "preparar el terreno" para la ejecuci\u00f3n del c\u00f3digo, draw() va a ser
 * la funci\u00f3n principal que contenga todo el c\u00f3digo general del programa, ejecut\u00e1ndose en bucle de forma perpetua hasta su
 * interrupci\u00f3n, o salida del programa. Es recomendable dejarlo escrito nada m\u00e1s empezar a programar, junto con setup().
 */
public void draw(){
  // Pinta el campo
  field();
  // Filtra la entrada de datos por teclado, limit\u00e1ndola a 5 botones
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
  // Escoge la acci\u00f3n a realizar en funci\u00f3n de la tecla capturada
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
  // Si no hay pelota, se generan coordenadas para la posici\u00f3n de la nueva
  if(eaten){
    //ballX = random(0,500);
    //ballY = random(0,500);
    ball.setX(random(5,496));
    ball.setX(random(5,496));
    eaten = false;
  }
  //ellipse(ballX, ballY,10, 10);
  ball.print();
  // Pinta la cabeza de la serpiente en la posici\u00f3n actualizada
  //ellipse(prot.getX(), prot.getY(), prot.getSize(), prot.getSize());
  prot.print();
  // Eval\u00faa si hay colisi\u00f3n entre la cabeza de serpiente y la pelota
  if(collide()){
    // Ejecuta la acci\u00f3n ("Se come" la pelota)
    eaten = eat();
  }
  // Muestra el letrero con la puntuaci\u00f3n del jugador
  marks(score);
  // Debug auxiliar
  if(toggle){
    debug();
  }
}

// Esta funci\u00f3n "limpia" la ventana (usado para los movimientos)
public void field(){
  fill(0,250,0);
  rect(0,0,500,500);
  fill(250,250,250);
}

// Muestra la puntuaci\u00f3n en todo momento
public void marks(int puntos){
  textSize(32);
  text("Points:"+puntos, 10, 30);
}

// Esta funci\u00f3n detalla las instrucciones a ejecutar en caso de colisi\u00f3n cabeza-pelota
public boolean eat(){
  stroke(0,250,0);
  fill(0,250,0);
  //ellipse(ballX, ballY,10, 10);
  ball.print();
  stroke(0,0,0);
  fill(250,250,250);
  score++;
  return true;
}

// Funci\u00f3n simple para detectar colisiones
public boolean collide(){
  /* Primero, comprueba la distancia entre coordenadas, mediante:
   *   abs(x1 - x2);
   *   abs(y1 - y2);
   * - No sabemos cu\u00e1l de ambos valores es mayor, as\u00ed que en vista de que el resultado pueda salir negativo, utilizamos
   *   la funci\u00f3n abs(), que devuelve el valor absoluto de ese resultado (es decir, sin signo)
   * 
   * A continuaci\u00f3n, comprobamos que ambas distancias sean menores que la distancia entre el centro de ambos cuerpos (la cabeza
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

// Funci\u00f3n para debug
public void debug(){
  textSize(15);
  //text("Coord X:"+posX, 10, 400);
  //text("Coord Y:"+posY, 10, 430);
  text("Coord X:"+prot.getX(), 10, 400);
  text("Coord Y:"+prot.getY(), 10, 430);
}
class Ball{
    // ATRIBUTOS
  private float posX;
  private float posY;
  private int size;
  // CONSTRUCTOR
  public Ball(float posX, float posY, int size){
    this.posX = posX;
    this.posY = posY;
    this.size = size;
  }
  // M\u00c9TODOS
  // - Get/Set
  public float getX(){
    return posX;
  }
  public float getY(){
    return posY;
  }
  public int getSize(){
    return size;
  }
  public void setX(float x){
    this.posX = x;
  }
  public void setY(float y){
    this.posY = y;
  }
  public void setSize(int size){
    this.size = size;
  }
  // Funci\u00f3n para "pintar" la pelota
  public void print(){
    ellipse(this.posX, this.posY, this.size, this.size);
  }
}
class Snake{
  // ATRIBUTOS
  private int posX;
  private int posY;
  private int vel = 1;
  private int size;
  private char dir;
  // CONSTRUCTOR
  public Snake(int posX, int posY, int vel, int size, char dir){
    this.posX = posX;
    this.posY = posY;
    this.vel = vel;
    this.size = size;
    this.dir = dir;
  }
  // M\u00c9TODOS
  // - Get/Set
  public int getX(){
    return posX;
  }
  public int getY(){
    return posY;
  }
  public int getVel(){
    return vel;
  }
  public int getSize(){
    return size;
  }
  public char getDir(){
    return dir;
  }
  public void setX(int x){
    this.posX = x;
  }
  public void setY(int y){
    this.posY = y;
  }
  public void setVel(int vel){
    this.vel = vel;
  }
  public void setSize(int size){
    this.size = size;
  }
  public void setDir(char dir){
    this.dir = dir;
  }
  // Funci\u00f3n para "pintar" la cabeza de serpiente
  public void print(){
    ellipse(this.posX, this.posY, this.size, this.size);
  }
}
class SnakeBodies{
    // ATRIBUTOS
  private int posX;
  private int posY;
  private int vel = 1;
  private int size;
  private char dir;
  // CONSTRUCTOR
  public SnakeBodies(int posX, int posY, int vel, int size, char dir){
    this.posX = posX;
    this.posY = posY;
    this.vel = vel;
    this.size = size;
    this.dir = dir;
  }
  // M\u00c9TODOS
  // - Get/Set
  public int getX(){
    return posX;
  }
  public int getY(){
    return posY;
  }
  public int getVel(){
    return vel;
  }
  public int getSize(){
    return size;
  }
  public char getDir(){
    return dir;
  }
  public void setX(int x){
    this.posX = x;
  }
  public void setY(int y){
    this.posY = y;
  }
  public void setVel(int vel){
    this.vel = vel;
  }
  public void setSize(int size){
    this.size = size;
  }
  public void setDir(char dir){
    this.dir = dir;
  }
}
  public void settings() {  size(500, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "HolaMundo" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
