package com.xdt.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xdt.entity.Like;
import com.xdt.entity.Post;
import com.xdt.entity.User;

@Transactional
@Controller
@RequestMapping("like")
public class LikeController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;

	@RequestMapping("index")
	public String index(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Like";
		Query query = session.createQuery(hql);
		List<Like> list = query.list();
		model.addAttribute("like", list);
		return "like/index";
	}

	@RequestMapping(value = "insert/{idCategory}/{idPost}")
	public String insert(ModelMap model, @PathVariable("idPost") int idPost, @PathVariable("idCategory") int idCate, HttpSession sess) {
		Post post = getPost(idPost).get(0);
		User user = getUser(sess).get(0);
		Like like = new Like();
		like.setPost(post);
		like.setUser(user);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(like);
			t.commit();
			model.addAttribute("message", "Thêm mới thành công!");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Thêm mới thất bại!");
		} finally {
			session.close();
		}
		return "redirect:/post/" + idCate + "/" + idPost + ".htm";
	}
	
	@RequestMapping(value = "delete/{idCategory}/{idPost}")
	public String delete(ModelMap model, @PathVariable("idPost") int idPost, @PathVariable("idCategory") int idCate, HttpSession sess) {
		Session session = factory.getCurrentSession();
		String hql = "DELETE FROM Like l WHERE l.user.UserId = " + sess.getAttribute("userIdS").toString() + " AND l.post.PostId = " + idPost;
		Query query = session.createQuery(hql);

		query.executeUpdate();
		return "redirect:/post/" + idCate + "/" + idPost + ".htm";
	}

	public List<User> getUser(HttpSession sess) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE UserName = '" + sess.getAttribute("usernameS") + "'";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		return list;
	}

	public List<Post> getPost(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Post p WHERE p.PostId = " + id;
		Query query = session.createQuery(hql);
		List<Post> list = query.list();
		return list;
	}
}
