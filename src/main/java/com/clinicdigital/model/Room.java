package com.clinicdigital.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "room")
public class Room {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idRoom;

    @Column(nullable = false, unique = true)
    private String name;

    @Column(nullable = false)
    private int capacity;

    @OneToMany(mappedBy = "room", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Consultation> listOfReservations = new ArrayList<>();

    public Room() {}

    public Room(String name, int capacity) {
        this.name = name;
        this.capacity = capacity;
    }

    public Long getIdRoom() {
        return idRoom;
    }

    public void setIdRoom(Long idRoom) {
        this.idRoom = idRoom;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public List<Consultation> getListOfReservations() {
        return listOfReservations;
    }

    public void setListOfReservations(List<Consultation> listOfReservations) {
        this.listOfReservations = listOfReservations;
    }

    // Helper methods to manage bidirectional relationship
    public void addReservation(Consultation consultation) {
        listOfReservations.add(consultation);
        consultation.setRoom(this);
    }

    public void removeReservation(Consultation consultation) {
        listOfReservations.remove(consultation);
        consultation.setRoom(null);
    }
}
