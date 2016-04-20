package apacheThing;

import org.apache.http.HttpResponse;

import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;

import org.apache.http.impl.client.HttpClientBuilder;

public class ApacheTest {

	public static void main(String args[]) throws Exception {
		HttpClient client = HttpClientBuilder.create().build();
		HttpGet response = new HttpGet("http://google.com");
		HttpResponse httpResp = client.execute(response);
		int code = httpResp.getStatusLine().getStatusCode();
		System.out.println(code);

	}

}
