package com.xdt.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "COMMENT")
public class Comment {
	@Id @GeneratedValue
	private Integer CmtId;
	
	private String ContentCmt;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	private Date DateCreated;
	
	@ManyToOne
	@JoinColumn(name = "PostId")
	private Post post;
	
	@ManyToOne
	@JoinColumn(name = "UserId")
	private User user;

	public Integer getCmtId() {
		return CmtId;
	}

	public void setCmtId(Integer cmtId) {
		CmtId = cmtId;
	}

	public String getContentCmt() {
		return ContentCmt;
	}

	public void setContentCmt(String contentCmt) {
		ContentCmt = contentCmt;
	}

	public Date getDateCreated() {
		return DateCreated;
	}

	public void setDateCreated(Date dateCreated) {
		DateCreated = dateCreated;
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