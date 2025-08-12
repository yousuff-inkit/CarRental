package com.dashboard.vehicle.fleetlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsFleetListDAO {
    ClsConnection ClsConnection=new ClsConnection();

    ClsCommon ClsCommon=new ClsCommon();
    public JSONArray vehicleListSearch(String chk,String brch,String date) throws SQLException { 

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        try {
                 conn = ClsConnection.getMyConnection();
                Statement stmtVeh1 = conn.createStatement ();
                if(date.equalsIgnoreCase("")|| date=="0") {
                    return RESULTDATA;
                }
                java.sql.Date sqlStartDate1 = ClsCommon.changeStringtoSqlDate(date);
                if(chk.equalsIgnoreCase("load"))
                {
            String sqldata=("select a.track_id TVAL,a.* from (select coalesce(veh.accno,0) acno,coalesce(h.curid,0) curid,coalesce(h.rate,0)rate,0 taxper,COALESCE(NULLIF(m.track_id, ''), 0) AS track_id,m.dlrid dlrid,v.acc_no,v.name,s.st_desc,convert(m.cur_km,char(40)) currentkm, "
                        + "m.salik_tag,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM curdate()),EXTRACT( YEAR_MONTH FROM m.prch_dte)) age, "
                        + "m.DOC_NO,m.DATE,m.REG_NO,m.FLEET_NO,m.FLNAME,m.PRCH_INV,m.PRCH_DTE prch_dte,m.PRCH_COST,m.INST_AMT,m.INT_AMT,m.DN_PAY,i.inname INS_COMP, "
                        + "m.INS_AMT,m.PRMYM_PERC,m.PRMYM,m.INS_EXP,m.REL_DATE,m.REG_EXP,m.DEPR,m.ENG_NO,m.CH_NO,l.loc_name A_LOC,m.STATUS, "
                        + " m.SRVC_KM+m.lst_srv SRVC_KM,m.SRVC_DTE,m.LST_SRV,m.WAR,m.WAR_KM,m.CUR_KM,m.ITYPE,m.ADD1,m.VIN,m.C_FUEL,m.TRAN_CODE,"
                        + " y.YOM,m.REG_DATE,m.LPO,m.PUR_TYPE,m.NO_INST,m.FSTATUS, "
                        + "brch.branchname A_BR,m.WAR_PRD,m.CURR_VALUE,m.CATEGORY,m.renttype,m.dtype,m.comp_id,m.tcno,m.branded,f.fname finname,a.AUTHname, "
                        + "p.code_name PLTname ,g.gname VGRPname,b.brand_name BRDname,mo.vtype VMODname,v.name DLRname,brch1.branchname  BRHname,m.COSTID costname, "
                        + "c.color CLRname,m.WAREND,m.STATU,m.FUELTYPE,m.TCAP,m.cost,m.accdepr from gl_vehmaster m "
                        + "left join gl_vehin i on(i.doc_no=m.INS_COMP) left join my_locm l on l.doc_no=m.a_loc left join gl_yom y on y.doc_no=m.yom "
                        + " left join my_brch brch on(brch.doc_no=m.a_br) left join gl_vehfin f on (m.finId=f.doc_no) left join gl_vehauth a on (a.doc_no=m.authid)  "
                        + " left join gl_vehplate p on(p.doc_no=m.pltid) left join gl_vehgroup g on g.doc_no=m.vgrpid left join gl_vehbrand b on b.doc_no=m.brdid "
                        + "left join gl_vehmodel mo on mo.doc_no=m.vmodid left join my_vendorm v on v.doc_no=m.dlrid left join my_brch brch1 on(brch1.doc_no=m.brhid) "
                        + "left join my_color c on(c.doc_no=m.clrid) "
                        + "  left join gl_status s on m.tran_code=s.status left join my_head h on h.doc_no=v.acc_no left join gl_vehgroup veh on m.vgrpid=veh.doc_no left join my_nipfleetlog flog on flog.fleetno=m.fleet_no and month(flog.date)=month('"+sqlStartDate1+"') and year(flog.date)=year('"+sqlStartDate1+"') where m.statu=3 and m.brhid='"+brch+"' and flog.fleetno is null  and m.fstatus<>'Z')a ");
                
System.out.println("----------sqldata--vehipchle list-------"+sqldata);
                
        
                ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);
                }
                stmtVeh1.close();
                conn.close();
                 return RESULTDATA;

        }
        catch(Exception e){
            conn.close();
        }
        finally{
            conn.close();
        }
        //System.out.println(RESULTDATA);
        return RESULTDATA;
    }

}
