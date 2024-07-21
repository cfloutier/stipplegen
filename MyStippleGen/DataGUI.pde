import controlP5.*;  



class DataGUI
{
  public DataGUI(DataGlobal data)
  {
    this.data = data;
    images_ui = new ImageGUI(data.image); 
    dots_ui = new DotGUI(data.dots); 
  }

  DataGlobal data;
  ImageGUI images_ui;
  DotGUI dots_ui;

  void updateUI()
  {
    if (!data.changed)
      return;

    images_ui.update();
    dots_ui.update();  
  }

  void setupControls()
  { 
    cp5.addTab("Image");
    cp5.addTab("Dots");

    images_ui.setupControls(  ) ;
    dots_ui.setupControls(  );   
    
    cp5.getTab("Dots").bringToFront();
  }
  
  void setGUIValues()
  {
    images_ui.setGUIValues();
    dots_ui.setGUIValues();
  }
}

class DotGUI extends GUIPanel
{   
    DataDots data;

    public DotGUI(DataDots data)
    {
      this.data = data;
    }

    Slider CellSize;
    Slider DotDensity;
    Toggle Black;
    Toggle drawCells;
    
    void setupControls()
    {    
        super.Init("Dots");
        
        Black = addToggle("Black", "Black Dots", data); 
        
        nextLine();  
        drawCells = addToggle("drawCells", "Draw Cells", data); 
        
        CellSize = addSlider("CellSize", "Cell Size", data, 2, 40, true);          
        DotDensity = addSlider("DotDensity", "Dots Density", data, 1, 40, true);       
    }
    
    void update()        
    {
        
    }

    void setGUIValues()
    {
        CellSize.setValue(data.CellSize);
        DotDensity.setValue(data.DotDensity);
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
