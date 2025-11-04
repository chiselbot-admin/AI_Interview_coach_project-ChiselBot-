package com.coach.chiselbot.domain.interview_coach.prompt.dto;

import com.coach.chiselbot.domain.interview_coach.prompt.Prompt;
import com.coach.chiselbot.domain.interview_question.InterviewLevel;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

public class PromptResponse {

    @Getter
    @Setter
    public static class FindById{
        private Long id;
        private InterviewLevel level;
        private String versionName;
        private Boolean isActive;
        private String promptBody;

        public FindById(Prompt prompt){
            this.id = prompt.getId();
            this.level = prompt.getLevel();
            this.versionName = prompt.getVersionName();
            this.isActive = prompt.getIsActive();
            this.promptBody = prompt.getPromptBody();
        }
    }

    @Getter
    @Setter
    public static class FindAll{
        private Long id;
        private InterviewLevel level;
        private String versionName;
        private Boolean isActive;
        private String promptBody;

        public FindAll(Prompt prompt){
            this.id = prompt.getId();
            this.level = prompt.getLevel();
            this.versionName = prompt.getVersionName();
            this.isActive = prompt.getIsActive();
            this.promptBody = prompt.getPromptBody();
        }

        public static List<PromptResponse.FindAll> from(List<Prompt> prompts){
            List<PromptResponse.FindAll> dtoList = new ArrayList<>();
            for(Prompt prompt : prompts){
                dtoList.add(new PromptResponse.FindAll(prompt));
            }
            return dtoList;
        }
    }
}
