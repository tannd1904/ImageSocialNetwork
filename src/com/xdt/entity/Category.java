package com.xdt.entity;

import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name = "CATEGORY")
public class Category {
	@Id @GeneratedValue
	private Integer CategoryId;
	private String CategoryName;
	
	@OneToMany(mappedBy = "category", fetch = FetchType.EAGER)
	private Collection<Post> post;
	
	@ManyToOne
	@JoinColumn(name = "UserId")
	private User user;
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Integer getCategoryId() {
		return CategoryId;
	}

	public void setCategoryId(Integer categoryId) {
		CategoryId = categoryId;
	}

	public String getCategoryName() {
		return CategoryName;
	}

	public void setCategoryName(String categoryName) {
		CategoryName = categoryName;
	}

	public Collection<Post> getPost() {
		return post;
	}

	public void setPost(Collection<Post> post) {
		this.post = post;
	}
}
