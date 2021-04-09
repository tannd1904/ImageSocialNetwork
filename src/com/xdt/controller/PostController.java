package com.xdt.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.annotation.MultipartConfig;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.xdt.entity.Category;
import com.xdt.entity.Comment;
import com.xdt.entity.Like;
import com.xdt.entity.Post;

@Transactional
@Controller
@RequestMapping("post")
public class PostController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;

	@RequestMapping("index")
	public String index(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Post";
		Query query = session.createQuery(hql);
		List<Post> list = query.list();
//		System.out.println(list.get(0).getTenSach());
		model.addAttribute("posts", list);
		return "post/index";
	}

	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public String insert(ModelMap model) {
		model.addAttribute("post", new Post());
		return "post/insert";
	}

	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insert(ModelMap model, @ModelAttribute("post") Post post, HttpServletRequest req,
			@RequestParam("photoPost") MultipartFile photo, HttpSession sess) {

		String ContentPost = req.getParameter("ContentPost");
		String OnlyMe = req.getParameter("OnlyMe");

		if (ContentPost.trim().length() == 0) {
			model.addAttribute("err", "Bạn chưa nhập nội dung bài viết!");
			return "post/insert";
		}
		model.addAttribute("cont", ContentPost);
		if (photo.isEmpty() == true) {
			model.addAttribute("err", "Bạn chưa chọn ảnh!");
			return "post/insert";
		}
		String[] extPhoto = {"image/jpg","image/bmp","image/gif","image/jpeg","image/png","image/tiff","image/webp"};
		boolean flagPhoto = false;
		for(int i = 0; i < extPhoto.length; i++) {
//			System.out.println(extPhoto[i]);
			if(extPhoto[i].equals(photo.getContentType())){
				flagPhoto = true;
				break;
			}
		}
		if(flagPhoto == false) {
			model.addAttribute("err", "Bạn chỉ được chọn file có định dạng là hinh ảnh!");
			return "post/insert";
		}
//		System.out.println(photo.getContentType());
		model.remove("cont");
		String path = "/posts/" + "post_" + sess.getAttribute("usernameS").toString() +"_" + photo.getOriginalFilename();

		post.setContentPost(ContentPost);
		post.setOnlyMe(true);

		if (OnlyMe == null) {
			post.setOnlyMe(false);
		}

		post.setDayCreated(new Date());

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {

			if (photo.isEmpty() == false) {
				post.setPhoto(path);
				String photoPath = context.getRealPath(path);
				photo.transferTo(new File(photoPath));
			}

			session.save(post);
			t.commit();
			model.addAttribute("message", "OK");
		} catch (Exception e) {
			model.addAttribute("message", "Lỗi");
			e.printStackTrace();
			t.rollback();
		} finally {
			session.close();
		}

		return "redirect:/" + sess.getAttribute("usernameS") + ".htm";
	}

	@ModelAttribute("category")
	public List<Category> getCategory(HttpSession sess) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Category c WHERE c.user.UserName = '" + sess.getAttribute("usernameS") + "'";
		Query query = session.createQuery(hql);
		List<Category> list = query.list();
		return list;
	}

	public List<Post> getPost(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Post p WHERE p.PostId = " + id;
		Query query = session.createQuery(hql);
		List<Post> list = query.list();
		return list;
	}

	@RequestMapping("{idCategory}/{id}")
	public String getDetail(ModelMap model, @PathVariable("id") int id, @PathVariable("idCategory") int idC,
			HttpSession sess) {
		Session session = factory.getCurrentSession();
		// lấy nội dung bài viết
		String hql = "FROM Post p WHERE p.PostId = " + id;
		Query query = session.createQuery(hql);
		List<Post> list = query.list();
		hql = "FROM Category c WHERE c.CategoryId = " + idC;
		query = session.createQuery(hql);
		List<Category> listC = query.list();
		// kiểm tra like
		hql = "FROM Like l WHERE l.user.UserId = " + sess.getAttribute("userIdS").toString() + " AND l.post.PostId = "
				+ id;
		query = session.createQuery(hql);
		List<Like> listL = query.list();
		hql = "FROM Like l WHERE l.post.PostId = " + id;
		query = session.createQuery(hql);
		List<Like> listL1 = query.list();
		// lấy bình luận
		hql = "FROM Comment c WHERE c.post.PostId = " + id + " ORDER BY CmtId DESC";
		query = session.createQuery(hql);
		List<Comment> listCmt = query.list();

		model.addAttribute("listCmt", listCmt);
		model.addAttribute("cmt", new Comment());

		model.addAttribute("post", list.get(0));
		model.addAttribute("category", listC.get(0));

		model.addAttribute("userLike", listL);
		model.addAttribute("amountLike", listL1.size());
		return "post/detail";
	}

	@RequestMapping(value = "update/{idCate}/{id}", method = RequestMethod.POST)
	public String update(ModelMap model, HttpServletRequest req, @PathVariable("id") int id, @PathVariable("idCate") int idCate) {

		String ContentPost = req.getParameter("ContentPost");
		String OnlyMe = req.getParameter("OnlyMe");

		Post p = getPost(id).get(0);

		p.setContentPost(ContentPost);
		p.setOnlyMe(true);

		if (OnlyMe == null) {
			p.setOnlyMe(false);
		}

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			session.update(p);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/post/" + idCate + "/" + id + ".htm";
	}

	
	@RequestMapping(value = "delete/{id}")
	public String delete(ModelMap model, @PathVariable("id") int id, HttpSession sess) {
		Session session = factory.getCurrentSession();
		String hql = "DELETE FROM Post p WHERE p.PostId = :id";
		Query query = session.createQuery(hql).setParameter("id", id);

		query.executeUpdate();
		return "redirect:/" + sess.getAttribute("usernameS") + ".htm";
	}
}
