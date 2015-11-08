public class Ball extends Bodies{
  // ATRIBUTOS
  private int score = 1;
  // CONSTRUCTOR
  public Ball(float posX, float posY, int size){
    super();
    this.posX = posX;
    this.posY = posY;
    this.size = size;
  }
  // MÉTODOS
  // - Get/Set
  public int getScore(){
    return score;
  }
  // Función para "pintar" la pelota
  public void print(){
    ellipse(this.posX, this.posY, this.size, this.size);
  }
  // Función para aumentar su puntuación al recogerlo
  public void addPoint(){
    score++;
  }
}