package com.limousine.limobooking;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsLimoBookingAction {
	ClsCommon objcommon=new ClsCommon();
	ClsLimoBookingDAO bookingdao=new ClsLimoBookingDAO();
	private String refno;
	private int docno;
	private String vocno;
	private String date;
	private String client;
	private String clientdetails;
	private String hidclient;
	private String guest;
	private String hidguest;
	private String chknewguest;
	private String hidchknewguest;
	private String mode;
	private String msg;
	private String deleted;
	private String guestcontactno;
	private String formdetailcode;
	private String brchName;
	private int transfergridlength;
	private int hoursgridlength;
	private int guestgridlength;
	private int othersrvcgridlength;
	private int billinggridlength;
	private String description;
	private String txtairport;
	private String txtflightno;
	private String txthotelname;
	private String txtroomno;
	private String cmbloctype;
	private String cmbloc;
	private String vesselno;
	private String vesselname;
	
	
	
	public int getGuestgridlength() {
		return guestgridlength;
	}

	public void setGuestgridlength(int guestgridlength) {
		this.guestgridlength = guestgridlength;
	}

	public String getVesselno() {
		return vesselno;
	}

	public void setVesselno(String vesselno) {
		this.vesselno = vesselno;
	}

	public String getVesselname() {
		return vesselname;
	}

	public void setVesselname(String vesselname) {
		this.vesselname = vesselname;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getVocno() {
		return vocno;
	}

	public void setVocno(String vocno) {
		this.vocno = vocno;
	}

	public String getCmbloc() {
		return cmbloc;
	}

	public void setCmbloc(String cmbloc) {
		this.cmbloc = cmbloc;
	}
	
	public String getCmbloctype() {
		return cmbloctype;
	}

	public void setCmbloctype(String cmbloctype) {
		this.cmbloctype = cmbloctype;
	}
	
	public String getTxtairport() {
		return txtairport;
	}

	public void setTxtairport(String txtairport) {
		this.txtairport = txtairport;
	}

	public String getTxtflightno() {
		return txtflightno;
	}

	public void setTxtflightno(String txtflightno) {
		this.txtflightno = txtflightno;
	}

	public String getTxthotelname() {
		return txthotelname;
	}

	public void setTxthotelname(String txthotelname) {
		this.txthotelname = txthotelname;
	}

	public String getTxtroomno() {
		return txtroomno;
	}

	public void setTxtroomno(String txtroomno) {
		this.txtroomno = txtroomno;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getTransfergridlength() {
		return transfergridlength;
	}

	public void setTransfergridlength(int transfergridlength) {
		this.transfergridlength = transfergridlength;
	}

	public int getHoursgridlength() {
		return hoursgridlength;
	}

	public void setHoursgridlength(int hoursgridlength) {
		this.hoursgridlength = hoursgridlength;
	}

	public int getOthersrvcgridlength() {
		return othersrvcgridlength;
	}

	public void setOthersrvcgridlength(int othersrvcgridlength) {
		this.othersrvcgridlength = othersrvcgridlength;
	}

	public int getBillinggridlength() {
		return billinggridlength;
	}

	public void setBillinggridlength(int billinggridlength) {
		this.billinggridlength = billinggridlength;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getClientdetails() {
		return clientdetails;
	}

	public void setClientdetails(String clientdetails) {
		this.clientdetails = clientdetails;
	}

	public String getHidclient() {
		return hidclient;
	}

	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
	}

	public String getGuest() {
		return guest;
	}

	public void setGuest(String guest) {
		this.guest = guest;
	}

	public String getHidguest() {
		return hidguest;
	}

	public void setHidguest(String hidguest) {
		this.hidguest = hidguest;
	}

	public String getChknewguest() {
		return chknewguest;
	}

	public void setChknewguest(String chknewguest) {
		this.chknewguest = chknewguest;
	}

	public String getHidchknewguest() {
		return hidchknewguest;
	}

	public void setHidchknewguest(String hidchknewguest) {
		this.hidchknewguest = hidchknewguest;
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

	public String getGuestcontactno() {
		return guestcontactno;
	}

	public void setGuestcontactno(String guestcontactno) {
		this.guestcontactno = guestcontactno;
	}

	public void setValues(int docno,java.sql.Date sqldate,String vocno){
		setDocno(docno);
		setVocno(vocno);
		setDate(sqldate.toString());
		setClient(getClient());
		setHidclient(getHidclient());
		setClientdetails(getClientdetails());
		setGuest(getGuest());
		setHidguest(getHidguest());
		setHidchknewguest(getHidchknewguest());
		setDescription(getDescription());
		setTxtairport(getTxtairport());
		setTxtflightno(getTxtflightno());
		setTxthotelname(getTxthotelname());
		setTxtroomno(getTxtroomno());
		setCmbloctype(getCmbloctype());
		setCmbloc(getCmbloctype());
		setRefno(getRefno());
		setVesselno(getVesselno());
		setVesselname(getVesselname());
	}
	public String saveAction() throws SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		java.sql.Date sqldate=null;
		if(getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		ArrayList<String> transferarray=new ArrayList<>();
		ArrayList<String> hoursarray=new ArrayList<>();
		ArrayList<String> guestarray=new ArrayList<>();
		ArrayList<String> billarray=new ArrayList<>();
		ArrayList<String> newtransferarray=new ArrayList<>();
		ArrayList<String> newhoursarray=new ArrayList<>();
		
		if(getGuestgridlength()>0) {
			for(int i=0;i<getGuestgridlength();i++){
				String temp=requestParams.get("guest"+i)[0];
				guestarray.add(temp);
			}
		}
		
		
		if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("tarifinsert")){
		if(getTransfergridlength()>0){
			for(int i=0;i<getTransfergridlength();i++){
				String temp=requestParams.get("transfer"+i)[0];
				transferarray.add(temp);
			}
			int transferjobserial=1;
			for(int i=0;i<transferarray.size();i++){
				if(!transferarray.get(i).split("::")[9].equalsIgnoreCase("") && !transferarray.get(i).split("::")[9].equalsIgnoreCase("undefined") && transferarray.get(i).split("::")[9]!=null){
					for(int j=0;j<Integer.parseInt(transferarray.get(i).split("::")[9]);j++){
						String temp[]=transferarray.get(i).split("::");
						newtransferarray.add("T"+transferjobserial+"::"+temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+1+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]+"::"+temp[21]+"::"+temp[22]+"::"+temp[23]+"::"+temp[24]+"::"+temp[25]+"::"+temp[26]);
						System.out.println("T"+transferjobserial+"::"+temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+1+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]+"::"+temp[21]+"::"+temp[22]+"::"+temp[23]+"::"+temp[24]+"::"+temp[25]+"::"+temp[26]);
						transferjobserial++;
					}
				}
			}
		}
		if(getHoursgridlength()>0){
			for(int i=0;i<getHoursgridlength();i++){ 
				String temp=requestParams.get("hours"+i)[0];
				hoursarray.add(temp);
			}
			int hoursjobserial=1;
			for(int i=0;i<hoursarray.size();i++){ 
			    System.out.println("This is hours array"+hoursarray.get(i));
				String tempdays=hoursarray.get(i).split("::")[13];
				tempdays=tempdays.trim();
				int days=0;
				if(tempdays.equalsIgnoreCase("") || tempdays.equalsIgnoreCase("undefined") || tempdays==null){
					days=1;
				}
				else if(Integer.parseInt(tempdays)==0 || Integer.parseInt(tempdays)==1){
					days=1;
				}
				else{
					days=Integer.parseInt(tempdays);
				}
				if(!hoursarray.get(i).split("::")[7].trim().equalsIgnoreCase("") && !hoursarray.get(i).split("::")[7].trim().equalsIgnoreCase("undefined") && hoursarray.get(i).split("::")[7].trim()!=null){
				for(int j=0;j<Integer.parseInt(hoursarray.get(i).split("::")[7].trim());j++){
					
					String temppickupdate=hoursarray.get(i).split("::")[1].trim();
					if(!temppickupdate.equalsIgnoreCase("") && temppickupdate!=null && !temppickupdate.equalsIgnoreCase("undefined")){
						String strpickupdate="";
						for(int k=0;k<days;k++){
							if(k==0){
								strpickupdate=bookingdao.getLimoDateAdd(temppickupdate,1);
								
							}
							else{
								strpickupdate=bookingdao.getLimoDateAdd(strpickupdate,2);
							}
							String temp[]=hoursarray.get(i).split("::");
							for(int z=0;z<temp.length;z++) System.out.println(temp[z]);
							System.out.println("L"+hoursjobserial+"::"+strpickupdate+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+"1"+"::"+(temp[8].equalsIgnoreCase("undefined") || temp[8].equalsIgnoreCase("") || !(temp[8]!= null)?"0":temp[8])+"::"+temp[9]+"::"+(temp[10].equalsIgnoreCase("undefined") || temp[10].equalsIgnoreCase("") || !(temp[10]!= null)?"0":temp[10])+"::"+temp[11]+"::"+(temp[12].equalsIgnoreCase("undefined") || temp[12].equalsIgnoreCase("") || !(temp[12]!= null)?"0":temp[12])+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]+"::"+temp[21]+"::"+temp[22]+"::"+temp[23]);
							newhoursarray.add("L"+hoursjobserial+"::"+strpickupdate+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+"1"+"::"+(temp[8].equalsIgnoreCase("undefined") || temp[8].equalsIgnoreCase("") || !(temp[8]!= null)?"0":temp[8])+"::"+temp[9]+"::"+(temp[10].equalsIgnoreCase("undefined") || temp[10].equalsIgnoreCase("") || !(temp[10]!= null)?"0":temp[10])+"::"+temp[11]+"::"+(temp[12].equalsIgnoreCase("undefined") || temp[12].equalsIgnoreCase("") || !(temp[12]!= null)?"0":temp[12])+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]+"::"+temp[21]+"::"+temp[22]+"::"+temp[23]);
							hoursjobserial++;
						}
					}	
				}
				}
				
			}
		}
		}
		if(!mode.equalsIgnoreCase("tarifinsert") && !mode.equalsIgnoreCase("D")){
			if(getBillinggridlength()>0){
				for(int i=0;i<getBillinggridlength();i++){
					String temp=requestParams.get("bill"+i)[0];
					System.out.println("TariffInsert - "+temp);
					billarray.add(temp);
				}
			}
		}
		if(mode.equalsIgnoreCase("A")){
			System.out.println("Inside action");
			ClsLimoBookingAction masteraction=new ClsLimoBookingAction();
			masteraction.setVesselno(getVesselno());
			masteraction.setVesselname(getVesselname());
			masteraction.setRefno(getRefno());
			int val=bookingdao.insert(sqldate,getHidclient(),getHidguest(),getGuest(),getGuestcontactno(),getHidchknewguest(),session,getMode(),getFormdetailcode(),getBrchName(),getDescription(),getTxtairport(),getTxtflightno(),getTxthotelname(),getTxtroomno(),getCmbloctype(),masteraction);
			if(val>0){
				boolean status=bookingdao.insertTarif(val,newtransferarray,newhoursarray,session,mode);
				
				boolean gueststatus = bookingdao.insertGuest(val,guestarray,session,mode);
				
				if(!gueststatus) {
					setValues(val, sqldate,session.getAttribute("LIMOBOOKVOCNO").toString());
					setMsg("Not Saved");
					return "fail";
				}
				
				if(status){
					int billval=bookingdao.insertBill(val,billarray);
					if(billval>0){
						setValues(val, sqldate,session.getAttribute("LIMOBOOKVOCNO").toString());
						setMsg("Successfully Saved");
						return "success";
					}
					else{
						setValues(val, sqldate,session.getAttribute("LIMOBOOKVOCNO").toString());
						setMsg("Not Saved");
						return "fail";
					}
				}
				else{
					setValues(val, sqldate,session.getAttribute("LIMOBOOKVOCNO").toString());
					setMsg("Not Saved");
					return "fail";
				}
			}
			else{
				setValues(val, sqldate,session.getAttribute("LIMOBOOKVOCNO").toString());
				setMsg("Not Saved");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("E")){
		    if(getTransfergridlength()>0){
                for(int i=0;i<getTransfergridlength();i++){
                    String temp=requestParams.get("transfer"+i)[0];
                    transferarray.add(temp);
                }
                int transferjobserial=1;
                System.out.println("transfer array size  - "+transferarray.size());
                for(int i=0;i<transferarray.size();i++){
                    if(!transferarray.get(i).split("::")[9].equalsIgnoreCase("") && !transferarray.get(i).split("::")[9].equalsIgnoreCase("undefined") && transferarray.get(i).split("::")[9]!=null){
                        for(int j=0;j<Integer.parseInt(transferarray.get(i).split("::")[9]);j++){
                            String temp[]=transferarray.get(i).split("::");
                            newtransferarray.add("T"+transferjobserial+"::"+temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+1+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]+"::"+temp[21]+"::"+temp[22]+"::"+temp[23]+"::"+temp[24]+"::"+temp[25]+"::"+temp[26]);
                            System.out.println("T"+transferjobserial+"::"+temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+1+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]+"::"+temp[21]+"::"+temp[22]+"::"+temp[23]+"::"+temp[24]+"::"+temp[25]+"::"+temp[26]);
                            transferjobserial++;
                        }
                    }
                }
            }
            
            if(getHoursgridlength()>0){
                for(int i=0;i<getHoursgridlength();i++){ 
                    String temp=requestParams.get("hours"+i)[0].trim();
                    hoursarray.add(temp);
                }
                int hoursjobserial=1;
                for(int i=0;i<hoursarray.size();i++){ 
                    System.out.println("This is hours array"+hoursarray.get(i));
                    String tempdays=hoursarray.get(i).split("::")[13];
                    tempdays=tempdays.trim();
                    int days=0;
                    if(tempdays.equalsIgnoreCase("") || tempdays.equalsIgnoreCase("undefined") || tempdays==null){
                        days=1;
                    }
                    else if(Integer.parseInt(tempdays)==0 || Integer.parseInt(tempdays)==1){
                        days=1;
                    }
                    else{
                        days=Integer.parseInt(tempdays);
                    }
                    if(!hoursarray.get(i).split("::")[7].trim().equalsIgnoreCase("") && !hoursarray.get(i).split("::")[7].trim().equalsIgnoreCase("undefined") && hoursarray.get(i).split("::")[7].trim()!=null){
                    for(int j=0;j<Integer.parseInt(hoursarray.get(i).split("::")[7].trim());j++){
                        
                        String temppickupdate=hoursarray.get(i).split("::")[1].trim();
                        if(!temppickupdate.equalsIgnoreCase("") && temppickupdate!=null && !temppickupdate.equalsIgnoreCase("undefined")){
                            String strpickupdate="";
                            for(int k=0;k<days;k++){
                                if(k==0){
                                    strpickupdate=bookingdao.getLimoDateAdd(temppickupdate,1);
                                    
                                }
                                else{
                                    strpickupdate=bookingdao.getLimoDateAdd(strpickupdate,2);
                                }
                                String temp[]=hoursarray.get(i).split("::");
                                for(int z=0;z<temp.length;z++) System.out.println(temp[z]);
//                              System.out.println("L"+hoursjobserial+"::"+strpickupdate+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+"1"+"::"+(temp[8].equalsIgnoreCase("undefined") || temp[8].equalsIgnoreCase("") || !(temp[8]!= null)?"0":temp[8])+"::"+temp[9]+"::"+(temp[10].equalsIgnoreCase("undefined") || temp[10].equalsIgnoreCase("") || !(temp[10]!= null)?"0":temp[10])+"::"+temp[11]+"::"+(temp[12].equalsIgnoreCase("undefined") || temp[12].equalsIgnoreCase("") || !(temp[12]!= null)?"0":temp[12])+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]);
                                newhoursarray.add("L"+hoursjobserial+"::"+strpickupdate+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+"1"+"::"+(temp[8].equalsIgnoreCase("undefined") || temp[8].equalsIgnoreCase("") || !(temp[8]!= null)?"0":temp[8])+"::"+temp[9]+"::"+(temp[10].equalsIgnoreCase("undefined") || temp[10].equalsIgnoreCase("") || !(temp[10]!= null)?"0":temp[10])+"::"+temp[11]+"::"+(temp[12].equalsIgnoreCase("undefined") || temp[12].equalsIgnoreCase("") || !(temp[12]!= null)?"0":temp[12])+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]+"::"+temp[21]+"::"+temp[22]+"::"+temp[23]);
                                hoursjobserial++;
                            }
                        }   
                    }
                    }
                    
                }
            }
			ClsLimoBookingAction masteraction=new ClsLimoBookingAction();
			masteraction.setVesselno(getVesselno());
			masteraction.setVesselname(getVesselname());
			masteraction.setRefno(getRefno());
			boolean status=bookingdao.edit(getDocno(),sqldate,getHidclient(),getHidguest(),getGuest(),getGuestcontactno(),getHidchknewguest(),session,getMode(),getFormdetailcode(),getBrchName(),getDescription(),getTxtairport(),getTxtflightno(),getTxthotelname(),getTxtroomno(),getCmbloctype(),masteraction);
			if(status){
				boolean statusTariff=bookingdao.insertTarif(getDocno(),newtransferarray,newhoursarray,session,getMode());
				
boolean 		gueststatus = bookingdao.insertGuest(getDocno(),guestarray,session,mode);
				
				if(!gueststatus) {
					setValues(getDocno(), sqldate,session.getAttribute("LIMOBOOKVOCNO").toString());
					setMsg("Not Saved");
					return "fail";
				}
				
				if(statusTariff){
					int billval=bookingdao.insertBill(getDocno(),billarray);
					if(billval>0){
						setValues(getDocno(), sqldate,getVocno());
						setMsg("Updated Successfully");
						return "success";
					}
					else{
						setValues(getDocno(), sqldate,getVocno());
						setMsg("Not Updates");
						return "fail";
					}
				}
				else{
					setValues(getDocno(), sqldate,getVocno());
					setMsg("Not Saved");
					return "fail";
				}
				
			}
			else{
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int status=bookingdao.delete(getDocno(),sqldate,getHidclient(),getHidguest(),getGuest(),getGuestcontactno(),getHidchknewguest(),session,getMode(),getFormdetailcode(),getBrchName());
			if(status==1){
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Successfully Deleted");
				return "success";
			}
			else if (status==-1) {
                setValues(getDocno(), sqldate,getVocno());
                setMsg("Not Deleted, Already assigned");
                return "fail";
            }
			else{
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Not Deleted");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("tarifinsert")){
			
			boolean status=bookingdao.insertTarif(getDocno(),newtransferarray,newhoursarray,session,mode);
			if(status){
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("srvcinsert")){
			ArrayList<String> srvcarray=new ArrayList<>();
			
			if(getOthersrvcgridlength()>0){
				for(int i=0;i<getOthersrvcgridlength();i++){
					String temp=requestParams.get("srvc"+i)[0];
					srvcarray.add(temp);
				}
			}
			
			boolean status=bookingdao.insertSrvc(getDocno(),srvcarray,billarray);
			if(status){
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Not Updated");
				return "fail";
			}
		}
		return "fail";
	}

	
}
