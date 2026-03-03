package test;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.edge.EdgeDriver;

public class SystemTestSelenium {

    public static void main(String[] args) {

        System.setProperty(
            "webdriver.edge.driver",
            "C:\\edgedriver\\msedgedriver.exe"
        );

        WebDriver driver = new EdgeDriver();
        driver.manage().window().maximize();

        // 1. Login
        driver.get("http://localhost:8080/notes_sharing/login.jsp");
        driver.findElement(By.name("email")).sendKeys("as12@gmail.com");
        driver.findElement(By.name("password")).sendKeys("4862");
        driver.findElement(By.xpath("//button[contains(text(),'Login')]")).click();

        sleep();

        // 2. Verify dashboard
        if (driver.getTitle().contains("Dashboard")) {
            System.out.println("Dashboard loaded");
        }

        // 3. Logout (if logout button exists)
        driver.findElement(By.linkText("Logout")).click();

        sleep();

        driver.quit();
    }

    private static void sleep() {
        try { Thread.sleep(3000); } catch (Exception e) {}
    }
}
