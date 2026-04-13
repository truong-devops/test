/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tranvantruong_22647761;

import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import org.apache.commons.io.IOUtils;
import org.json.JSONArray;

/**
 *
 * @author maccuatruong
 */
public class classAPI {
    public JSONArray docapi() {
        try {
            String url = "http://localhost:8080/html/TranVanTruong_22647761/TranVanTruong_taoapi/xem.php";
            return new JSONArray(IOUtils.toString(new URL(url).openStream(), Charset.forName("UTF-8")));
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void goiapi(String myurl) {
        try {
            HttpURLConnection con = (HttpURLConnection) new URL(myurl).openConnection();
            con.setRequestMethod("GET");
            con.getResponseCode();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
