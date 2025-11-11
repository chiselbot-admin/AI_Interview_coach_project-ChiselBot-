package com.coach.chiselbot._global.common;

public class Define {
    public static final String SESSION_USER = "sessionUser";

    // 공통 성공/실패 처리
    public static final String SUCCESS = "처리가 완료 되었습니다";
    public static final String FAIL = "처리를 실패 하었습니다";
    public static final String LOGIN_SUCCESS = "로그인에 성공 하였습니다.";
    public static final String LOGOUT_SUCCESS = "로그아웃에 성공 하였습니다.";
    public static final String EMAIL_NOT_FOUND = "존재하지 않는 이메일입니다.";
    public static final String PASSWORD_MISMATCH = "비밀번호가 일치하지 않습니다.";

    // 기타 응답 처리
    public static final String NOT_SUPPORT_LOGIN_TYPE = "지원하지 않는 로그인 방식입니다.";
    public static final String NOT_SUPPORT_NOTI_TYPE = "지원하지 않는 알림 방식입니다.";

    // 회원 응답코드
    public static final String USER_INFO_SEARCH_SUCCESS = "회원정보 조회가 완료 되었습니다.";
    public static final String USER_NOT_FOUND = "사용자를 찾을 수 없습니다.";
    public static final String USER_REGISTED = "회원가입이 완료 되었습니다.";
    public static final String USER_INFO_MODIFY = "회원정보 수정이 완료 되었습니다.";
    public static final String USER_PASSWORD_MODIFY = "회원 비밀번호가 변경 되었습니다.";

    // 관리자 응답 코드
    public static final String ADMIN_NOT_FOUND = "존재하지 않는 관리자 아이디입니다.";
    public static final String ADMIN_EMAIL_NOT_FOUND = "존재하지 않는 이메일입니다.";

    // 공지사항 응답 코드
    public static final String NOTICE_NOT_FOUND = "공지사항이 존재하지 않습니다.";

    // 메뉴관리 응답 코드
    public static final String MENU_NOT_FOUND = "메뉴를 찾을 수 없습니다.";

    // 질문관리 응답 코드
    public static final String QUESTION_NOT_FOUND = "질문이 존재하지 않습니다.";
    public static final String QUESTION_CATEGORY_NOT_FOUND = "질문 카테고리를 찾을 수 없습니다.";

    // 프롬프트 관리 응답 코드
    public static final String PROMPT_NOT_FOUND = "프롬프트를 찾을 수 없습니다.";
    public static final String NO_ACTIVE_PROMPT = "활성화된 프롬프트가 없습니다.";
    public static final String PROMPT_SAVE_SUCCESS = "프롬프트가 성공적으로 등록되었습니다.";

    // 문의관리 응답코드
    public static final String INQUIRY_NOT_FOUND = "문의 정보를 찾을 수 없습니다.";
    public static final String INQUIRY_USER_MISMATCH = "본인의 문의만 삭제할 수 있습니다.";
    public static final String INQUIRY_DELETE_WAITING_ONLY = "대기 상태의 문의만 삭제할 수 있습니다.";
    public static final String INQUIRY_ALREADY_ANSWERED = "이미 답변이 등록된 문의입니다.";
    public static final String INQUIRY_SAVE_SUCCESS = "문의가 등록 되었습니다";
    public static final String INQUIRY_DELETE_SUCCESS = "문의가 삭제 되었습니다";
    public static final String INQUIRY_MODIFY_SUCCESS = "문의가 수정 되었습니다";

    // 이메일 응답코드
    public static final String EMAIL_FOUND = "이메일을 찾았습니다.";
    public static final String EMAIL_REQUIRED = "이메일을 입력 하세요.";
    public static final String EMAIL_AUTH_REQUIRED = "이메일 인증이 필요 합니다.";
    public static final String EMAIL_ALREADY_REGISTED = "이미 가입된 이메일 정보 입니다.";
    public static final String EMAIL_CODE_SEND = "인증코드가 전송 되었습니다.";
    public static final String EMAIL_AND_CODE_REQUIRED = "이메일 또는 인증코드를 입력 해주세요.";
    public static final String EMAIL_AUTH_SUCCESS = "이메일 인증에 성공 했습니다.";
    public static final String EMAIL_AUTH_FAIL = "이메일 인증에 실패 했습니다.";
    public static final String EMAIL_PASSWORD_RESET_AUTH_SEND = "비밀번호 재설정을 위한 인증 메일이 발송 되었습니다.";

    // 답변 응답코드
    public static final String ANSWER_NOT_FOUND = "답변을 찾을 수 없습니다.";
    public static final String ANSWER_USER_MISMATCH = "본인만 답변을 수정할 수 있습니다.";

    // 보관함 응답코드
    public static final String STORAGE_NOT_FOUND = "보관함 정보를 찾을 수 없습니다.";
    public static final String STORAGE_USER_MISMATCH = "본인의 보관함 정보만 삭제 할 수 있습니다.";



}
