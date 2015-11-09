public class Bodies{
  // ATRIBUTOS
  protected float posX;    // Coordenada X actual
  protected float posY;    // Coordenada Y actual
  protected int size;      // Tamaño del elemento
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