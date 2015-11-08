public class SnakeHead extends Bodies{
  // ATRIBUTOS
  private int vel = 1;
  private String dir;
  // CONSTRUCTOR
  public SnakeHead(float posX, float posY, int vel, int size, String dir){
    super();
    this.posX = posX;
    this.posY = posY;
    this.vel = vel;
    this.size = size;
    this.dir = dir;
  }
  // MÉTODOS
  // - Get/Set
  public int getVel(){
    return vel;
  }
  public String getDir(){
    return dir;
  }
  public void setVel(int vel){
    this.vel = vel;
  }
  public void setDir(String dir){
    this.dir = dir;
  }
  // Función para "pintar" la cabeza de serpiente
  public void print(){
    ellipse(this.posX, this.posY, this.size, this.size);
  }
}