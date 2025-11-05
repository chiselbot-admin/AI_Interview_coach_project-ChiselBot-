package com.coach.chiselbot.domain.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.Optional;

public interface UserJpaRepository extends JpaRepository<User, Long> {
    // 이메일 중복 여부 확인 - 메서드 쿼리 (Query Method) 기능 활용
    Optional<User> findByEmail(String email);
    boolean existsByEmail(String email);
	Optional<User> findByName(String name);

	// 대시보드 통계(오늘 가입자 수 00시 ~)
    @Query("SELECT COUNT(u) FROM User u WHERE u.createdAt >= :startOfDay")
    long countTodayUsers(@Param("startOfDay") LocalDateTime startOfDay);
}
