package com.clinicdigital.model;
import com.clinicdigital.model.enums.RoleEnum;
import jakarta.persistence.*;

@Entity
@Table(name = "admin")
@DiscriminatorValue("ADMIN")
public class Admin extends User {

    public Admin() {
        super.setRole(RoleEnum.ADMIN);
    }

    public Admin(String firstName, String lastName, String email, String password) {
        super(firstName, lastName, email, password, RoleEnum.ADMIN);
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + getId() +
                ", name=" + getFirstName() + " " + getLastName() +
                ", email=" + getEmail() +
                '}';
    }
}
