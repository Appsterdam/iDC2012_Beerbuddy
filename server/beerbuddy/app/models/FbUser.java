package models;

import org.codehaus.jackson.annotate.JsonProperty;

public class FbUser {
	public long id;
	public long uid;
	public String name;
	public @JsonProperty("first_name")
	String firstName;
	public @JsonProperty("last_name")
	String lastName;
}
