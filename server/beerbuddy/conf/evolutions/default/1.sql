# --- First database schema

# --- !Ups

create table User (
  id					bigint not null,
  accessToken			varchar(255) not null,
  firstName				varchar(255),
  lastName				varchar(255),
  location_id			bigint,
  active				smallint,
  constraint pk_user primary key (id))
;

create table Friend (
  user_id1				bigint not null,
  user_id2				bigint not null,
  constraint pk_friend primary key (user_id1,user_id2))
;

create table Location (
  id					bigint not null,
  user_id				bigint not null,
  lat					float not null,
  lon					float not null,
  constraint pk_location primary key (id))
;

create sequence location_seq start with 1000;


# --- !Downs

SET REFERENTIAL_INTEGRITY FALSE;

drop table if exists User;

drop table if exists Location;

SET REFERENTIAL_INTEGRITY TRUE;

drop sequence if exists user_seq;

