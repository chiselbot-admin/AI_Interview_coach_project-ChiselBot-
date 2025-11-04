package com.coach.chiselbot.domain.interview_coach.prompt;

import com.coach.chiselbot.domain.interview_coach.dto.FeedbackResponse;
import com.coach.chiselbot.domain.interview_question.InterviewLevel;
import com.coach.chiselbot.domain.interview_question.InterviewQuestion;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class Level1PromptStrategy implements PromptStrategy{

    private final PromptRepository promptRepository;

    @Override
    public String buildPrompt(InterviewQuestion question,
                              String userAnswer,
                              FeedbackResponse.SimilarityResult similarity) {

        Prompt prompt = promptRepository
                .findFirstByLevelAndIsActiveTrue(InterviewLevel.LEVEL_1)
                .orElseThrow(() -> new IllegalStateException("Level1 활성화 프롬프트 없음"));

        return prompt.getPromptBody().formatted(
                question.getQuestionText(),
                userAnswer,
                similarity.getIntentSimilarity()
        );
    }

    @Override
    public InterviewLevel getLevel() {
        return InterviewLevel.LEVEL_1;
    }
}
