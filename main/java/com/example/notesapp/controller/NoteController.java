package com.example.notesapp.controller;


import com.example.notesapp.DTO.NoteDto;
import com.example.notesapp.command.NoteCommand;
import com.example.notesapp.entity.NoteEntity;
import com.example.notesapp.service.NoteService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;


@RestController
@CrossOrigin(origins = "*")
public class NoteController {
    @Autowired
    NoteService noteService;


    @Autowired
    ModelMapper modelMapper;



    @RequestMapping(value = "/", method = RequestMethod.GET)
    public List<NoteDto> getAllNotes() {
        System.out.println("getting notes");
        return noteService.getAllNotes().stream().map(this::convertToDto).collect(Collectors.toList());
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public NoteDto addNote(@RequestBody NoteCommand noteCommand) {
        try {
            NoteEntity entity = convertToEntity(noteCommand);
            return convertToDto(noteService.addNote(entity)); //DTO
        }catch(Exception e){
            NoteDto dto = new NoteDto();
            dto.setId(-1);
            return dto;
        }
    }

    @RequestMapping(value = "note/{id}", method = RequestMethod.PUT)
    public NoteDto updateNote(@RequestBody NoteCommand editNoteCommand, @PathVariable int id ){
        try{
            NoteEntity entity = convertToEntity(editNoteCommand, id);
            return convertToDto(noteService.updateNote(entity)); //DTO
        }catch(Exception e){
            NoteDto dto = new NoteDto();
            dto.setId(-1);
            return dto;
        }
    }

    @RequestMapping(value = "note/{id}", method = RequestMethod.DELETE)
    public String deleteNote(@RequestBody NoteCommand deleteNoteCommand, @PathVariable int id){
        try{
            NoteEntity entity = convertToEntity(deleteNoteCommand, id);
            noteService.deleteNote(entity);
            return "note deleted successfully";
        }catch(Exception e){
            return "failed to delete note";
        }

    }
    public NoteDto convertToDto(NoteEntity note){
        NoteDto dto = new NoteDto();
        dto = modelMapper.map(note,NoteDto.class);
        return dto;
    }


    public NoteEntity convertToEntity(NoteCommand note, int id){
        NoteEntity entity = new NoteEntity();
        entity = modelMapper.map(note,NoteEntity.class);
        entity.setId(id);
        return entity;
    }

    public NoteEntity convertToEntity(NoteCommand note){
        NoteEntity entity = new NoteEntity();
        entity = modelMapper.map(note,NoteEntity.class);
        return entity;
    }


}
