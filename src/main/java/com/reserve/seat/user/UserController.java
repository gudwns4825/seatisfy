package com.reserve.seat.user;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {
	
	private final UserService userService;
	private final BCryptPasswordEncoder bcryptPasswordEncoder;

	// 로그인 페이지
	@GetMapping("/login")
	public String loginForm(Model model) {
		return "login";
	}
	
	// 회원가입 페이지
	@GetMapping("/join")
	public String joinForm(@ModelAttribute("user") User user) {
		return "users/joinform";
	}
	
	// 회원가입 처리
	@PostMapping("/join")
	public String joinUser(@Validated @ModelAttribute("user") User user, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		if (!user.getPassword().equals(user.getPasswordConfirm())) {
		    bindingResult.rejectValue("passwordConfirm", "pwConfirm", "비밀번호가 일치하지 않습니다.");
		}
		 
		if (bindingResult.hasErrors()) {
			log.info("errors={}", bindingResult);
			return "users/joinform";
		}
		
		//회원 정보 디비 등록시 비번을 암호화 스프링 시큐리티 필수 사항
		String encodedPassword = bcryptPasswordEncoder.encode(user.getPassword());
		user.setPassword(encodedPassword);
		
		//성공 로직
		userService.signup(user);
//		userService.changeTmpPw(user);	//임시 비밀번호로 DB데이터 변경, 메일 전송
		
		return "redirect:/user/login";
	}
	
	// 회원 탈퇴
	@PostMapping("/signout")
	public String signout(@ModelAttribute("user") User user, 
			HttpServletRequest request, HttpServletResponse response) {
		
		// 로그아웃 처리
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		new SecurityContextLogoutHandler().logout(request, response, auth);
		//회원 탈퇴
		userService.removeUser(user.getUno());
		return "redirect:/";
	}
	
	// 임시 비밀번호 발급
	@GetMapping("/findpw")
	public String findPw(Model model) {
		return "users/pwfind";
	}
	// 전체 회원 목록
	@GetMapping("/list")
	public String listUser(Model model) {
		List<User> userList = userService.getAllUser();
	    model.addAttribute("userList", userList);
		return "users/list";
	}
	// 회원 권한 변경
	@PostMapping("/list")
	public String changeAuth(@ModelAttribute("user") User user) {
		userService.changeAutority(user);
		return "redirect:/user/list";
	}
	
	// 회원 삭제
	@PostMapping("/remove")
	public void removeUser(@ModelAttribute("user") User user) {
		userService.removeUser(user.getUno());
	}

	// 내 정보 보기
	@GetMapping("/detail")
	public String viewUserDetail(Principal principal, Model model) {

	    User user = userService.getUserDetail(principal.getName());
	    model.addAttribute("user", user);
		    
		return "users/detail";
	}
	
	// 회원 정보 수정 페이지
	@GetMapping("/edit")
	public String editForm(Principal principal, Model model) {
	    User user = userService.getUserDetail(principal.getName());
	    model.addAttribute("user", user);
		    
		return "users/editform";
	}
	
	// 회원 정보 수정
	@PostMapping("/edit")
	public String editUser(@ModelAttribute("user") User user, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		
		if(user.getName().trim().isEmpty()) {
			bindingResult.rejectValue("name", "blankName", "이름은 비워둘 수 없습니다.");
		}
		String phone = user.getPhone();
		if (!phone.matches("^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$")) {
			bindingResult.rejectValue("phone", "incorrectPhone", "올바른 전화번호 형식이 아닙니다.");
		}
		
		if (bindingResult.hasErrors()) {
			log.info("errors={}", bindingResult);
			return "users/editform";
		}
		
		//성공 로직
		userService.editUser(user);
		
		return "redirect:/user/detail";
	}
	
	// 비밀번호 변경 페이지
	@GetMapping("/changepw")
	public String changePwForm(Principal principal, Model model) {
	    User user = userService.getUserDetail(principal.getName());
	    model.addAttribute("user", user);
		    
		return "users/pwchange";
	}
	// 비밀번호 변경
	@PostMapping("/changepw")
	public String changePw(@ModelAttribute("user") User user, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		
		if (!user.getPassword().matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")) {
			bindingResult.rejectValue("password", "incorrectPw", "비밀번호는 8자 이상이어야 하며, 영문자와 숫자를 모두 포함해야 합니다.");
		}
		if (!user.getPassword().equals(user.getPasswordConfirm())) {
		    bindingResult.rejectValue("passwordConfirm", "pwConfirm", "비밀번호가 일치하지 않습니다.");
		}
		
		if (bindingResult.hasErrors()) {
			log.info("errors={}", bindingResult);
			return "users/pwchange";
		}
		
		//비밀번호 암호화
		String encodedPassword = bcryptPasswordEncoder.encode(user.getPassword());
		user.setPassword(encodedPassword);
		
		//성공 로직
		userService.changePw(user);
		
		return "redirect:/user/detail";
	}
	
	

	
}