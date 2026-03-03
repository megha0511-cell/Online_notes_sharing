package com.notes;

import java.sql.*;

public class LoginDAO {

    public boolean validateUser(String email, String password) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/notes_db",
                "root",
                "root"
            );

            PreparedStatement ps = conn.prepareStatement(
                "SELECT 1 FROM register " +
                "WHERE LOWER(email)=LOWER(?) " +
                "AND CAST(password AS CHAR)=?"
            );

            ps.setString(1, email.trim());
            ps.setString(2, password.trim());

            ResultSet rs = ps.executeQuery();
            boolean ok = rs.next();

            rs.close();
            ps.close();
            conn.close();

            return ok;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
