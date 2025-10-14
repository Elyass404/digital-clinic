package com.clinicdigital.repository;

import com.clinicdigital.model.Consultation;
import com.clinicdigital.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ConsultationRepository {

    public void save(Consultation consultation) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(consultation);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<Consultation> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Consultation c", Consultation.class).getResultList();
        } finally {
            em.close();
        }
    }

    public Consultation findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Consultation.class, id);
        } finally {
            em.close();
        }
    }

    public void update(Consultation consultation) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(consultation);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            Consultation c = em.find(Consultation.class, id);
            if (c != null) {
                tx.begin();
                em.remove(c);
                tx.commit();
            }
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<Consultation> findByDoctor(Long doctorId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                    "SELECT c FROM Consultation c WHERE c.doctor.id = :doctorId", Consultation.class);
            query.setParameter("doctorId", doctorId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Consultation> findByPatient(Long patientId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                    "SELECT c FROM Consultation c WHERE c.patient.idPatient = :patientId", Consultation.class);
            query.setParameter("patientId", patientId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
