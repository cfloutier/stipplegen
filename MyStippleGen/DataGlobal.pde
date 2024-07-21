import controlP5.*; 

class DataDots
{
    boolean Black = false;
    float CellSize = 4;
    float DotDensity = 10;
    int seed = 0;
    
    boolean drawCells = false;


    void LoadJson(JSONObject src)
    {
        if (src == null)
          return;
      
      
        Black = src.getBoolean("Black", Black);
        CellSize = src.getFloat("CellSize", CellSize);
        DotDensity = src.getFloat("DotDensity", DotDensity);
        seed = src.getInt("seed", seed);    
    }

    JSONObject SaveJson()
    {
        JSONObject dest = new JSONObject();


        dest.setBoolean("Black", Black);
        dest.setFloat("CellSize", CellSize);
        dest.setFloat("DotDensity", DotDensity);

        return dest;
    }
}

class DataGlobal
{
    String name = "";
    
    
    DataImage image = new DataImage();
    DataDots dots = new DataDots();
    Style style = new Style();

    //this field is modified by the UIPanel
    //on any UI change
    boolean changed = true;
    
    float width = 800;
    float height = 600;
    
    void setSize(float width, float height)
    {
        if (this.width != width)
        {
            changed = true;
            this.width = width;
        }
        
        if (this.height != height)
        {
            changed = true;
            this.height = height;
        }
    }
    
    String sketch_name()
    {
        return image.source_file.substring(0, image.source_file.length() - 4);  
    }  



  void LoadJson(String path)
  {
    print("path" + path);
    
    JSONObject json = loadJSONObject(path);

    image.LoadJson(json.getJSONObject("Image"));
    dots.LoadJson(json.getJSONObject("Dots"));
    style.LoadJson(json.getJSONObject("Style"));
  }

  void SaveJson(String path)
  {
    JSONObject json = new JSONObject();

    json.setJSONObject("Style", style.SaveJson());
    json.setJSONObject("Image", image.SaveJson());
    json.setJSONObject("Dots", dots.SaveJson());

    saveJSONObject(json, path);
  }

}
