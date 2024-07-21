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
        image = loadImage(source_file);
        image.filter(GRAY);


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
