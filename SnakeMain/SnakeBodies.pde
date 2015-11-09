public class SnakeBodies extends Bodies{
  // ATRIBUTOS
  private int vel = 1;                   // Velocidad de movimiento
  private String dir;                    // Dirección actual
  private ArrayList<String> directions;  // Lista de direcciones hacia las que se debe dirigir
  private ArrayList<Float> posNextX;     // Lista de coordenadas X en las que debe variar su movimiento
  private ArrayList<Float> posNextY;     // Lista de coordenadas Y en las que debe variar su movimiento
  // CONSTRUCTOR
  public SnakeBodies(){
    super();
  }
  public SnakeBodies(float posX, float posY, int vel, int size, String dir){
    super();
    this.posX = posX;
    this.posY = posY;
    this.vel = vel;
    this.size = size;
    this.dir = dir;
    this.directions = new ArrayList<String>();
    this.posNextX = new ArrayList<Float>();
    this.posNextY = new ArrayList<Float>();
  }
  // MÉTODOS
  // - Get/Set
  public int getVel(){
    return vel;
  }
  public String getDir(){
    return dir;
  }
  public ArrayList<String> getDirs(){
    return directions;
  }
  public ArrayList<Float> getArrayX(){
    return posNextX;
  }
  public ArrayList<Float> getArrayY(){
    return posNextY;
  }
  // Obtiene el siguiente punto de giro
  public ArrayList<Float> getNextPoint(){
    ArrayList nextPoint = new ArrayList<Float>();
    nextPoint.add(posNextX.get(0));
    nextPoint.add(posNextY.get(0));
    return nextPoint;
  }
  public void setVel(int vel){
    this.vel = vel;
  }
  public void setDir(String dir){
    this.dir = dir;
  }
  public void setNextDir(String dir){
    this.directions.add(dir);
  }
  public void setDirs(ArrayList<String> directions){
    this.directions = directions;
  }
  public void setArrayX(ArrayList<Float> posNextX){
    this.posNextX = posNextX;
  }
  public void setArrayY(ArrayList<Float> posNextY){
    this.posNextY = posNextY;
  }
  // Añade un punto de giro a la sección de cuerpo de la serpiente
  public void setNextPoint(Float x, Float y){
    this.posNextX.add(x);
    this.posNextY.add(y);
  }
  // Función para pintar el cuerpo de la serpiente
  public void print(){
    ellipse(this.posX, this.posY, this.size, this.size);
  }
  // Elimina el primer punto de giro almacenado
  public void removePoint(){
    this.directions.remove(0);
    this.posNextX.remove(0);
    this.posNextY.remove(0);
  }
  // Función de actualización de la sección de cuerpo
  public void update(){
    // Comprueba si ha llegado al siguiente punto de giro
    if(!this.posNextX.isEmpty()){
      if(this.posX == this.posNextX.get(0) && this.posY == this.posNextY.get(0)){
        // Sustituye la dirección actual con la siguiente almacenada, y la retira del array
        this.dir = this.directions.get(0);
        this.removePoint();
        // 
      }
    }
    switch(this.dir){
      case "w":
        this.setY(this.getY()-this.getVel());
      break;
      case "a":
        this.setX(this.getX()-this.getVel());
      break;
      case "s":
        this.setY(this.getY()+this.getVel());
      break;
      case "d":
        this.setX(this.getX()+this.getVel());
      break;
      default:
      break;
    }
  }
}