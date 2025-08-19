package com.operations.setup.questionnaire;

import com.common.ClsCommon;

public class ClsQuestionnaireBean {
	ClsCommon com=new ClsCommon();
	private int docno;
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	private String date;
	private String txttype;
	private String servicetype;
	private int servicedocno;
	private int chkcomagent;
	private int txtdocno;
	private String txtquestion;
	private String mode;
	private String msg;
	private String deleted;
	private String formdetailcode;
	private String url;
	private int masterdoc_no;
	private int gridlen;
	
	
	public String getServicetype() {
		return servicetype;
	}
	public void setServicetype(String servicetype) {
		this.servicetype = servicetype;
	}
	public int getServicedocno() {
		return servicedocno;
	}
	public void setServicedocno(int servicedocno) {
		this.servicedocno = servicedocno;
	}
	public int getChkcomagent() {
		return chkcomagent;
	}
	public void setChkcomagent(int chkcomagent) {
		this.chkcomagent = chkcomagent;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTxttype() {
		return txttype;
	}
	public void setTxttype(String txttype) {
		this.txttype = txttype;
	}
	public int getTxtdocno() {
		return txtdocno;
	}
	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}
	public String getTxtquestion() {
		return txtquestion;
	}
	public void setTxtquestion(String txtquestion) {
		this.txtquestion = txtquestion;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getGridlen() {
		return gridlen;
	}
	public void setGridlen(int gridlen) {
		this.gridlen = gridlen;
	}
	
	
}
