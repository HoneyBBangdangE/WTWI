package com.wtwi.fin.auth;

public interface SnsUrls {
	static final String NAVER_ACCESS_TOKEN = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
	static final String NAVER_AUTH = "https://nid.naver.com/oauth2.0/authorize";
	
	static final String GOOGLE_PROFILE_URL = "https://www.googleapis.com/oauth2/v3/userinfo";
	static final String NAVER_PROFILE_URL = "https://openapi.naver.com/v1/nid/me";
}
  