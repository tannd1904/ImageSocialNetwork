package com.xdt.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "LIKEDISLIKEPOST")
public class Like {
	@Id @GeneratedValue
	private Integer LikeId;
	
	@ManyToOne
	@JoinColumn(name = "PostId")
	private Post post;
	
	@ManyToOne
	@JoinColumn(name = "UserId")
	private User user;

	public Integer getLikeId() {
		return LikeId;
	}

	public void setLikeId(Integer likeId) {
		LikeId = likeId;
	}

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}
