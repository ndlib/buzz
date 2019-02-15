package Buzz;

import java.util.Map;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;



public class honeycomb_upload {
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		//Testing add new file feature which enables the user to upload videos
		Map<String, String> env = System.getenv();
		   String username = env.get("ND_test_username");
		   String password = env.get("ND_test_password");
		   String passcode = env.get("ND_test_passcode");

		   System.setProperty("webdriver.chrome.driver", "Drivers\\chromedriver.exe");
		   WebDriver obj = new ChromeDriver();
		   WebDriver driver = obj;

		   String server_link = args[0];
		   driver.get(server_link);

		   driver.findElement(By.xpath("//input[@id='username']")).sendKeys(username);
		   driver.findElement(By.xpath("//input[@id='password']")).sendKeys(password);
		   driver.findElement(By.xpath("//input[@name='submit']")).click();
		   driver.switchTo().frame("duo_iframe");
		   WebDriverWait wait = new WebDriverWait(driver, 10);
		   wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("#passcode"))).click();
		   driver.findElement(By.xpath("//form[@id='login-form']/fieldset[2]/div/input[3]")).sendKeys(passcode);
		   driver.findElement(By.xpath("//form[@id='login-form']/fieldset[2]/div/button")).click();
		   WebDriverWait wait1 = new WebDriverWait(driver, 50);
		   wait1.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@id=\"col2\"]/div[2]/div[1]/div/div/div/div[1]/button/div/div/span"))).click();
		   driver.findElement(By.xpath("//*[@id=\"col2\"]/div[2]/div[1]/div/div/div/div[2]/div[1]/div/div/div[1]/div/div[1]/div[2]")).click();

		   //WebDriverWait wait2 = new WebDriverWait(driver, 250);
		   //wait2.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@id=\"uploadFile\"]//*[@id=\"uploadFile\"]"))).click();



  }

}
