package org.example;
import java.net.*;

public class Testingsomething {

	public static void main(String[] args) throws Exception {
        URL url = new URL("https://google.com");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        int i = connection.getResponseCode();
        System.out.println("Response code: " + i);
    }
}
