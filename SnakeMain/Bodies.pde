public class Bodies{
  // ATRIBUTOS
  protected float posX;
  protected float posY;
  protected int size;
  // CONSTRUCTOR
  public Bodies(){
    
  }
  // MÉTODOS/FUNCIONES
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
}