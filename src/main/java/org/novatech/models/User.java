package org.novatech.models;

public class User {
    private int user_id;
    private String username;
    private String password;

    public void setUser_id(int user_id){
        this.user_id = user_id;
    }

    public int getUser_id(){
        return  user_id;
    }

    public void setPasswordHash(String password) {
        this.password = password;
    }

    public String getPasswordHash() {
        return password;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }
}
