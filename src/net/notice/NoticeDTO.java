package net.notice;

public class NoticeDTO {
	private int noticeno;
	private String subject;
	private String content;
	private String regdt;
	private int readcnt;
	
	public NoticeDTO() {}

	public int getNoticeno() {
		return noticeno;
	}

	public void setNoticeno(int noticeno) {
		this.noticeno = noticeno;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdt() {
		return regdt;
	}

	public void setRegdt(String regdt) {
		this.regdt = regdt;
	}

	public int getReadcnt() {
		return readcnt;
	}

	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}

	@Override
	public String toString() {
		return "NoticeDTO [noticeno=" + noticeno + ", subject=" + subject + ", content=" + content + ", regdt=" + regdt + ", readcnt=" + readcnt
				+ "]";
	}

	
	
}

