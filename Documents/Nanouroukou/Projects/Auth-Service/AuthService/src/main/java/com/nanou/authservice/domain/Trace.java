package com.nanou.authservice.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Trace {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String login;
    @DateTimeFormat(pattern = "yyyy-MM-dd' 'HH:mm:ss.SSSX")
    private LocalDateTime date;
    private String method;
    @Column(length = 5000)
    @Lob
    private String args;
}
