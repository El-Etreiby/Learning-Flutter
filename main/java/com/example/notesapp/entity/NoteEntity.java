package com.example.notesapp.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class NoteEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String title;
    private String content;

    public NoteEntity(){

    }

    public NoteEntity(String title, String content){
        this.title=title;
        this.content=content;
    }

    public NoteEntity(int id, String title, String content){
        this.title=title;
        this.id=id;
        this.content=content;
    }
    public NoteEntity(int id){
        this.title=title;
        this.id=id;
        this.content=content;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
