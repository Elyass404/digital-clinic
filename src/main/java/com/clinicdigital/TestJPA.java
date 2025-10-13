package com.clinicdigital;

import com.clinicdigital.model.Department;
import com.clinicdigital.repository.DepartmentRepository;

public class TestJPA {

    public static void main(String[] args) {
         DepartmentRepository repo = new DepartmentRepository();

         repo.save(new Department("L9leb"));
         repo.save(new Department("L3dam"));

        repo.findAll().forEach(System.out::println);
    }
}
