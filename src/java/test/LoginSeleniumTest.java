package test;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.edge.EdgeDriver;

public class LoginSeleniumTest {

    public static void main(String[] args) {

        System.setProperty(
            "webdriver.edge.driver",
            "C:\\edgedriver\\msedgedriver.exe"
        );

        WebDriver driver = new EdgeDriver();
        driver.manage().window().maximize();

        driver.get("http://localhost:8080/notes_sharing/login.jsp");

        driver.findElement(By.name("email"))
              .sendKeys("as12@gmail.com");

        driver.findElement(By.name("password"))
              .sendKeys("4862");

        driver.findElement(By.xpath("//button[contains(text(),'Login')]"))
              .click();

        try {
            Thread.sleep(4000);
        } catch (Exception e) {}

    }
}
