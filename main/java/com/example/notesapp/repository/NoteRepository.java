package com.example.notesapp.repository;

import com.example.notesapp.entity.NoteEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NoteRepository extends JpaRepository<NoteEntity, Integer> {

//    public boolean findById(int id);

}
