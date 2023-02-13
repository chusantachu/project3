package com.spring.learn.user;

public class MemberChatRoomListVO {

		private String
		chatroomNo, senderId, receiverId, senderName, receiverName, chatContents, chatRegdate, lastChater
		,chatStatus
		;

		public String getChatroomNo() {
			return chatroomNo;
		}

		public void setChatroomNo(String chatroomNo) {
			this.chatroomNo = chatroomNo;
		}

		public String getSenderId() {
			return senderId;
		}

		public void setSenderId(String senderId) {
			this.senderId = senderId;
		}

		public String getReceiverId() {
			return receiverId;
		}

		public void setReceiverId(String receiverId) {
			this.receiverId = receiverId;
		}

		public String getSenderName() {
			return senderName;
		}

		public void setSenderName(String senderName) {
			this.senderName = senderName;
		}

		public String getReceiverName() {
			return receiverName;
		}

		public void setReceiverName(String receiverName) {
			this.receiverName = receiverName;
		}

		public String getChatContents() {
			return chatContents;
		}

		public void setChatContents(String chatContents) {
			this.chatContents = chatContents;
		}

		public String getChatRegdate() {
			return chatRegdate;
		}

		public void setChatRegdate(String chatRegdate) {
			this.chatRegdate = chatRegdate;
		}

		public String getLastChater() {
			return lastChater;
		}

		public void setLastChater(String lastChater) {
			this.lastChater = lastChater;
		}
		
		public String getChatStatus() {
			return chatStatus;
		}

		public void setChatStatus(String chatStatus) {
			this.chatStatus = chatStatus;
		}

		@Override
		public String toString() {
			return "MemberChatRoomListVO [chatroomNo=" + chatroomNo + ", senderId=" + senderId + ", receiverId="
					+ receiverId + ", senderName=" + senderName + ", receiverName=" + receiverName + ", chatContents="
					+ chatContents + ", chatRegdate=" + chatRegdate + ", lastChater=" + lastChater + ", chatStatus="
					+ chatStatus + "]";
		}

}
