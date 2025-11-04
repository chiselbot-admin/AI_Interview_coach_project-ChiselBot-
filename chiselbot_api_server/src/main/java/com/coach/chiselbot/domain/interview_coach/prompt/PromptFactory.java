package com.coach.chiselbot.domain.interview_coach.prompt;

import com.coach.chiselbot._global.errors.adminException.AdminException500;
import com.coach.chiselbot.domain.interview_coach.dto.FeedbackResponse;
import com.coach.chiselbot.domain.interview_question.InterviewQuestion;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class PromptFactory {

    // PromptStrategy 구현한 객체 자동 수집 @component 붙어있는 것들만
    private final List<PromptStrategy> promptStrategies;

    public String createPrompt(InterviewQuestion question,
                               String userAnswer,
                               FeedbackResponse.SimilarityResult similarity) {

        return promptStrategies.stream()
                .filter(s -> s.getLevel() == question.getInterviewLevel())
                .findFirst()
                .orElseThrow(() -> new AdminException500("해당 Level 전략이 없습니다."))
                .buildPrompt(question, userAnswer, similarity);
    }

}
