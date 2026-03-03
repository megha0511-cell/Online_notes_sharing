package test;

import com.notes.LoginDAO;
import org.junit.Test;
import static org.junit.Assert.*;

public class LoginDAOTest {

    @Test
    public void testValidLogin() {
        LoginDAO dao = new LoginDAO();
        boolean result = dao.validateUser("as12@gmail.com", "4862");
        assertTrue(result);
    }

    @Test
    public void testInvalidLogin() {
        LoginDAO dao = new LoginDAO();
        boolean result = dao.validateUser("wrong@gmail.com", "1234");
        assertFalse(result);
    }
}
