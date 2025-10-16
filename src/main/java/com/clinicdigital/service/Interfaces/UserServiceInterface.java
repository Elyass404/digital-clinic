package com.clinicdigital.service.Interfaces;

import com.clinicdigital.model.User;

public interface UserServiceInterface {
    public boolean register(User user);
    public User logIn(String email, String password);
}
