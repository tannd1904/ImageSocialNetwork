package com.xdt.controller;

import java.io.File;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.xdt.entity.User;

@Transactional
@Controller
@RequestMapping("user")
public class UserController {

	@Autowired
	ServletContext context;
	@Autowired
	SessionFactory factory;
	@Autowired
	JavaMailSender mailer1;
	
	//======================================================= in tất cả user
	@RequestMapping("all-user")
	public String index(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User";
		Query query = session.createQuery(hql);

		List<User> list = query.list();

		model.addAttribute("users", list);
		return "user/all";
	}
	
	//======================================================= đăng ký
	@RequestMapping(value = "sign-up", method = RequestMethod.GET)
	public String signUp(ModelMap model) {
		model.addAttribute("user", new User());
		return "user/signup";
	}

	@RequestMapping(value = "sign-up", method = RequestMethod.POST)
	public String signUp(ModelMap model, HttpServletRequest req, @ModelAttribute("user") User user,
			BindingResult errors) {
		// nhận giá trị nhập lại mật khẩu
		String pass = req.getParameter("Passwords");
		
		model.addAttribute("user", user);

		if (user.getLastName().trim().length() == 0 || user.getFirstName().trim().length() == 0) {
			model.addAttribute("errLFName", "Vui lòng nhập họ và tên!");
			return "user/signup";
		}
		if (user.getEmail().trim().length() == 0) {
			model.addAttribute("errEmail", "Vui lòng nhập email!");
			return "user/signup";
		}
		if (user.getPhone().trim().length() == 0) {
			model.addAttribute("errPD", "Vui lòng nhập SĐT và ngày sinh!");
			return "user/signup";
		}
		if (user.getUserName().trim().length() == 0) {
			model.addAttribute("errUserName", "Vui lòng nhập tên đăng nhập!");
			return "user/signup";
		}
		if (user.getPassword().trim().length() == 0) {
			model.addAttribute("errPassword", "Vui lòng nhập mật khẩu!");
			return "user/signup";
		}
		if (pass.trim().length() == 0) {
			model.addAttribute("errPasswords", "Vui lòng xác nhận mật khẩu!");
			return "user/signup";
		}
		if (user.getPassword().equals(pass) == false) {
			model.addAttribute("errPasswords", "Mật khẩu không khớp!");
			return "user/signup";
		}
		if(getUserEmail(user.getEmail()).isEmpty() == false) {
			model.addAttribute("errEmail", "Email đã tồn tại!");
			return "user/signup";
		}
		if(getUserUN(user.getUserName()).isEmpty() == false) {
			model.addAttribute("errUserName", "Tên đăng nhập đã tồn tại!");
			return "user/signup";
		}
		
		
		model.remove("user");
		
		user.setPassword(md5(pass));
		user.setAvatar("/avatars/unknown.png");
		user.setStory("Đang cập nhật");
		user.setIsActive(false);
		user.setIsDelete(false);
		user.setIsAdmin(false);
		user.setIsLocked(false);

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(user);
			t.commit();
//			model.addAttribute("message", "Thêm thành công!");
			return "redirect:/user/sign-in.htm";
		} catch (Exception e) {
			e.printStackTrace();
			t.rollback();
			model.addAttribute("message", "Máy chủ xảy ra lỗi!");
			return "user/signup";
		} finally {
			session.close();
		}
//		}

	}
	
	@ModelAttribute("genders")
	public Map<String, String> getGender(){
		Map<String, String> genders = new HashMap<String, String>();
		genders.put("1", "Nam");
		genders.put("2", "Nữ");
		genders.put("0", "Khác");
		return genders;
	}
	
	//======================================================= đăng nhập
	@RequestMapping(value = "sign-in", method = RequestMethod.GET)
	public String signIn() {
		return "user/login";
	}
	
	@RequestMapping(value = "sign-in", method = RequestMethod.POST)
	public String signIn(ModelMap model, HttpServletRequest req, HttpSession sess) {
		String UserName = req.getParameter("UserName");
		String Password = req.getParameter("Password");
		
		//kiểm tra trong db
		Session session = factory.getCurrentSession();
		String hql = "FROM User u WHERE u.UserName =:UserName and u.Password =:Password";
		Query query = session.createQuery(hql);
		query.setParameter("UserName", UserName);
		query.setParameter("Password", md5(Password));
		
		List<User> list = query.list();
		
		if(list.isEmpty() == true) {
			model.addAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng!");
			return "user/login";
		}	
		
		sess.setAttribute("loginSuccess", list.get(0));
		sess.setAttribute("usernameS", list.get(0).getUserName());
		sess.setAttribute("userIdS", list.get(0).getUserId());
		
		if(list.get(0).getIsActive() == false) {
			
			MailerController mailer = new MailerController();
			boolean a = mailer.active(mailer1, list.get(0), "http://localhost:8080/SocialNetworkImage/user/active/" + list.get(0).getUserName() +".htm");
			System.out.println(a);
			return "user/active";
		}
		
		
	
		return "redirect:/home.htm";
	}
	
	//======================================================= đăng xuất
	@RequestMapping("sign-out")
	public String getFollow(HttpSession session) {
		session.removeAttribute("loginSuccess");
		session.removeAttribute("usernameS");
		session.removeAttribute("userIdS");
		return "redirect:/user/sign-in.htm";
	}
	
	//======================================================= chỉnh sửa thông tin cá nhân
	@RequestMapping(value = "update/{username}", method = RequestMethod.GET)
	public String setUp(ModelMap model, HttpSession session) {
		if(session.getAttribute("loginSuccess") == null){
			return "redirect:/user/sign-in.htm";
		}
		User userLogin = getUserUN(session.getAttribute("usernameS").toString()).get(0);
		model.addAttribute("user", userLogin);
		return "user/update";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String setUp(ModelMap model, HttpSession sess, HttpServletRequest req, @RequestParam("Avatar") MultipartFile avatar) {
		String LastName = req.getParameter("LastName");
		String FirstName = req.getParameter("FirstName");
		String Birthday = req.getParameter("Birthday");
		String Gender = req.getParameter("Gender");
		String Phone = req.getParameter("Phone");
		String Story = req.getParameter("Story");
		User userLogin = getUserUN(sess.getAttribute("usernameS").toString()).get(0);
		String path = "/avatars/" + sess.getAttribute("usernameS").toString() + "_" + avatar.getOriginalFilename();
		
		userLogin.setFirstName(FirstName);
		userLogin.setLastName(LastName);
		userLogin.setPhone(Phone);
		
		model.addAttribute("user", userLogin);
		
		if(LastName.trim().length() == 0 || FirstName.trim().length() == 0) {
			model.addAttribute("errLFName", "Họ và tên không được để trống!");
			return "user/update";
		}
		if(Birthday.trim().length() == 0) {
			model.addAttribute("errBirthday", "Ngày sinh không được để trống!");
			return "user/update";
		}
		if(Phone.trim().length() == 0) {
			model.addAttribute("errPhone", "Số điện thoại không được để trống!");
			return "user/update";
		}
		if(Phone.trim().length() > 11 || Phone.trim().length() < 10) {
			model.addAttribute("errPhone", "Số điện thoại có độ dài từ 10 - 11 số!");
			return "user/update";
		}
		
		model.remove("user");
		//gán giá trị mới cho user
		userLogin.setStory(Story);
		if(Story.trim().length() == 0) {
			userLogin.setStory("Đang cập nhật");
		}
		userLogin.setGender(Integer.parseInt(Gender));
		userLogin.setFirstName(FirstName);
		userLogin.setLastName(LastName);
		userLogin.setPhone(Phone);
		
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		try {
			Date date = new SimpleDateFormat("yyyy-MM-dd").parse(Birthday);
			userLogin.setBirthday(date);
			
			if(avatar.isEmpty() ==  false) {
				userLogin.setAvatar(path);
				String avatarPath = context.getRealPath(path);
				avatar.transferTo(new File(avatarPath));
			}
			
			session.update(userLogin);
			t.commit();
			
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
			sess.setAttribute("loginSuccess", userLogin);
		}
		return "redirect:/user/update/" + sess.getAttribute("usernameS").toString() + ".htm";
	}
	
	//======================================================= thay đổi mật khẩu
	@RequestMapping(value = "change-pass/{username}", method = RequestMethod.GET)
	public String changePass(ModelMap model, HttpSession session) {
		if(session.getAttribute("loginSuccess") == null){
			return "redirect:/user/sign-in.htm";
		}
		return "user/changePass";
	}
	
	@RequestMapping(value = "change-pass", method = RequestMethod.POST)
	public String changePass(ModelMap model, HttpSession sess, HttpServletRequest req) {
		String Password = req.getParameter("Password");
		String NewPassword = req.getParameter("NewPassword");
		String NewPasswords = req.getParameter("NewPasswords");
		
		model.addAttribute("Password", Password);
		
//		System.out.println(md5(Password));
		
		model.addAttribute("NewPassword", NewPassword);
		model.addAttribute("NewPasswords", NewPasswords);
		
		User userLogin = getUserUN(sess.getAttribute("usernameS").toString()).get(0);
		
		if(Password.trim().length() == 0) {
			model.addAttribute("errPassword", "Vui lòng nhập mật khẩu hiện tại!");
			return "user/changePass";
		}
		if(NewPassword.trim().length() == 0) {
			model.addAttribute("errNewPassword", "Vui lòng nhập mật khẩu mới!");
			return "user/changePass";
		}
		if(NewPasswords.trim().length() == 0) {
			model.addAttribute("errNewPasswords", "Vui lòng xác nhận mật khẩu mới!");
			return "user/changePass";
		}
		if(NewPassword.equals(NewPasswords) == false) {
			model.addAttribute("errNewPasswords", "Mật khẩu xác nhận không khớp!");
			return "user/changePass";
		}
		if(md5(Password).equals(userLogin.getPassword()) == false) {
			model.addAttribute("errPassword", "Mật khẩu bạn nhập không đúng!");
			return "user/changePass";
		}
		
		model.remove("Password");
		model.remove("NewPassword");
		model.remove("NewPasswords");
		
		userLogin.setPassword(md5(NewPassword));
		
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		try {		
			session.update(userLogin);
			t.commit();
			sess.setAttribute("loginSuccess", userLogin);
		} catch (Exception e) {
//			e.printStackTrace();
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/user/change-pass/" + sess.getAttribute("usernameS").toString() + ".htm";
	}
	
	//======================================================= kích hoat tài khoản
	@RequestMapping("active/{username}")
	public String activeUser(ModelMap model, @PathVariable("username") String username, HttpSession sess) {
		
		User user = getUserUN(username).get(0);
		user.setIsActive(true);
		
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		try {
			session.update(user);
			t.commit();
			
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/home.htm";
	}
	
	//======================================================= các hàm get
	public List<User> getUserUN(String username){
		Session session = factory.getCurrentSession();
		String hql = "FROM User u WHERE u.UserName =:username";
		Query query = session.createQuery(hql);
		query.setParameter("username", username);
		
		List<User> list = query.list();
		
		return list;
	}
	
	public List<User> getUserEmail(String email){
		Session session = factory.getCurrentSession();
		String hql = "FROM User u WHERE u.Email =:email";
		Query query = session.createQuery(hql);
		query.setParameter("email", email);
		System.out.println(query);
		List<User> list = query.list();
		
		return list;
	}
	
	public String md5(String str){
		String result = "";
		MessageDigest digest;
		try {
			digest = MessageDigest.getInstance("MD5");
			digest.update(str.getBytes());
			BigInteger bigInteger = new BigInteger(1,digest.digest());
			result = bigInteger.toString(16);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return result;
	}
}
