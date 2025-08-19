package com.dashboard.android.userdiverlink1;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.masters.salesmanmaster.driver.ClsDriverBean;

public class ClsUserDriverLinkDAO

{

    ClsConnection ClsConnection = new ClsConnection();

    ClsCommon ClsCommon = new ClsCommon();

    public JSONArray clientDetailsFrom(String accountname, String chck, String account, String mob)
            throws SQLException {

        JSONArray RESULTDATA = new JSONArray();
        if (!chck.equals("1")) {
            return RESULTDATA;
        }
        String sqltest = "";

        Connection conn = null;
        if (!(accountname.equalsIgnoreCase("")) && !(accountname.equalsIgnoreCase(""))
                && !(accountname.equalsIgnoreCase(null))) {
            sqltest += " and refname like '%" + accountname + "%'";
        }
        if (!(account.equalsIgnoreCase("")) && !(account.equalsIgnoreCase("")) && !(account.equalsIgnoreCase(null))) {
            sqltest += " and acno like '%" + account + "%'";
        }
        if (!(mob.equalsIgnoreCase("")) && !(mob.equalsIgnoreCase("")) && !(mob.equalsIgnoreCase(null))) {
            sqltest += " and per_mob like '%" + mob + "%'";
        }

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtVeh = conn.createStatement(); // UAL - UNallocated ,ANI - allocated not Invoiced, AIN-
                                                        // allocated Invoiced , POS -traffic posted, RES - Received
            String sql = " select cldocno,refname from my_acbook where dtype='crm' and status=3 " + sqltest + "";
            ResultSet resultSet = stmtVeh.executeQuery(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            stmtVeh.close();
            conn.close();

            conn.close();
        } catch (Exception e) {
            conn.close();

        }
        // System.out.println(RESULTDATA);
        return RESULTDATA;
    }

    public JSONArray userlistsearch(String brval, String acno, String chck, String rx) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();
        if (chck.equals("") || chck.equals("0")) {
            return RESULTDATA;
        }

        Connection conn = null;
        String sql = "";

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtVeh = conn.createStatement();

            sql = "SELECT usr.doc_no,user_name username,email,usr.mobile mobile_no,sm.sal_name FROM my_user usr left join my_salesman sm on sm.doc_no=usr.driverid and sm.sal_type='DRV'and sm.status=3 where usr.status=3 and usr.block=0 ";
            System.out.println("sql7"+sql);
            ResultSet resultSet = stmtVeh.executeQuery(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);

            stmtVeh.close();
            conn.close();

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();

        }

        return RESULTDATA;
    }

    public int insert(ArrayList<String> aliasarray, String acno, int rx1) throws SQLException {
        ClsConnection alisconn = new ClsConnection();
        Connection conn = null;

        String msg = "";

        int docno = 0;
        try {
            conn = alisconn.getMyConnection();
            conn.setAutoCommit(false);

            Statement stmt = conn.createStatement();

            if (rx1 == 1) {
                String delsql = "delete from my_clrxprod where cldocno=" + acno + "";
                stmt.execute(delsql);
            } else {
                String delsql = "delete from my_clprod where cldocno=" + acno + "";
                stmt.execute(delsql);
            }
            for (int i = 0; i < aliasarray.size(); i++) {

                String[] aliarray = ((String) aliasarray.get(i)).split("::");
                String aliaschck = aliarray[0].trim().equalsIgnoreCase("undefined") || aliarray[0] == null
                        || aliarray[0].trim().equalsIgnoreCase("") || aliarray[0].trim().equalsIgnoreCase("NaN")
                        || aliarray[0].isEmpty() ? "" : aliarray[0].trim();
                if (!aliaschck.equals("")) {
                    String alias = aliarray[0].trim().equalsIgnoreCase("undefined") || aliarray[0] == null
                            || aliarray[0].trim().equalsIgnoreCase("") || aliarray[0].trim().equalsIgnoreCase("NaN")
                            || aliarray[0].isEmpty() ? "" : aliarray[0].trim();
                    String depid = aliarray[1].trim().equalsIgnoreCase("undefined") || aliarray[1] == null
                            || aliarray[1].trim().equalsIgnoreCase("") || aliarray[1].trim().equalsIgnoreCase("NaN")
                            || aliarray[1].isEmpty() ? "" : aliarray[1].trim();
                    String psrno = aliarray[2].trim().equalsIgnoreCase("undefined") || aliarray[2] == null
                            || aliarray[2].trim().equalsIgnoreCase("") || aliarray[2].trim().equalsIgnoreCase("NaN")
                            || aliarray[2].isEmpty() ? "" : aliarray[2].trim();

                    String sql = "";
                    if (rx1 == 1) {

                        sql = "insert into my_clrxprod(cldocno, alias, psrno) values('" + acno + "','" + alias + "','"
                                + psrno + "')";

                    } else {

                        sql = "insert into my_clprod(cldocno, alias, depno) values('" + acno + "','" + alias + "','"
                                + depid + "')";

                    }
                    docno = stmt.executeUpdate(sql);
                    if (docno > 0) {
                        conn.commit();
                    }

                }
            }
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();

        }
        return docno;
    }

    public List<ClsDriverBean> searchDetails() throws SQLException {
        List<ClsDriverBean> listBean = new ArrayList<ClsDriverBean>();
        Connection conn = null;
        JSONArray RESULTDATA = new JSONArray();

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtDriver = conn.createStatement();

            ResultSet resultSet = stmtDriver.executeQuery(
                    "select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,coalesce(m1.mail,' ') mail,m1.authority,m2.description,m1.external from "
                            +
                            " my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='DRV'");

            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            stmtDriver.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

}
