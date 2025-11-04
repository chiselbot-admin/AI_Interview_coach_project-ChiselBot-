package com.coach.chiselbot.domain.interview_coach.prompt;

import com.coach.chiselbot.domain.interview_question.InterviewLevel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PromptRepository extends JpaRepository<Prompt, Long> {
    Optional<Prompt> findFirstByLevelAndIsActiveTrue(InterviewLevel level);

    long countByLevel(InterviewLevel level);

    List<Prompt> findByLevel(InterviewLevel level);

    List<Prompt> findByLevelOrderByIdDesc(InterviewLevel level);

}
