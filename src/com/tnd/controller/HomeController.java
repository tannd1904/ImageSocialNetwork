package com.xdt.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xdt.entity.Category;
import com.xdt.entity.Post;
import com.xdt.entity.User;

@Transactional
@Controller
public class HomeController {
	@Autowired
	SessionFactory factory;
	
	//trang chủ load tất cả hình
	@RequestMapping("home")
	public String getHome(HttpSession sess) {
		if(sess.getAttribute("loginSuccess") == null){
			return "redirect:/user/sign-in.htm";
		}
		
		//tìm user
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE UserName = '" + sess.getAttribute("usernameS").toString() + "'";
		Query query = session.createQuery(hql);
		List<User> listU = query.list();
		if(listU.get(0).getIsActive() == false ) {
			return "user/active";
		}
		return "home/home";
	}
	
	@ModelAttribute("allposts")
	public List<Post> getAllPosts(HttpSession sess){
		Session session = factory.getCurrentSession();
		String hql = "FROM Post ORDER BY PostId DESC";
		Query query = session.createQuery(hql);
		List<Post> list = query.list();
		return list;
	}
	
	//trang cá nhân
	@RequestMapping("{username}")
	public String getAuthor(ModelMap model, HttpSession sess, @PathVariable("username") String username) {
		if(sess.getAttribute("loginSuccess") == null){
			return "redirect:/user/sign-in.htm";
		}
		//tìm user
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE UserName = '" + username + "'";
		Query query = session.createQuery(hql);
		List<User> listU = query.list();
		model.addAttribute("user", listU.get(0));
		
		//tât cả hình của user
		hql = "FROM Category c WHERE c.user.UserName = '"+ username +"'";
		query = session.createQuery(hql);
		List<Category> listCategory = query.list();
		List<Post> list = new ArrayList<Post>();
		for(Category c : listCategory) {
			
			hql = "FROM Post p WHERE p.category.CategoryId = "+ c.getCategoryId() + " ORDER BY PostId DESC";
			query = session.createQuery(hql);
			List<Post> listTmp = query.list();
			for(Post p : listTmp) {
				list.add(p);
			}
		}
		model.addAttribute("allpostsUser", list);
		
		//tất cả bảng của user
		hql = "FROM Category c WHERE c.user.UserName = '"+ username +"'";
		query = session.createQuery(hql);
		List<Category> listC = query.list();
		model.addAttribute("allcategorysUser", listC);
		
		return "home/author";
	}	
}
