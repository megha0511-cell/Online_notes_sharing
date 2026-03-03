package test;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.edge.EdgeDriver;
import org.testng.Assert;
import org.testng.annotations.Test;

public class DashboardTestNGTest {

    @Test
    public void dashboardPageLoadTest() {

        System.setProperty(
            "webdriver.edge.driver",
            "C:\\edgedriver\\msedgedriver.exe"
        );

        WebDriver driver = new EdgeDriver();
        driver.manage().window().maximize();

        // JSP page under test
        driver.get("http://localhost:8080/notes_sharing/dashboard.jsp");

        String title = driver.getTitle();
        Assert.assertTrue(
            title != null && title.length() > 0,
            "Dashboard page did not load"
        );

    }

    // 🔹 REQUIRED FOR NETBEANS 8.2
    public static void main(String[] args) {
        DashboardTestNGTest test = new DashboardTestNGTest();
        test.dashboardPageLoadTest();
        System.out.println("TestNG dashboard test executed successfully");
    }
}
