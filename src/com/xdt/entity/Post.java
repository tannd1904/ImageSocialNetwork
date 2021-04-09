package com.xdt.entity;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "POST")
public class Post {
	@Id @GeneratedValue
	private Integer PostId;
	private String ContentPost;
	private String Photo;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	private Date DayCreated;
	private Boolean OnlyMe;
	
	@ManyToOne
	@JoinColumn(name = "CategoryId")
	private Category category;

	@OneToMany(mappedBy = "post", fetch = FetchType.EAGER)
	private Collection<Like> like;
	
	@OneToMany(mappedBy = "post", fetch = FetchType.EAGER)
	private Collection<Comment> comment;

	public Collection<Comment> getComment() {
		return comment;
	}

	public void setComment(Collection<Comment> comment) {
		this.comment = comment;
	}

	public Collection<Like> getLike() {
		return like;
	}

	public void setLike(Collection<Like> like) {
		this.like = like;
	}

	public Integer getPostId() {
		return PostId;
	}

	public void setPostId(Integer postId) {
		PostId = postId;
	}

	public String getContentPost() {
		return ContentPost;
	}

	public void setContentPost(String contentPost) {
		ContentPost = contentPost;
	}

	public String getPhoto() {
		return Photo;
	}

	public void setPhoto(String photo) {
		Photo = photo;
	}

	public Date getDayCreated() {
		return DayCreated;
	}

	public void setDayCreated(Date dayCreated) {
		DayCreated = dayCreated;
	}

	public Boolean getOnlyMe() {
		return OnlyMe;
	}

	public void setOnlyMe(Boolean onlyMe) {
		OnlyMe = onlyMe;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}
}
