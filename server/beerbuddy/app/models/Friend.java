package models;

import java.util.List;

import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Entity;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import play.db.jpa.JPA;

@Entity
@IdClass(FriendFK.class)
public class Friend {
	
	@Id
	public Long user_id1;

	@Id
	public Long user_id2;
	
	public static List<Friend> findAllFriends(User user) {
		try {
			/*
		    CriteriaBuilder cb = JPA.em().getCriteriaBuilder();
		    CriteriaQuery<Friend> query = cb.createQuery(Friend.class);
		    Root<Friend> friend = query.from(Friend.class);
		    query.where(cb.equal(friend.get("user_id1"), user.id));
		    return JPA.em().createQuery(query).getResultList();
		    */
			List<Friend> friends = (List<Friend>)JPA.em()
	                .createQuery("from Friend f where f.user_id1=?")
	                .setParameter(1, user.id)
	                .getResultList();
			return friends;
		} catch (NoResultException nre) {
		    return null;
		} catch (NonUniqueResultException nure) {
		    return null;
		}
	}

	public static Friend findFriendship(Long userId1, Long userId2) {
		try {
			/*
		    CriteriaBuilder cb = JPA.em().getCriteriaBuilder();
		    CriteriaQuery<Friend> query = cb.createQuery(Friend.class);
		    Root<Friend> friend = query.from(Friend.class);
		    query.where(cb.and(cb.equal(friend.get("user_id1"), userId1), cb.equal(friend.get("user_id2"), userId2)));
		    return JPA.em().createQuery(query).getSingleResult();
		    */
			Friend friend = (Friend)JPA.em()
	                .createQuery("from Friend f where f.user_id1=? and f.user_id2=?")
	                .setParameter(1, userId1)
	                .setParameter(2, userId2)
	                .getSingleResult();

			return friend;
		} catch (NoResultException nre) {
		    return null;
		} catch (NonUniqueResultException nure) {
		    return null;
		}
	}

	public static void saveRelationship(User user1, User user2) {
		Friend relationship = Friend.findFriendship(user1.id, user2.id);
		if (relationship == null) {
			Friend f1 = new Friend();
			f1.user_id1 = user1.id;
			f1.user_id2 = user2.id;
			JPA.em().persist(f1);
		}
		
		relationship = Friend.findFriendship(user2.id, user1.id);
		if (relationship == null) {
			Friend f2 = new Friend();
			f2.user_id1 = user2.id;
			f2.user_id2 = user1.id;
			JPA.em().persist(f2);
		}
	}
}
