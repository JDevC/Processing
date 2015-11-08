public class TitleScreen{
  // ATRIBUTOS
  private PImage background;                                  // Contenedor de imagen de fondo
  private HashMap<String,HashMap<Float,Float>> titles = 
  new HashMap<String,HashMap<Float,Float>>();             // Contenedor de rótulos
  // CONSTRUCTOR
  public TitleScreen(){
    background = loadImage("backgroundMenu.png");
    HashMap<Float, Float> m = new HashMap<Float,Float>();
    m.put(150.0,200.0);
    titles.put("New Game",m);
    m.clear();
    m.put(150.0,230.0);
    titles.put("Load Game", m);
    m.clear();
    m.put(150.0,260.0);
    titles.put("Credits", m);
    m.clear();
    m.put(150.0,290.0);
    titles.put("Exit", m);
    m.clear();
  }
  // MÉTODOS/FUNCIONES
  public PImage getBackground(){
    return this.background;
  }
  public HashMap<String,HashMap<Float,Float>> getTitles(){
    return titles;
  }
  public HashMap<Float,Float> getTitle(String root){
    return titles.get(root);
  }
}