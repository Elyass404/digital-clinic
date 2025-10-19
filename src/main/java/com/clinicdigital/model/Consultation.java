package com.clinicdigital.model;

import com.clinicdigital.model.enums.ConsultationStatus;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "consultation")
public class Consultation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private LocalDateTime date;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ConsultationStatus status; // Enum: Reserved, Validated, Canceled, Finished

    @Column(length = 2000)
    private String report;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "room_id")
    private Room room;

    // Default constructor
    public Consultation() {}

    // Constructor with all fields
    public Consultation(LocalDateTime date, ConsultationStatus status, String report,
                        Doctor doctor, Patient patient, Room room) {
        this.date = date;
        this.status = status;
        this.report = report;
        this.doctor = doctor;
        this.patient = patient;
        this.room = room;
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDateTime getDate() { return date; }
    public void setDate(LocalDateTime date) { this.date = date; }

    public ConsultationStatus getStatus() { return status; }
    public void setStatus(ConsultationStatus status) { this.status = status; }

    public String getReport() { return report; }
    public void setReport(String report) { this.report = report; }

    public Doctor getDoctor() { return doctor; }
    public void setDoctor(Doctor doctor) { this.doctor = doctor; }

    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }

    public Room getRoom() { return room; }
    public void setRoom(Room room) { this.room = room; }

    @Override
    public String toString() {
        return "Consultation{" +
                "id=" + id +
                ", date=" + date +
                ", status=" + status +
                ", report='" + report + '\'' +
                ", doctor=" + doctor.getId() +
                ", patient=" + patient.getId() +
                ", room=" + (room != null ? room.getIdRoom() : null) +
                '}';
    }
}
