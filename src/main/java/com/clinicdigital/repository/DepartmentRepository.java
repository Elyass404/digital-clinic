package com.clinicdigital.repository;

import com.clinicdigital.model.Department;
import com.clinicdigital.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import javax.management.RuntimeOperationsException;
import java.util.List;

public class DepartmentRepository {

    public Department findDepartmentById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        Department department = null;

        try {
            department = em.find(Department.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return department;
    }


    public void save(Department department){
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try{
            tx.begin();
            em.persist(department);
            tx.commit();
        }catch(Exception e){
            if(tx.isActive()) tx.rollback();
            e.printStackTrace();
        }finally{
            em.close();
        }
    }

    public List<Department> findAll(){
        EntityManager  em = JPAUtil.getEntityManager();
       return em.createQuery("SELECT d FROM Department d",Department.class).getResultList();
    }

    public void updateDepartment(Department department) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();
            em.merge(department);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void deleteDepartment(int id) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            Department department = em.find(Department.class, id);
            if (department != null) {
                em.getTransaction().begin();
                em.remove(department);
                em.getTransaction().commit();
            }
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }


}
