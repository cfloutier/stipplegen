
String SOURCE_FOLDER = "sourcesImages";

class DataImage
{
    String source_file = "eye.jpg";

    float Width = 500;
    float ImageAlpha = 0;
    int   Blur = 2; 
    int Contrast = 0;

    PImage image = null;

    public void setImage(String source_file)
    {
        this.source_file = source_file;

        try {
          image = loadImage(SOURCE_FOLDER+"/"+source_file);
          image.filter(GRAY);
        }
        catch(Exception e) {
          image = null;

          println("error loading " + source_file);
          return;
        }
        
        println("Loading source file " + source_file);

        //image.filter(BLUR, 20);
    }

    // computed
    float Height()
    {
        if (image == null)
            return 0;
        
        return image.height * Width / image.width;
    }

    void LoadJson(JSONObject src)
    {
        if (src == null)
          return;
      
        Width = src.getFloat("Width", Width);  
        
        ImageAlpha = src.getFloat("ImageAlpha", ImageAlpha);
        Blur = src.getInt("Blur", Blur);
        Contrast = src.getInt("Contrast", Contrast);
        
        setImage(src.getString("source_file", source_file));
    }

    JSONObject SaveJson()
    {
        JSONObject dest = new JSONObject();

        dest.setFloat("Width", Width);    
        dest.setString("source_file", source_file);

        dest.setFloat("ImageAlpha", ImageAlpha);
        dest.setInt("Blur", Blur);
        dest.setFloat("Contrast", Contrast);

        return dest;
    }
}


class ImageGUI extends GUIPanel
{ 
    DataImage data;

    public ImageGUI(DataImage data)
    {
      this.data = data;
    }

    void update()
    {   
        if (data.source_file == "")
            file_Label.setText("please select a file");
        else
            file_Label.setText(data.source_file);
    }
    
    Slider Width;
    Slider ImageAlpha;
    Slider Blur;
    
    Textlabel file_Label;
    
    void setupControls()
    {   
        super.Init("Image");
        
        addButton("SelectSourceImage");
        file_Label = addLabel("File Label");            
        nextLine();
        
        Width = addSlider("Width", "Width", data, 200, 2000, true); 
        ImageAlpha = addSlider("ImageAlpha", "Image Alpha", data, 0, 255, true);
        
        Blur = addIntSlider("Blur", "Blur", data, 1, 20, true);
        
       // updateUI();
    }

    void setGUIValues()
    {
        Width.setValue(data.Width);
        ImageAlpha.setValue(data.ImageAlpha);
        Blur.setValue(data.Blur);
    }
}

void SelectSourceImage(float theValue) {  
  println(":::LOAD JPG, GIF or PNG FILE:::");

  selectInput("Select a file to process:", "imgFileSelected");  // Opens file chooser
} //End Load File

void imgFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    //println("User selected " + selection.getAbsolutePath());

    String loadPath = selection.getAbsolutePath();
    loadPath = loadPath.replaceAll("\\", "/");
    String[] p = splitTokens(loadPath, "/");
    String parent_dir = p[p.length - 2];
    String file_name = p[p.length - 2];
    

    // If a file was selected, print path to file 
    println("Selected file: " + file_name); 
    println("parent_dir : " + parent_dir); 

    if (parent_dir != SOURCE_FOLDER)
    {
        println("Invalid Folder. Image must be in "+SOURCE_FOLDER);
        return; 
    }

    p = splitTokens(loadPath, ".");
    boolean fileOK = false;
    String extension = p[p.length - 1].toLowerCase();

    if ( extension.equals("gif"))
      fileOK = true;      
    if ( extension.equals("jpg"))
      fileOK = true;   
    if ( extension.equals("tga"))
      fileOK = true;   
    if ( extension.equals("png"))
      fileOK = true;   

    println("File extension OK: " + fileOK);

    data.image.setImage(loadPath);
  }
}
