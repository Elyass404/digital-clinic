package com.clinicdigital.repository.repoInterface;

import com.clinicdigital.model.Doctor;
import java.util.List;

public interface DoctorRepositoryInterface {

    void save(Doctor doctor);

    List<Doctor> findAll();

    Doctor findById(Long id);

    void update(Doctor doctor);

    void delete(Long id);

    List<Doctor> findByDepartment(Long departmentId);

    Doctor findByEmail(String email);
}
