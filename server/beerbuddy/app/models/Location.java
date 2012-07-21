package models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.codehaus.jackson.annotate.JsonIgnore;

import play.db.jpa.JPA;

@Entity
@SequenceGenerator(name = "location_seq", sequenceName = "location_seq")
public class Location {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "location_seq")
	@JsonIgnore
	public Long id;

	@OneToOne
	@JoinColumn(name="user_id")
	@JsonIgnore
	public User user;

	public Double lat;
	public Double lon;

	public static Location findByUser(User user) {
		try {
			CriteriaBuilder cb = JPA.em().getCriteriaBuilder();
			CriteriaQuery<Location> query = cb.createQuery(Location.class);
			Root<Location> location = query.from(Location.class);
			query.where(cb.equal(location.get("user"), user));
			return JPA.em().createQuery(query).getSingleResult();
		} catch (NoResultException nre) {
			return null;
		} catch (NonUniqueResultException nure) {
			return null;
		}
	}
	
	public static Location updateLocation(User user, Double lat, Double lon) {
		Location location = Location.findByUser(user);
		if (location != null) {
			location.lat = lat;
			location.lon = lon;
			JPA.em().merge(location);
		} else {
			location = new Location();
			location.user = user;
			location.lat = lat;
			location.lon = lon;
			JPA.em().persist(location);
		}

		return location;
	}
}
