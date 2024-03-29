/**
 * Copyright (c) 2009, Reuben Stanton
	All rights reserved.
	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the 
	following conditions are met:
	
	    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following 
		  disclaimer.
	    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the 
		  following disclaimer in the documentation and/or other materials provided with the distribution.
	    * The name "Reuben Stanton" may not be used to endorse or promote products derived from this software without 
		  specific prior written permission.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
	INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
	SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
	SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
	WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
	OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/


package com.absentdesign.core.webapis.wordpress.events{
	
	import com.absentdesign.core.webapis.events.*;

	/**
	*  concrete ServiceEvent 
	*/
	public class WPServiceEvent extends ServiceEvent{

		public static const CONNECTED:String = "WPServiceEventConnected";
		public static const GET_USERS_BLOGS:String = "WPServiceEventGetUsersBlogs";
		public static const GET_PAGE_LIST:String = "WPServiceEventGetPageList";
		public static const GET_PAGES:String = "WPServiceEventGetPages";
		public static const GET_PAGE:String = "WPServiceEventGetPage";
		public static const DELETE_PAGE:String = "WPServiceEventDeletePage";
		public static const NEW_PAGE:String = "WPServiceEventNewPage";
		public static const GET_RECENT_POSTS:String = "WPServiceEventGetRecentPosts";
		public static const GET_RECENT_POST_TITLES:String = "WPServiceEventGetRecentPostTitles";
		public static const GET_POST_CATEGORIES:String = "WPServiceEventGetRecentPostCategories";
		public static const SET_POST_CATEGORIES:String = "WPServiceEventSetPostCategories";
		public static const EDIT_POST:String = "WPServiceEventEditPost";
		public static const GET_POST:String = "WPServiceEventGetPost";
		public static const NEW_POST:String = "WPServiceEventNewPost";
		public static const GET_CATEGORIES:String = "WPServiceEventGetCategories";
		public static const NEW_CATEGORY:String = "WPServiceEventNewCategory";
		public static const DELETE_CATEGORY:String = "WPServiceEventDeleteCategory";
		public static const SUGGEST_CATEGORIES:String = "WPServiceEventSuggestCategories";
		public static const GET_TAGS:String = "WPServiceEventGetTags";
		public static const GET_COMMENTS:String = "WPServiceEventGetComments";
		public static const GET_COMMENT:String = "WPServiceEventGetComment";
		public static const EDIT_COMMENT:String = "WPServiceEventEditComment";
		public static const DELETE_COMMENT:String = "WPServiceEventDeleteComment";
		public static const NEW_COMMENT:String = "WPServiceEventNewComment";
		public static const GET_AUTHORS:String = "WPServiceEventGetAuthors";

		/**
		* @param type The event type 
		* @param data The data to send with the event
		*/
		public function WPServiceEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean=false){
			super(type,data,bubbles,cancelable);
		}

	}


}

