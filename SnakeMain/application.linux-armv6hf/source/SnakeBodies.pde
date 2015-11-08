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
  // MÉTODOS
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