package com.clinicdigital.model;

import com.clinicdigital.model.enums.RoleEnum;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "doctor")
@DiscriminatorValue("DOCTOR")
public class Doctor extends User {

    @Column(nullable = false)
    private String specialty;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "department_id", nullable = false)
    private Department department;

    @OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<Consultation> consultations = new ArrayList<>();

    // Default constructor
    public Doctor() {
        // Set default role for all Doctor instances
        super.setRole(com.clinicdigital.model.enums.RoleEnum.DOCTOR);
    }

    // Convenience constructor
    public Doctor(String firstName, String lastName, String email, String password, String specialty, Department department) {
        super(firstName, lastName, email, password, RoleEnum.DOCTOR);
        this.specialty = specialty;
        this.department = department;
    }

    // Getters and setters
    public String getSpecialty() { return specialty; }
    public void setSpecialty(String specialty) { this.specialty = specialty; }

    public Department getDepartment() { return department; }
    public void setDepartment(Department department) { this.department = department; }

    public List<Consultation> getConsultations() { return consultations; }
    public void setConsultations(List<Consultation> consultations) { this.consultations = consultations; }

    @Override
    public String toString() {
        return "Doctor{" +
                "id=" + getId() +
                ", name=" + getFirstName() + " " + getLastName() +
                ", email=" + getEmail() +
                ", specialty=" + specialty +
                '}';
    }
}
