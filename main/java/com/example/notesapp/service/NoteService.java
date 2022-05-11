package com.example.notesapp.service;


import com.example.notesapp.DTO.NoteDto;
import com.example.notesapp.entity.NoteEntity;
import com.example.notesapp.repository.NoteRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class NoteService {

    @Autowired
    NoteRepository noteRepository;


    public List<NoteEntity> getAllNotes(){
        try{
            return noteRepository.findAll();
        }catch(Exception e){
            throw e;
        }
    }

public NoteEntity addNote(NoteEntity noteEntity){
        try{
         return noteRepository.save(noteEntity);
        }catch(Exception e){
            throw e;
        }
}

public void deleteNote(NoteEntity noteEntity){
        try{
            if(noteRepository.existsById(noteEntity.getId())){
                noteRepository.delete(noteEntity);
            }else{
                System.out.println("note does not exist in the DB");
            }
        }catch(Exception e){
            throw e;
        }
}

public NoteEntity updateNote(NoteEntity noteEntity){
        try{
            if(noteRepository.existsById(noteEntity.getId())){
                return noteRepository.save(noteEntity);
                }
        }catch(Exception e){
            throw e;

        }
    return new NoteEntity(-1,"","");
}
}
