/**
 * 
 * VivaLnk HealthCheck 1.0
 * Created by Kunal Palwankar on 4/11/16
 * Copyright © Kunal Palwankar. All rights reserved
 * 
 */


package apacheThing;

import java.io.IOException;
import java.util.Scanner;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;


public class HealthCheck {

	private static final String BASE_URL="http://vivalnkwebtest-env.us-west-1.elasticbeanstalk.com";
	private static final String EMAIL = "breakfastturkey@gmail.com";
	private static final String PASSWORD = "123456";
	private static final Integer ACCOUNT_ID = 152;
	private static String option = "";
	private static String token = "xxxxxxxxxxx";
	private boolean signInSuccess = false;
	private static final String HEALTH_TOKEN="VIVAHEALTHCHECKTOKEN";

	public static void main(String[] args) throws IOException {
		new HealthCheck().scanDis();
	}

	/**
	 * Responsible for handling requests
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void scanDis() throws ClientProtocolException, IOException {
		System.out.println("Type 'signin', 'apns', 'upload', or 'all' to start testing");
		Scanner sc = new Scanner(System.in);
		String s = sc.nextLine();
		option = s.toLowerCase();

		if (option.equals("signin")) {
			signIn();
			if(signInSuccess)
				signout(token);
		}
		else if (option.equals("apns")) {
			signIn();
			if(signInSuccess){
				apnsCheck();
				signout(token);
			}
		}
		else if (option.equals("upload")) {
			signIn();
			if(signInSuccess){
				uploadCheck();
				signout(token);
			}
		} else if (option.equals("all")) {
			signIn();
			apnsCheck();
			uploadCheck();
			if(signInSuccess)
				signout(token);

		} else {
			System.out.println("Wrong input please try again");
			scanDis();
		}
		sc.close();
	}


	/**
	 * Sign In Flow
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void signIn() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpPost httpost = new HttpPost(BASE_URL+"/api/signin");

		String body = "{\"email\":\""+EMAIL+"\",\"password\":\""+PASSWORD+"\"}";
		httpost.setEntity(new ByteArrayEntity(body.getBytes("UTF-8")));
		httpost.setHeader("Content-Type", "application/json");

		HttpResponse response = client.execute(httpost);

		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("signin response success: " + response.getStatusLine().getStatusCode());
			token = response.getFirstHeader("Authorization").getValue();
			signInSuccess=true;
		}
		else {
			System.out.println("signin error, running REST health check...\n");
			System.out.println(EntityUtils.toString(response.getEntity()));
			token=HEALTH_TOKEN;
			restCheck();
		}
	}

	/**
	 * Data Upload Flow
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void uploadCheck() throws ClientProtocolException, IOException {
		HttpClient client = HttpClients.custom().build();

		HttpPost httpost = new HttpPost(BASE_URL+"/api/profile/"+ACCOUNT_ID+"/uploadBatchData");

		String body = "[{\"profileId\":\"807\",\"accountId\":\""+ACCOUNT_ID+"\",\"noteText\":\"Health Check\"},{\"profileId\":\"807\",\"accountId\":\""+ACCOUNT_ID+"\",\"noteText\":\"Health Check\"}]";
		httpost.setEntity(new ByteArrayEntity(body.getBytes("UTF-8")));
		httpost.setHeader("Content-Type", "application/json");
		httpost.setHeader("Authorization",token);
		httpost.setHeader("email",EMAIL);
		httpost.setHeader("password",PASSWORD);

		HttpResponse response = client.execute(httpost);

		if (response.getStatusLine().getStatusCode() == 200) {
			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			HttpGet httget = new HttpGet(BASE_URL+"/api/healthcheck/verifyUploadCount?accountId="+ACCOUNT_ID);
			httget.setHeader("Authorization",token);
			httget.setHeader("email",EMAIL);
			httget.setHeader("password",PASSWORD);

			HttpResponse getResponse = client.execute(httget);
			int resCount = Integer.parseInt(EntityUtils.toString(getResponse.getEntity()));
			if(resCount==2)
				System.out.println("upload success: ");
			else{
				System.out.println("error, running upload SQS Check \n");
				uploadsqsCheck();
			}
		} else {
			System.out.println("upload error, running REST check...\n");
			System.out.println(EntityUtils.toString(response.getEntity()));
			restCheck();
		}
	}

	/**
	 * SNS Flow
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void apnsCheck() throws ClientProtocolException, IOException {
		HttpClient client = HttpClients.custom().build();
		HttpPost httpost = new HttpPost(BASE_URL+"/api/triggerNotification");

		String idk = "{\"accountId\":\""+ACCOUNT_ID+"\", \"deviceToken\":\"212212\", \"message\":\"Notification Triggered\"}";
		httpost.setEntity(new ByteArrayEntity(idk.getBytes("UTF-8")));
		httpost.setHeader("Content-Type", "application/json");
		httpost.setHeader("Authorization",token);
		httpost.setHeader("email",EMAIL);
		httpost.setHeader("password",PASSWORD);

		HttpResponse response = client.execute(httpost);

		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("Did the phone recieve a notification? (Y/N)");
			Scanner sc = new Scanner(System.in);
			String s = "";
			s = sc.nextLine();
			if(s.equalsIgnoreCase("y"))
			{
				System.out.println("apns success ...");
			}
			else
			{
				System.out.println("error, running apns SQS check...\n");
				apnssqsCheck();
			}
			sc.close();

		} else {
			System.out.println("apns error, running REST check...\n");
			System.out.println(EntityUtils.toString(response.getEntity()));
			restCheck();
		}
	}

	/**
	 * Checking REST Layer
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void restCheck() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet(BASE_URL);
		httpget.setHeader("Authorization", token);
		httpget.setHeader("email", EMAIL);
		httpget.setHeader("password", PASSWORD);

		HttpResponse response = client.execute(httpget);


		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("REST Layer Success ....");
			redisCheck();
		}
		else {
			System.out.println("Your error lies in REST");
			System.out.println(EntityUtils.toString(response.getEntity()));
		}
	}

	/**
	 * Checking Redis
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void redisCheck() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet(BASE_URL+"/api/healthcheck/redis");
		httpget.setHeader("Authorization", token);
		httpget.setHeader("email", EMAIL);
		httpget.setHeader("password", PASSWORD);

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("Redis is Working Fine !!!");
			switch(option){

			case "signin" :
				rdsCheck();
				break;

			case "apns" :
				apnssqsCheck();
				break;


			case "upload" :
				uploadsqsCheck();
				break;

			case "all" : 
				System.out.println("Not yet implemented");
				break;

			default :
				System.out.println("Invalid Input");
				break;

			}
		}
		else {
			System.out.println("Your problem lies in Redis");
			System.out.println(EntityUtils.toString(response.getEntity()));
		}
	}

	/**
	 * Checking RDS
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void rdsCheck() throws ClientProtocolException, IOException {

		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet(BASE_URL+"/api/healthcheck/rds");
		httpget.setHeader("Authorization", token);
		httpget.setHeader("email", EMAIL);
		httpget.setHeader("password", PASSWORD);

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("You dont seem to have any problem. Please try again testing your main API");
		}
		else {
			System.out.println("Your problem lies in RDS");
			System.out.println(EntityUtils.toString(response.getEntity()));
		}
	}

	/**
	 * SQS Check for SNS Flow
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void apnssqsCheck() throws ClientProtocolException, IOException {
		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet(BASE_URL+"/api/healthcheck/notificationSQS");
		httpget.setHeader("Authorization", token);
		httpget.setHeader("email", EMAIL);
		httpget.setHeader("password", PASSWORD);

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("SQS Queue Success");
			snsProcessorCheck();
		}
		else {
			System.out.println("Your problem lies in Notification SQS");
			System.out.println(EntityUtils.toString(response.getEntity()));
		}
	}

	//TODO check the sns processor by shutting it down. Problem is we need to shut processor on both prod as well dev/test environment
	/**
	 * Check for SNS Processor
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void snsProcessorCheck() throws ClientProtocolException, IOException {
		System.out.println("Checking SNS");
		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet(BASE_URL+"/api/healthcheck/snsProcessor");
		httpget.setHeader("Authorization", token);
		httpget.setHeader("email", EMAIL);
		httpget.setHeader("password", PASSWORD);

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("SNS Processor Success");
			awsSNSScheck();
		}
		else {
			System.out.println("Your problem lies in SNS Processor");
			System.out.println(EntityUtils.toString(response.getEntity()));

		}

	}

	/**
	 * Check for SNS service
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void awsSNSScheck() throws ClientProtocolException, IOException{

		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet(BASE_URL+"/api/healthcheck/awsSNS?email="+EMAIL+"&message=NotificationForMe");
		httpget.setHeader("Authorization", token);
		httpget.setHeader("email", EMAIL);
		httpget.setHeader("password", PASSWORD);

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("SNS Flow is completed and working :):):):)");
		}
		else {
			System.out.println("Your error lies in SNS Service");
			System.out.println(EntityUtils.toString(response.getEntity()));
		}
	}


	/**
	 * SQS Check for Data Upload Flow
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void uploadsqsCheck() throws ClientProtocolException, IOException {
		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet(BASE_URL+"/api/healthcheck/temperatureSQS");
		httpget.setHeader("Authorization", token);
		httpget.setHeader("email", EMAIL);
		httpget.setHeader("password", PASSWORD);

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("SQS Queue Success...");
			uploadSQSProcessorCheck();
		}
		else {
			System.out.println("Your problem lies in Upload SQS");
			System.out.println(EntityUtils.toString(response.getEntity()));
		}

	}

	//TODO check the sns processor by shutting it down. Problem is we need to shut processor on both prod as well dev/test environment
	/**
	 * SQS Processor Check for Temperature Data Upload
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void uploadSQSProcessorCheck() throws ClientProtocolException,IOException{

		System.out.println("Checking Upload Processor....");
		HttpClient client = HttpClients.custom().build();

		HttpGet httpget = new HttpGet(BASE_URL+"/api/healthcheck/temperatureProcessor");
		httpget.setHeader("Authorization", token);
		httpget.setHeader("email", EMAIL);
		httpget.setHeader("password", PASSWORD);

		HttpResponse response = client.execute(httpget);

		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("Upload Processor Success...");
			rdsCheck();
		}
		else {
			System.out.println("Your problem lies in Upload Processor");
			System.out.println(EntityUtils.toString(response.getEntity()));

		}

	}


	/**
	 * Sign out request to remove the generated tokens
	 * @param token
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public void signout(String inputToken) throws ClientProtocolException, IOException{
		HttpClient client = HttpClients.custom().build();
		HttpPost httpost = new HttpPost(BASE_URL+"/api/signout");

		httpost.setHeader("Content-Type", "application/json");
		httpost.setHeader("Authorization",inputToken);
		httpost.setHeader("email", EMAIL);
		httpost.setHeader("password", PASSWORD);

		HttpResponse response = client.execute(httpost);

		if (response.getStatusLine().getStatusCode() == 200) {
			System.out.println("Logout Success...");
		} else {
			System.out.println("Error while Logging out ......");
			System.out.println(EntityUtils.toString(response.getEntity()));
		}
	}
}