package com.clinicdigital.repository.repoInterface;

import com.clinicdigital.model.User;

public interface UserRepositoryInterface {

    public User logIn(String email, String password);
    public boolean register(User user);
    public User findByEmail(String email);


}
