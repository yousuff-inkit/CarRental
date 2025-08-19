package com.controlcentre.masters.satmasters;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSatMasterDAO {
    ClsConnection ClsConnection = new ClsConnection();
    Connection conn;
    PreparedStatement ps;
    ResultSet rs;
    ClsCommon clsCommon = new ClsCommon();
    ClsSatMasterBean bean;

    public int insert(String username, String passwrod, String remarks, String tcno, int hidCaptcha, String sqno,
            String timeperiod, String mode, String stiecheck, int hidrta, String Site,String formdetailcode,HttpSession session) throws SQLException {
        int docno = 0;

        try {
            conn = ClsConnection.getMyConnection();
            conn.setAutoCommit(false);
            String type = null;
            String brch=session.getAttribute("BRANCHID").toString();
            String userid=session.getAttribute("USERID").toString();
            if (remarks.equalsIgnoreCase("Salik")) {
                type = "U";
            } else {
                type = "F";
            }
            String sql = "SELECT * FROM gl_webid WHERE TYPE='" + type + "' AND username='" + username + "'";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                docno = -2;
                conn.commit();
                conn.close();
                return docno;
            } else {
                CallableStatement satCall = conn.prepareCall("{call satMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                satCall.registerOutParameter(15, java.sql.Types.INTEGER);
                // String
                // sql="insert into gl_webid (username,password,remarks,type,site,desc1,comp_id,tcno,iscaptcha,time_period,category,url,sitecheck,rta)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                // ps=conn.prepareStatement(sql,
                // PreparedStatement.RETURN_GENERATED_KEYS);
                satCall.setString(1, username);
                satCall.setString(2, passwrod);
                satCall.setString(3, remarks);
                satCall.setString(4, type);
                satCall.setString(5, Site);
                satCall.setString(6, remarks);
                satCall.setString(7, tcno);
                satCall.setInt(8, hidCaptcha);
                satCall.setString(9, timeperiod);
                satCall.setString(10, remarks);
                satCall.setString(11, sqno);
                satCall.setString(12, stiecheck);
                satCall.setInt(13, hidrta);
                satCall.setString(14, "01");
                //satCall.setInt(15, docno);
                satCall.setString(16, mode);
                satCall.setString(17, formdetailcode);
                satCall.setString(18, brch);
                satCall.setString(19, userid);

                satCall.executeQuery();
                docno = satCall.getInt("satDocno");
            }
            conn.commit();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        //conn.commit();
        //conn.close();

        return docno;
    }

    public int edit(String username, String password, String remarks, String tcno, int hidCaptcha, String sqno,
            String timeperiod, String mode, String sitecheck, int hidRta, String site, int docno,String formdetailcode,HttpSession session) throws SQLException {

        try {
            
            String brch=session.getAttribute("BRANCHID").toString();
            String userid=session.getAttribute("USERID").toString();
            conn = ClsConnection.getMyConnection();
            conn.setAutoCommit(false);
            String type = null;
            CallableStatement satCall = conn.prepareCall("{call satMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

            if (remarks.equalsIgnoreCase("Salik")) {
                type = "U";
            } else {
                type = "F";
            }

            satCall.setInt(15, docno);
            satCall.setString(1, username);
            satCall.setString(2, password);
            satCall.setString(3, remarks);
            satCall.setString(4, type);
            satCall.setString(5, site);
            satCall.setString(6, remarks);
            satCall.setString(7, tcno);
            satCall.setInt(8, hidCaptcha);
            satCall.setString(9, timeperiod);
            satCall.setString(10, remarks);
            satCall.setString(11, sqno);
            satCall.setString(12, sitecheck);
            satCall.setInt(13, hidRta);
            satCall.setString(14, "01");
            satCall.setString(16, mode);
            satCall.setString(17, formdetailcode);
            satCall.setString(18, brch);
            satCall.setString(19, userid);

            int a = satCall.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.commit();
        conn.close();
        return docno;
    }

    public boolean delete(String username, String password, String remarks, String tcno, int hidCaptcha, String sqno,
            String timeperiod, String mode, String sitecheck, int hidRta, String site, int docno) throws SQLException {
        boolean a;
        int doc_no=0;
        
        try {
            conn = ClsConnection.getMyConnection();
            conn.setAutoCommit(false);
            String sql="SELECT doc_no FROM gl_webid WHERE  doc_no='"+docno+"' and status=3";
            
            ps=conn.prepareStatement(sql);
            rs=ps.executeQuery();
            if(rs.next()){
                String delsql = "update gl_webid set status=7 where doc_no=?";
                ps = conn.prepareStatement(delsql);
                ps.setInt(1, docno);
                int y = ps.executeUpdate();
                if (y > 0) {
                    conn.commit();
                    ps.close();
                    return true;
                }
                ps.close();
                conn.close();
            }else{
                return false;
            }

        } catch (Exception e) {
//            ps.close();
//            conn.close();
            e.printStackTrace();
        }finally{
            ps.close();
            conn.close();
        }
        ps.close();
        conn.close();
        return false;
    }

    public List<ClsSatMasterBean> list() throws SQLException {
       // System.out.println("On DAO");

        List<ClsSatMasterBean> listBean = new ArrayList<ClsSatMasterBean>();
        try {
            conn = ClsConnection.getMyConnection();
            String sql = "SELECT * FROM gl_webid where status=3 order by doc_no";
            ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ClsSatMasterBean bean = new ClsSatMasterBean();
                bean.setDocno(rs.getInt("doc_no"));
                bean.setUsername(rs.getString("username"));
                bean.setTcno(rs.getString("tcno"));
                bean.setTimeperiod(rs.getString("time_period"));
                bean.setSite(rs.getString("Site"));
                bean.setRemarks(rs.getString("remarks"));
                bean.setPassword(rs.getString("password"));
                bean.setSqno(rs.getString("url"));
                bean.setHidCaptcha(rs.getInt("iscaptcha"));
                bean.setHidRta(rs.getInt("rta"));
                listBean.add(bean);

            }
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }
       // conn.close();
        return listBean;
    }

}
