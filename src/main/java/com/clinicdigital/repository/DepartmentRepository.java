package com.clinicdigital.repository;

import com.clinicdigital.model.Department;
import com.clinicdigital.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class DepartmentRepository {

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
}
