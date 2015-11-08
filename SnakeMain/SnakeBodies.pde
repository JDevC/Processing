public class SnakeBodies extends Bodies{
  // ATRIBUTOS
  private int vel = 1;
  private String dir;
  private ArrayList<HashMap<Float,Float>> pipes;
  // CONSTRUCTOR
  public SnakeBodies(float posX, float posY, int vel, int size, String dir){
    super();
    this.posX = posX;
    this.posY = posY;
    this.vel = vel;
    this.size = size;
    this.dir = dir;
    this.pipes = new ArrayList<HashMap<Float,Float>>();
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
  public HashMap<Float,Float> getPoint(){
    return this.pipes.get(0);
  }
  // Función para pintar el cuerpo de la serpiente
  public void print(){
    ellipse(this.posX, this.posY, this.size, this.size);
  }
  // Añade un punto de giro a la sección de cuerpo de la serpiente
  public void setPoint(float x, float y){
    HashMap coord = new HashMap<Float,Float>();
    coord.put(x,y);
    this.pipes.add(coord);
  }
  // Elimina el primer punto de giro
  public void removePoint(){
    this.pipes.remove(0);
  }
}