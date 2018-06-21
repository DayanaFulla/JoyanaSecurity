package com.version.proyectofinalelectivadehardware.joyanasecurityapp.Utilities;

public class User {

    private String UserIdLogin;
    private static final User ourInstance = new User();

    public static User getInstance() {
        return ourInstance;
    }

    private User() {
        UserIdLogin = "";
    }

    public String getUserIdLogin() {
        return UserIdLogin;
    }

    public void setUserIdLogin(String userIdLogin) {
        UserIdLogin = userIdLogin;
    }
}
