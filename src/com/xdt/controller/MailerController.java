package com.xdt.controller;

import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.xdt.entity.User;

@Transactional
@Controller
@RequestMapping("mailer")
public class MailerController {
	
	@Autowired
	JavaMailSender mailer;
	@Autowired
	SessionFactory factory;
	
	@RequestMapping("reset")
	public String index() {
		return "mailer/form";
	}
	
	@RequestMapping("send")
	public String send(ModelMap model, @RequestParam("toEmail") String to) {
		int newPass = randomPass();
		List<User> list = getUserEmail(to);
		if(list.isEmpty() == true) {
			model.addAttribute("message", "Email không tồn tại trong hệ thống!");
			return "mailer/form";
		}
		User user = list.get(0);
		
		String from = "SupportServices_XDT";
		String subject = "XÁC NHẬN THAY ĐỔI MẬT KHẨU";
		String body = "Chào " + user.getFirstName() + ". Mật khẩu mới của bạn: " + newPass; 
		resetPassword(user, newPass);
		
		try {
			MimeMessage mail = mailer.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail);
			helper.setFrom(from, from);
			helper.setTo(to);
			helper.setReplyTo(from, from);
			helper.setSubject(subject);
			helper.setText(body, true);
			
			mailer.send(mail);
			
			model.addAttribute("message","Gửi mail thành công!");
		} catch (Exception e) {
			model.addAttribute("message","Gửi mail thất bại!");
		}
		return "redirect:/user/sign-in.htm";
	}
	
	public boolean active(JavaMailSender mailer1, User user, String url) {
		
		String from = "SupportServices_XDT";
		String subject = "KÍCH HOẠT TÀI KHOẢN NGƯỜI DÙNG";
		String body = "Chào " + user.getFirstName() + ". Vui lòng nhấn vào liên kết để kích hoạt tài khoản: " + url; 
		
		try {
			MimeMessage mail = mailer1.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail);
			helper.setFrom(from, from);
			helper.setTo(user.getEmail());
			helper.setReplyTo(from, from);
			helper.setSubject(subject);
			helper.setText(body, true);
			
			mailer1.send(mail);
			
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	public int randomPass() {
		Random rd = new Random();   // khai báo 1 đối tượng Random
	    int number = 75812376 + rd.nextInt(999999);  // trả về 1 số nguyên bất kỳ
		return number;
	}
	
	public void resetPassword(User user, int newPass) {
		UserController uc = new UserController();
		user.setPassword(uc.md5("" + newPass));
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		try {			
			session.update(user);
			t.commit();
		} catch (Exception e) {
			e.printStackTrace();
			t.rollback();
		} finally {
			session.close();
		}
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
}
