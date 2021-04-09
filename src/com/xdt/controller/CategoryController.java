package com.xdt.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.xdt.entity.Category;
import com.xdt.entity.Post;
import com.xdt.entity.User;

@Transactional
@Controller
@RequestMapping("category")
public class CategoryController {
	@Autowired
	SessionFactory factory;

	//======================================================= in tất cả bảng
	@RequestMapping("index")
	public String index(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Category";
		Query query = session.createQuery(hql);
		List<Category> list = query.list();
		
		model.addAttribute("categorys", list);
		return "category/index";
	}
	
	//======================================================= thêm bảng
	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public String insert(ModelMap model) {
		model.addAttribute("category", new Category());
		return "category/insert";
	}
	
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insert(ModelMap model, @ModelAttribute("category") Category category, HttpSession sess) {
		User user = getUser(sess).get(0);
		if (category.getCategoryName().trim().length() == 0) {
			model.addAttribute("err", "Bạn chưa nhập tên bảng!");
			return "category/insert";
		}
		category.setUser(user);
		System.out.println(category.getUser().getUserId());
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				session.save(category);
				t.commit();
				model.addAttribute("message", "Thêm mới thành công!");
			} catch (Exception e) {
				t.rollback();
				model.addAttribute("message", "Thêm mới thất bại!");
			} finally {
				session.close();
			}
//		}
		
		return "redirect:/" + sess.getAttribute("usernameS") + ".htm";
	}
	
	//======================================================= chỉnh sửa thông tin bảng
	@RequestMapping(value = "update/{id}", method = RequestMethod.POST)
	public String update(ModelMap model, HttpServletRequest req, HttpSession sess, @PathVariable("id") int id) {
		String CategoryName = req.getParameter("CategoryName");
		Category categoryOld = getCategory(id).get(0);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		if(CategoryName.isEmpty() ==  false) {
			categoryOld.setCategoryName(CategoryName);
		}
		
		try {
			session.update(categoryOld);
			t.commit();
//			model.addAttribute("message", "Cập nhật thành công!");
		} catch (Exception e) {
			t.rollback();
//			model.addAttribute("message", "Cập nhật thất bại!");
		} finally {
			session.close();
		}
		return "redirect:/category/" + id + ".htm";
	}
	
	//======================================================= xóa bảng
	@RequestMapping(value = "delete/{id}")
	public String delete(ModelMap model, @PathVariable("id") int id, HttpSession sess) {
		Session session = factory.getCurrentSession();
		String hql = "DELETE FROM Category c WHERE c.CategoryId = :id";
		Query query = session.createQuery(hql).setParameter("id", id);

		query.executeUpdate();
		return "redirect:/" + sess.getAttribute("usernameS") + ".htm";
	}
	
	
	//======================================================= in chi tiết của MỘT bảng
	@RequestMapping("{id}")
	public String getDetail(ModelMap model, @PathVariable("id") int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Post p WHERE p.category.CategoryId = "+ id + " ORDER BY PostId DESC";
		Query query = session.createQuery(hql);
		List<Post> list = query.list();
		model.addAttribute("posts", list);
		hql = "FROM Category c WHERE c.CategoryId = " + id;
		query = session.createQuery(hql);
		List<Category> listC = query.list();
		model.addAttribute("category", listC.get(0));
		hql = "FROM User u WHERE u.UserId = " + listC.get(0).getUser().getUserId();
		query = session.createQuery(hql);
		List<User> listU = query.list();
		model.addAttribute("user", listU.get(0));
//		System.out.println(list);
		return "category/detail";
	}
	
	//======================================================= các hàm get
		public List<User> getUser(HttpSession sess) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE UserName = '" + sess.getAttribute("usernameS") + "'";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		return list;
		}
		
		public List<Category> getCategory(int id){
			Session session = factory.getCurrentSession();
			String hql = "FROM Category c WHERE c.CategoryId =:id";
			Query query = session.createQuery(hql);
			query.setParameter("id", id);
			
			List<Category> list = query.list();
			
			return list;
		}
}
