package apacheThing;

import java.io.IOException;
import java.util.Arrays;
import java.util.Scanner;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.HttpClients;

public class HealthTest {

	public static void main(String[] args) throws IOException {

		new HealthTest().scanDis();

	}

	public void scanDis() throws ClientProtocolException, IOException {
		System.out.println("Type 'signin', 'apns', 'upload', or 'all' to start testing");
		Scanner sc = new Scanner(System.in);
		String s = "";
		s = sc.nextLine();

		if (s.toLowerCase().equalsIgnoreCase("signin")) {
			signIn();
		}

		else if (s.toLowerCase().equalsIgnoreCase("apns")) {

			apnsCheck();
		}

		else if (s.toLowerCase().equalsIgnoreCase("upload")) {
			// System.out.println("Not done yet");
			uploadCheck();
		} else if (s.toLowerCase().equalsIgnoreCase("all")) {
			signIn();
			apnsCheck();
			uploadCheck();
		} else {
			System.out.println("Wrong input please try again");
			scanDis();
		}

		sc.close();
	}

	public void smallerChecks() {

	}

	public void signIn() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpPost httpost = new HttpPost("http://cloud.vivalnk.com/api/signin");

		String idk = "{\"email\":\"breakfastturkey@gmail.com\",\"password\":\"123456\"}";
		httpost.setEntity(new ByteArrayEntity(idk.getBytes("UTF-8")));
		httpost.setHeader("Content-Type", "application/json");

		HttpResponse response = client.execute(httpost);

		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("signin response success: " + response.getStatusLine().getStatusCode());
		}

		else {
			System.out.println("signin error, running REST health check...\n");
			restCheck();
		}

		Header[] h = response.getAllHeaders();
		System.out.println(Arrays.toString(h));

		Header h1 = response.getFirstHeader("Authorization");
		httpost.setHeader(h1);

	}

	public void uploadCheck() throws ClientProtocolException, IOException {
		HttpClient client = HttpClients.custom().build();

		HttpPost httpost = new HttpPost("http://cloud.vivalnk.com/api/signin");

		String mainS = "{\"email\":\"f@f.com\",\"password\":\"123456\"}";
		httpost.setEntity(new ByteArrayEntity(mainS.getBytes("UTF-8")));
		httpost.setHeader("Content-Type", "application/json");
		

		HttpResponse response = client.execute(httpost);
		Header h1 = response.getFirstHeader("Authorization");
		String first = h1.toString();
		String second = first.substring(15);
		System.out.println(second);
		System.out.println(h1);

		HttpPost httpost1 = new HttpPost("http://cloud.vivalnk.com/api/148/uploadBatchData");

		String idk = "{\"noteText\":\"Note Added\"}";
		httpost.setEntity(new ByteArrayEntity(idk.getBytes("UTF-8")));
		httpost1.setHeader("Content-Type", "application/json");
		httpost1.setHeader("Authorization", second);

		HttpResponse response1 = client.execute(httpost1);

		// System.out.println("Upload Response: " +
		// response1.getStatusLine().getStatusCode());
		if (response1.getStatusLine().getStatusCode() == 200) {
			System.out.println("upload success: " + response1.getStatusLine().getStatusCode());
		} else {
			System.out.println("upload error, running REST check...\n");
			uploadrestCheck();
		}
	}

	public void apnsCheck() throws ClientProtocolException, IOException {
		HttpClient client = HttpClients.custom().build();
		HttpPost httpost = new HttpPost("http://cloud.vivalnk.com/api/triggernotification");

		String idk = "{\"accountID\":\"118\", \"deviceToken\":\"212212\", \"message\":\"Notification Triggered\"}";
		httpost.setEntity(new ByteArrayEntity(idk.getBytes("UTF-8")));
		httpost.setHeader("Content-Type", "application/json");

		HttpResponse response = client.execute(httpost);

		System.out.println("Did you receive a notification? (Y/N)");
		Scanner sc = new Scanner(System.in);
		String s = "";
		s = sc.nextLine();
		
		if(s.equalsIgnoreCase("Y"))
		{
			System.out.println(response.getStatusLine());
			System.out.println("Notification success!\n");
		}
		
		else
		{
			System.out.println(s);
			System.out.println("apns error, running REST check\n");
			apnsrestCheck();
		}
		sc.close();

	}

	public void restCheck() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet("http://cloud.vivalnk.com");

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			redisCheck();
		}

		else {
			System.out.println("Your error lies in REST");
		}
	}

	public void redisCheck() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet("http://cloud.vivalnk.com/api/healthcheck/redis");

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			rdsCheck();
		}

		else {
			System.out.println("Your problem lies in Redis\n");
		}
	}

	public void rdsCheck() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet("http://cloud.vivalnk.com/api/healthcheck/rds");

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			rdsCheck();
		}

		else {
			System.out.println("Your problem lies in Redis\n");
		}
	}

	public void apnsrestCheck() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet("http://cloud.vivalnk.com");

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			apnsredisCheck();
		}

		else {
			System.out.println("Your error lies in REST\n");
		}
	}

	public void apnsredisCheck() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet("http://cloud.vivalnk.com/api/healthcheck/redis");

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			apnssqsCheck();
		}

		else {
			System.out.println("Your problem lies in Redis\n");
		}
	}

	public void snsCheck() {

	}

	public void uploadrestCheck() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet("http://cloud.vivalnk.com");

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			uploadredisCheck();
		}

		else {
			System.out.println("Your error lies in REST");
		}
	}

	public void uploadredisCheck() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet("http://cloud.vivalnk.com/api/healthcheck/redis");

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			uploadsqsCheck();
		}

		else {
			System.out.println("Your problem lies in Redis");
		}
	}

	public void apnssqsCheck() throws ClientProtocolException, IOException {
		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet("http://cloud.vivalnk.com/api/healthcheck/notificationSQS");

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			snsCheck();
		}

		else {
			System.out.println("Your problem lies in SQS");
		}
	}

	public void uploadsqsCheck() throws ClientProtocolException, IOException {
		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet("http://cloud.vivalnk.com/api/healthcheck/notificationSQS");

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			// data upload processor test
			System.out.println("Not finished");
		}

		else {
			System.out.println("Your problem lies in SQS");
		}
	}

}