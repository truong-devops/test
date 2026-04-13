/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ontap2;

import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import org.apache.commons.io.IOUtils;
import org.json.JSONArray;

/**
 *
 * @author My PC
 */
public class classapi {
    public JSONArray docapi(){
        try {
            String url ="http://localhost/ontap1/taoapi/xem.php";
            return  new JSONArray(IOUtils.toString(new URL(url).openStream(),Charset.forName("UTF-8")));
            
        } catch (Exception e) {
            
            e.printStackTrace();
    }
        return null;
      
}
    
    public  void goiurl(String myurl) {
        try {
            HttpURLConnection con =(HttpURLConnection) new URL(myurl).openConnection();
            con.setRequestMethod("GET");
            con.connect();
            
            String kq  = IOUtils.toString(con.getInputStream(),Charset.forName("UTF-9"));
            System.out.println("ontap2.classapi.goiurl() :"+kq);
        } catch (Exception e) {
        }
        
    }
}
