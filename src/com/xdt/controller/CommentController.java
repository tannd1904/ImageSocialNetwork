package com.xdt.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.xdt.entity.Comment;
import com.xdt.entity.Post;
import com.xdt.entity.User;

@Transactional
@Controller
@RequestMapping("comment")
public class CommentController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;

	@RequestMapping("index")
	public String index(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Comment";
		Query query = session.createQuery(hql);
		List<Comment> list = query.list();
		model.addAttribute("comment", list);
		return "comment/index";
	}

	@RequestMapping(value = "insert/{idCategory}/{idPost}")
	public String insert(ModelMap model, @PathVariable("idPost") int idPost, @PathVariable("idCategory") int idCate, HttpServletRequest req, HttpSession sess) {
		Post post = getPost(idPost).get(0);
		User user = getUser(sess).get(0);
		String cmt = req.getParameter("ContentCmt");
		
		Comment comment = new Comment();
		comment.setPost(post);
		comment.setUser(user);
		comment.setDateCreated(new Date());
		comment.setContentCmt(cmt);
		
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(comment);
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
	
	@RequestMapping(value = "update/{idCate}/{idPost}/{id}", method = RequestMethod.POST)
	public String update(ModelMap model, HttpServletRequest req, @PathVariable("id") int id, @PathVariable("idPost") int idPost,
			@PathVariable("idCate") int idCate) {

		String ContentCmt = req.getParameter("ContentComment");

		Comment c = getComment(id).get(0); 
		c.setContentCmt(ContentCmt);
		
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			session.update(c);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/post/" + idCate + "/" + idPost + ".htm";
	}
	
	@RequestMapping(value = "delete/{idCate}/{idPost}/{id}")
	public String delete(ModelMap model, @PathVariable("id") int id, @PathVariable("idPost") int idPost,
			@PathVariable("idCate") int idCate) {
		Session session = factory.getCurrentSession();
		String hql = "DELETE FROM Comment c WHERE c.CmtId = " + id;
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
	
	public List<Comment> getComment(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Comment c WHERE c.CmtId = " + id;
		Query query = session.createQuery(hql);
		List<Comment> list = query.list();
		return list;
	}
}