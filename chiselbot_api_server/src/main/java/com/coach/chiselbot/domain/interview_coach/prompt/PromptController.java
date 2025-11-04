package com.coach.chiselbot.domain.interview_coach.prompt;

import com.coach.chiselbot.domain.interview_coach.prompt.dto.PromptResponse;
import com.coach.chiselbot.domain.interview_question.InterviewLevel;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/prompts")
public class PromptController {

    private final PromptService promptService;

    @GetMapping
    public String promptIndex(Model model) {
        model.addAttribute("activePrompts", promptService.getActivePrompts());
        return "promptManager/prompt_index";
    }

    /** 레벨별 버전 목록 화면 */
    @GetMapping("/list")
    public String promptList(@RequestParam InterviewLevel level, Model model) {
        List<PromptResponse.FindAll> prompts = promptService.getPromptsByLevel(level);
        model.addAttribute("prompts", prompts);
        model.addAttribute("level", level);
        return "promptManager/prompt_list";
    }

    /** 프롬프트 상세보기 + 수정 폼 */
    @GetMapping("/detail/{id}")
    public String promptDetail(@PathVariable Long id, Model model) {
        PromptResponse.FindById prompt = promptService.getPromptById(id);
        model.addAttribute("prompt", prompt);
        return "promptManager/prompt_detail";
    }

    /** 수정 처리 */
    @PostMapping("/detail/{id}")
    public String updatePrompt(@PathVariable Long id,
                               @RequestParam(required = false) String promptBody,
                               @RequestParam(required = false) Boolean activate) {
        promptService.updatePrompt(id, promptBody, activate);
        return "redirect:/admin/prompts/detail/" + id;
    }

    /** AJAX 토글 */
    @PostMapping("/toggle/{id}")
    @ResponseBody
    public String toggleActive(@PathVariable Long id, @RequestParam boolean active) {
        promptService.updatePrompt(id, null, active);
        return "OK";
    }
}
