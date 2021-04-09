package com.xdt.entity;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "USERS")
public class User {
	@Id @GeneratedValue
	private Integer UserId;
	private String Avatar;
	private String LastName;
	private String FirstName;
	private String UserName;
	private String Password;
	private String Email;
	private String Phone;
	private String Story;
	private Integer Gender;
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	private Date Birthday;
	private Boolean IsAdmin;
	private Boolean IsActive;
	private Boolean IsLocked;
	private Boolean IsDelete;
	
	public Collection<Like> getLike() {
		return like;
	}
	public void setLike(Collection<Like> like) {
		this.like = like;
	}
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<Category> category;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<Like> like;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<Comment> comment;
	
	public Collection<Comment> getComment() {
		return comment;
	}
	public void setComment(Collection<Comment> comment) {
		this.comment = comment;
	}
	public Collection<Category> getCategory() {
		return category;
	}
	public void setCategory(Collection<Category> category) {
		this.category = category;
	}
	public Integer getUserId() {
		return UserId;
	}
	public void setUserId(Integer userId) {
		UserId = userId;
	}
	public String getAvatar() {
		return Avatar;
	}
	public void setAvatar(String avatar) {
		Avatar = avatar;
	}
	public String getLastName() {
		return LastName;
	}
	public void setLastName(String lastName) {
		LastName = lastName;
	}
	public String getFirstName() {
		return FirstName;
	}
	public void setFirstName(String firstName) {
		FirstName = firstName;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getPhone() {
		return Phone;
	}
	public void setPhone(String phone) {
		Phone = phone;
	}
	public String getStory() {
		return Story;
	}
	public void setStory(String story) {
		Story = story;
	}
	public Integer getGender() {
		return Gender;
	}
	public void setGender(Integer gender) {
		Gender = gender;
	}
	public Date getBirthday() {
		return Birthday;
	}
	public void setBirthday(Date birthday) {
		Birthday = birthday;
	}
	public Boolean getIsAdmin() {
		return IsAdmin;
	}
	public void setIsAdmin(Boolean isAdmin) {
		IsAdmin = isAdmin;
	}
	public Boolean getIsActive() {
		return IsActive;
	}
	public void setIsActive(Boolean isActive) {
		IsActive = isActive;
	}
	public Boolean getIsLocked() {
		return IsLocked;
	}
	public void setIsLocked(Boolean isLocked) {
		IsLocked = isLocked;
	}
	public Boolean getIsDelete() {
		return IsDelete;
	}
	public void setIsDelete(Boolean isDelete) {
		IsDelete = isDelete;
	}
	
	
}
