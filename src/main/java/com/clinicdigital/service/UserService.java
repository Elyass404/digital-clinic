package com.clinicdigital.service;

import com.clinicdigital.model.User;
import com.clinicdigital.repository.UserRepository;
import com.clinicdigital.service.Interfaces.UserServiceInterface;

public class UserService implements UserServiceInterface {

    private final UserRepository repo ;

    public UserService(){
        this.repo = new UserRepository();
    }

    public boolean register(User user){
        if (repo.findByEmail(user.getEmail()) != null){
            System.out.println("This email does already exist!");
            return false;
        }
        String hashedPasswor = crypt(user.getPassword()); // Here we will create the hashing of the password
        user.setPassword(hashedPasswor);
        return repo.register(user);
    }

    public User logIn(String email, String password){
        return null;
    }
}
