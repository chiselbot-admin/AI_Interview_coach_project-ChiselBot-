package com.coach.chiselbot.domain.interview_coach.prompt;

import com.coach.chiselbot._global.entity.BaseEntity;
import com.coach.chiselbot.domain.interview_question.InterviewLevel;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "prompt")
public class Prompt extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private InterviewLevel level;

    private String versionName;

    private Boolean isActive;

    @Lob
    private String promptBody;
}
