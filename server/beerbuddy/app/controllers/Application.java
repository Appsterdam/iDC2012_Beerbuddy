package controllers;

import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.annotate.JsonProperty;

import com.googlecode.batchfb.Batcher;
import com.googlecode.batchfb.FacebookBatcher;
import com.googlecode.batchfb.Later;

import models.FbPicture;
import models.FbUser;
import models.Friend;
import models.Location;
import models.User;
import play.Logger;
import play.db.jpa.JPA;
import play.db.jpa.Transactional;
import play.mvc.*;
import static play.libs.Json.toJson;

import views.html.*;

public class Application extends Controller {

	public static Result index() {
		return ok(index.render("Your new application is ready."));
	}

	@Transactional
	public static Result login(String accessToken) {
		Batcher batcher = new FacebookBatcher(accessToken);
		User user = User.findByAccessToken(accessToken);
		if (user == null) {
			// new user: get friends from facebook
			Later<FbUser> me = batcher.graph("me", FbUser.class);
			Logger.info(me.get().name);
			Later<FbPicture> picture = batcher.graph(me.get().id + "/picture", FbPicture.class);

			user = User.findById(me.get().id);
			if (user == null) {
				// save the user
				user = new User();
				user.id = me.get().id;
			}
			
			user.accessToken = accessToken;
			user.firstName = me.get().firstName;
			user.lastName = me.get().lastName;
			user.photo = String.format("http://graph.facebook.com/%s/picture", me.get().id);
			user.location = null;
			user.active = 1;
			JPA.em().persist(user);
		}

		Later<List<FbUser>> myFriends = batcher.query(
				"SELECT uid, first_name, last_name FROM user WHERE uid IN"
						+ "(SELECT uid2 FROM friend WHERE uid1 = " + user.id
						+ ")", FbUser.class);

		List<User> beerBuddies = new ArrayList<User>();
		for (int i = 0; i < myFriends.get().size(); i++) {
			FbUser fbUser = myFriends.get().get(i);
			User friend = User.findFriend(fbUser.uid);
			if (friend != null) {
				if (friend.active == 1) {
					beerBuddies.add(friend);
				}
				
				Friend.saveRelationship(user, friend);
			}
		}

		return ok(toJson(new JsonFriends(beerBuddies)));
	}

	@Transactional
	public static Result logout(String accessToken) {
		User user = User.findByAccessToken(accessToken);
		if (user != null) {
			// new user: get friends from facebook
			user.active = 0;
			JPA.em().persist(user);
		}

		return ok(toJson("ok"));
	}

	@Transactional
	public static Result location(String accessToken, String lat, String lon) {
		User user = User.findByAccessToken(accessToken);
		if (user != null) {
			Location loc = Location.updateLocation(user, Double.valueOf(lat), Double.valueOf(lon));
			user.location = loc;
			JPA.em().persist(user);
			
			List<Friend> friends = Friend.findAllFriends(user);
			List<User> beerBuddies = new ArrayList<User>();
			for (Friend friend : friends) {
				User friendUser = User.findFriend(friend.user_id2);
				if (friend != null && friendUser.active == 1) {
					beerBuddies.add(friendUser);
				}
			}
			
			return ok(toJson(new JsonFriends(beerBuddies)));
		}
		
		return badRequest(toJson("Access denied"));
	}
	
	private static class JsonFriends {
		JsonFriends(List<User> beerBuddies) {
			this.beerBuddies = beerBuddies;
		}
		
		@JsonProperty("beer_buddies")
		public List<User> beerBuddies;
	}
}