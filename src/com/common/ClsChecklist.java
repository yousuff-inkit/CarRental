package com.common;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsChecklist {
    

    ClsConnection ClsConnection=new ClsConnection();

    ClsCommon cmn=new ClsCommon();
    
    public JSONArray checklistData(String dtype,String docno,String check) throws SQLException{    
        JSONArray RESULTDATA1=new JSONArray();
        if(!check.equalsIgnoreCase("1")) {
            return RESULTDATA1;   
        }
        Connection conn=null;
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();  

            String sql="select * from(select replace(path,'\\\\\\\\',';') path,attach upload,d.checksrno,c.desc1,c.mandatory,d.remarks,true chk,d.qotno,d.rowno from my_checklistdet d left join my_checklist c on c.srno=d.checksrno where d.qotno='"+docno+"' and c.dtype='"+dtype+"' union all select '' path,'' upload,srno checksrno, desc1, mandatory,'' remarks,false chk,0 qotno,0 rowno from my_checklist where status<>7 and dtype='"+dtype+"')a group by checksrno order by checksrno";
            System.out.println("===checklist7===="+sql);         
            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1=cmn.convertToJSON(resultSet1);

        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally{
            conn.close();
        }
        return RESULTDATA1;
    }
}
