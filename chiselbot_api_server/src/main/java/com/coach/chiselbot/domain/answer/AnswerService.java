package com.coach.chiselbot.domain.answer;

import com.coach.chiselbot._global.common.Define;
import com.coach.chiselbot._global.errors.adminException.AdminException403;
import com.coach.chiselbot._global.errors.adminException.AdminException404;
import com.coach.chiselbot._global.errors.exception.Exception400;
import com.coach.chiselbot.domain.Inquiry.Inquiry;
import com.coach.chiselbot.domain.Inquiry.InquiryRepository;
import com.coach.chiselbot.domain.Inquiry.InquiryStatus;
import com.coach.chiselbot.domain.admin.Admin;
import com.coach.chiselbot.domain.admin.AdminRepository;
import com.coach.chiselbot.domain.answer.dto.AnswerRequestDTO;
import com.coach.chiselbot.domain.answer.dto.AnswerResponseDTO;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class AnswerService {

    private final InquiryRepository inquiryRepository;
    private final AnswerRepository answerRepository;
    private final AdminRepository adminRepository;

    /**
     * 수정 폼용 조회 처리 (inquiry 함께 조회)
     */
    public AnswerResponseDTO.UpdateForm getUpdateForm(Long answerId) {
        Answer answer = answerRepository.findByIdWithInquiry(answerId)
                .orElseThrow(() -> new AdminException404(Define.ANSWER_NOT_FOUND));

        return AnswerResponseDTO.UpdateForm.from(answer);
    }

    /**
     * 답변 수정 처리 로직
     */
    public Long updateAnswer(Long answerId, Long adminId, AnswerRequestDTO.Update dto) {

        Answer answer = answerRepository.findByIdWithInquiry(answerId)
                .orElseThrow(() -> new AdminException404(Define.ANSWER_NOT_FOUND));

        if (!answer.getAdmin().getId().equals((adminId))) {
            throw new AdminException403(Define.ANSWER_USER_MISMATCH);
        }

        answer.setContent(dto.getContent());
        return answer.getInquiry().getId();
    }

    /**
     * 답변 생성 처리 로직
     */
    public Answer createAnswer(Long inquiryId, Long adminId, AnswerRequestDTO.Create dto) {

        Inquiry inquiry = inquiryRepository.findByIdWithAnswer(inquiryId)
                .orElseThrow(() -> new AdminException404(Define.INQUIRY_NOT_FOUND));

        if (inquiry.getAnswer() != null) {
            throw new Exception400(Define.INQUIRY_ALREADY_ANSWERED);
        }

        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new AdminException404(Define.ADMIN_NOT_FOUND));

        Answer answer = Answer.builder()
                .content(dto.getContent())
                .admin(admin)
                .inquiry(inquiry)
                .build();

        inquiry.setStatus(InquiryStatus.ANSWERED);
        inquiry.setAnswer(answer);

        answerRepository.save(answer);

        return answer;
    }
}
