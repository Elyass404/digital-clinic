package com.clinicdigital.repository;

import com.clinicdigital.model.Doctor;
import com.clinicdigital.repository.repoInterface.DoctorRepositoryInterface;
import com.clinicdigital.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class DoctorRepository implements DoctorRepositoryInterface {

    @Override
    public void save(Doctor doctor) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(doctor);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Doctor> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Doctor d", Doctor.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Doctor findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Doctor.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Doctor doctor) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(doctor);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            Doctor d = em.find(Doctor.class, id);
            if (d != null) {
                tx.begin();
                em.remove(d);
                tx.commit();
            }
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Doctor> findByDepartment(Long departmentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Doctor> q = em.createQuery(
                    "SELECT d FROM Doctor d WHERE d.department.id = :deptId", Doctor.class);
            q.setParameter("deptId", departmentId);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Doctor findByEmail(String email) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Doctor d WHERE d.email = :email", Doctor.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (jakarta.persistence.NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}
