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
  // MÉTODOS
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
  // Función para "pintar" la pelota
  public void print(){
    ellipse(this.posX, this.posY, this.size, this.size);
  }
}