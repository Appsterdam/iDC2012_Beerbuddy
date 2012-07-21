package models;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;

import play.db.jpa.JPA;

@Entity
public class User {

	@Id
	public Long id;

	@JsonIgnore
	public String accessToken;

	@JsonProperty("first_name")
	public String firstName;
	
	@JsonProperty("last_name")
	public String lastName;

	@OneToOne(optional=true, cascade=CascadeType.ALL)
	@PrimaryKeyJoinColumn
	public Location location;

	@JsonIgnore
	public Integer active;

	public static User findByAccessToken(String accessToken) {
		try {
			CriteriaBuilder cb = JPA.em().getCriteriaBuilder();
			CriteriaQuery<User> query = cb.createQuery(User.class);
			Root<User> user = query.from(User.class);
			query.where(cb.equal(user.get("accessToken"), accessToken));
			return JPA.em().createQuery(query).getSingleResult();
		} catch (NoResultException nre) {
			return null;
		} catch (NonUniqueResultException nure) {
			return null;
		}
	}

	public static User findFriend(Long id) {
		return JPA.em().find(User.class, id);
	}
}
