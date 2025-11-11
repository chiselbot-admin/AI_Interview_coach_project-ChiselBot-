package com.coach.chiselbot.domain.userStorage;

import com.coach.chiselbot._global.common.Define;
import com.coach.chiselbot._global.errors.exception.Exception401;
import com.coach.chiselbot._global.errors.exception.Exception404;
import com.coach.chiselbot.domain.interview_question.InterviewQuestion;
import com.coach.chiselbot.domain.interview_question.InterviewQuestionRepository;
import com.coach.chiselbot.domain.user.User;
import com.coach.chiselbot.domain.user.UserJpaRepository;
import com.coach.chiselbot.domain.userStorage.dto.StorageRequest;
import com.coach.chiselbot.domain.userStorage.dto.StorageResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class UserStorageService {

    private final UserStorageRepository storageRepository;
    private final UserJpaRepository userRepository;
    private final InterviewQuestionRepository interviewQuestionRepository;

    @Transactional
    public StorageResponse.FindById saveStorage(StorageRequest.SaveRequest request, String userEmail){
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new Exception404(Define.USER_NOT_FOUND));

        InterviewQuestion question = interviewQuestionRepository.findById(request.getQuestionId())
                .orElseThrow(() -> new Exception404(Define.QUESTION_NOT_FOUND));

        UserStorage newStorage = new UserStorage();
        newStorage.setUser(user);
        newStorage.setQuestion(question);
        newStorage.setFeedback(request.getFeedback());
        newStorage.setHint(request.getHint());
        newStorage.setUserAnswer(request.getUserAnswer());
        newStorage.setSimilarity(request.getSimilarity());
        newStorage.setGrade(request.getGrade());
        storageRepository.save(newStorage);

        return new StorageResponse.FindById(newStorage);
    }

    @Transactional
    public void deleteStorage(Long storageId, String userEmail){
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new Exception404(Define.USER_NOT_FOUND));

        UserStorage storage = storageRepository.findById(storageId)
                .orElseThrow(() -> new Exception404(Define.STORAGE_NOT_FOUND));

        if(!storage.getUser().getId().equals(user.getId())){
            throw new Exception401(Define.STORAGE_USER_MISMATCH);
        }

        storageRepository.delete(storage);
    }

    @Transactional(readOnly = true)
    public List<StorageResponse.FindAll> getStorageList(String userEmail){
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new Exception404(Define.USER_NOT_FOUND));

        // 최신순 조회(CreatedAt 기준)
        List<UserStorage> storageList = storageRepository.findByUserOrderByCreatedAtDesc(user);

        return StorageResponse.FindAll.from(storageList);
    }

    @Transactional(readOnly = true)
    public StorageResponse.FindById getStorageDetail(Long storageId, String userEmail){
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new Exception404(Define.USER_NOT_FOUND));

        UserStorage storage =  storageRepository.findById(storageId)
                .orElseThrow(() -> new Exception404(Define.STORAGE_NOT_FOUND));

        return new StorageResponse.FindById(storage);
    }

}
