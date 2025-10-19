package com.clinicdigital.model;

import com.clinicdigital.model.enums.RoleEnum;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "patient")
@DiscriminatorValue("PATIENT")
public class Patient extends User {

    private Double weight; // in kg
    private Double height; // in cm

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Consultation> consultations = new ArrayList<>();

    // Default constructor
    public Patient() {
        // Set default role for all Patient instances
        super.setRole(com.clinicdigital.model.enums.RoleEnum.PATIENT);
    }

    // Convenience constructor
    public Patient(String firstName, String lastName, String email, String password,
                   Double weight, Double height) {
        super(firstName, lastName, email, password, RoleEnum.PATIENT);
        this.weight = weight;
        this.height = height;
    }

    // Getters and setters
    public Double getWeight() { return weight; }
    public void setWeight(Double weight) { this.weight = weight; }

    public Double getHeight() { return height; }
    public void setHeight(Double height) { this.height = height; }

    public List<Consultation> getConsultations() { return consultations; }
    public void setConsultations(List<Consultation> consultations) { this.consultations = consultations; }

    @Override
    public String toString() {
        return "Patient{" +
                "id=" + getId() +
                ", name=" + getFirstName() + " " + getLastName() +
                ", email=" + getEmail() +
                ", weight=" + weight +
                ", height=" + height +
                '}';
    }
}
