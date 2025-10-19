package com.clinicdigital.repository.repoInterface;

import com.clinicdigital.model.Admin;
import java.util.List;

public interface AdminRepositoryInterface {

    void save(Admin admin);

    List<Admin> findAll();

    Admin findById(Long id);

    void update(Admin admin);

    void delete(Long id);

    Admin findByEmail(String email);
}
