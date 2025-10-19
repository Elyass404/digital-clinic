package com.clinicdigital.repository.repoInterface;

import com.clinicdigital.model.Patient;
import java.util.List;

public interface PatientRepositoryInterface {

    void save(Patient patient);

    List<Patient> findAll();

    Patient findById(Long id);

    void update(Patient patient);

    void delete(Long id);

    Patient findByEmail(String email);
}
