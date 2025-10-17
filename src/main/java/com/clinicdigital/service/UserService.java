package com.clinicdigital.service;

import com.clinicdigital.model.User;
import com.clinicdigital.repository.UserRepository;
import com.clinicdigital.service.Interfaces.UserServiceInterface;
import org.mindrot.jbcrypt.BCrypt;

public class UserService implements UserServiceInterface {

    private final UserRepository repo ;

    public UserService(){
        this.repo = new UserRepository();
    }

    @Override
    public boolean register(User user){
        if (repo.findByEmail(user.getEmail()) != null){
            System.out.println("This email does already exist!");
            return false;
        }
        String hashedPassword =  hashPassword(user.getPassword());// Here we hash the password passed with the user to be registered
        user.setPassword(hashedPassword);
        return repo.register(user);
    }

    
    private String hashPassword (String passwordToBeHashed){
        return BCrypt.hashpw(passwordToBeHashed, BCrypt.gensalt(12));
    }

    @Override
    public User logIn(String email, String password){
        User user = repo.findByEmail(email);
        if(user != null){
            if (BCrypt.checkpw(password, user.getPassword())){
                return user ;
            }else{
                System.out.println("Sorry but the password is incorrect! ");
                return null;
            }
        } else {
            System.out.println("There is no user with such email");
            return null;
        }

    }
}
