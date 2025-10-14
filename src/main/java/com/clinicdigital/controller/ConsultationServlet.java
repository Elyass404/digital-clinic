package com.clinicdigital.controller;

import com.clinicdigital.model.*;
import com.clinicdigital.repository.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/consultations")
public class ConsultationServlet extends HttpServlet {

    private final ConsultationRepository consultationRepo = new ConsultationRepository();
    private final DoctorRepository doctorRepo = new DoctorRepository();
    private final PatientRepository patientRepo = new PatientRepository();
    private final RoomRepository roomRepo = new RoomRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            List<Consultation> consultations = consultationRepo.findAll();
            request.setAttribute("consultations", consultations);
            request.getRequestDispatcher("/WEB-INF/views/consultations.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "create":
                request.setAttribute("doctors", doctorRepo.findAll());
                request.setAttribute("patients", patientRepo.findAll());
                request.setAttribute("rooms", roomRepo.findAll());
                request.getRequestDispatcher("/WEB-INF/views/create_consultation.jsp").forward(request, response);
                break;

            case "edit": {
                Long id = Long.parseLong(request.getParameter("id"));
                Consultation consultation = consultationRepo.findById(id);
                if (consultation == null) {
                    response.sendRedirect(request.getContextPath() + "/consultations");
                    return;
                }
                request.setAttribute("consultation", consultation);
                request.setAttribute("doctors", doctorRepo.findAll());
                request.setAttribute("patients", patientRepo.findAll());
                request.setAttribute("rooms", roomRepo.findAll());
                request.getRequestDispatcher("/WEB-INF/views/edit_consultation.jsp").forward(request, response);
                break;
            }

            case "delete": {
                Long id = Long.parseLong(request.getParameter("id"));
                consultationRepo.delete(id);
                response.sendRedirect(request.getContextPath() + "/consultations");
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/consultations");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String report = request.getParameter("report");
        String dateStr = request.getParameter("dateConsultation");
        Long doctorId = Long.parseLong(request.getParameter("doctorId"));
        Long patientId = Long.parseLong(request.getParameter("patientId"));
        Long roomId = Long.parseLong(request.getParameter("roomId"));

        Doctor doctor = doctorRepo.findById(doctorId);
        Patient patient = patientRepo.findById(patientId);
        Room room = roomRepo.findById(roomId);

        LocalDateTime dateConsultation = LocalDateTime.parse(dateStr, DateTimeFormatter.ISO_LOCAL_DATE_TIME);

        if (action == null || action.equals("create")) {
            Consultation c = new Consultation(dateConsultation, report, doctor, patient, room);
            consultationRepo.save(c);
        } else if (action.equals("update")) {
            Long id = Long.parseLong(request.getParameter("id"));
            Consultation consultation = consultationRepo.findById(id);
            if (consultation != null) {
                consultation.setDateConsultation(dateConsultation);
                consultation.setReport(report);
                consultation.setDoctor(doctor);
                consultation.setPatient(patient);
                consultation.setRoom(room);
                consultationRepo.update(consultation);
            }
        }

        response.sendRedirect(request.getContextPath() + "/consultations");
    }
}
