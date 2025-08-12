package com.humanresource.transactions.attendance;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.connection.ClsConnection;

public class ClsATTNExcelCSVImport {
    
    ClsConnection connDAO = new ClsConnection();
    
    public int ExcelImport(String docNo,String year,String month) throws SQLException {
        Connection conn = null;
       
       try{
           conn=connDAO.getMyConnection();
           conn.setAutoCommit(false);
           Statement stmt = conn.createStatement();
           Statement stmt1 = conn.createStatement();
           Statement stmts = conn.createStatement();
             java.sql.PreparedStatement pstm = null ;
           
           String path="";
           String line = "";
           String cvsSplitBy = ",";
           
           String sql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='ATTN'";

           ResultSet rs = stmt.executeQuery(sql);
           while(rs.next()) {
               path=rs.getString("path");
           }
           path = path.replace("\\", "//");
           
           BufferedReader br = new BufferedReader(new FileReader(path));
           
           int i=0;
         
           
           String sqltrun ="truncate my_attn_excel ";
           ResultSet trun=stmt.executeQuery(sqltrun);
          
           
           while ((line = br.readLine()) != null) {

               if(i>0) {
                   // use comma as separator
                   String[] attnarray = line.split(cvsSplitBy);
                   
                   
                   String sqlin = "INSERT INTO my_attn_excel(doc_no, empId, year, month, date1, date2, date3, date4, date5, date6, date7, date8, date9, date10, date11, date12, date13, date14, date15, date16, date17, date18, date19, date20, date21, date22, date23, date24, date25, date26, date27, date28, date29, date30, date31) VALUES"
                           + " ('"+attnarray[0]+"', '"+attnarray[1]+"', '"+attnarray[34]+"', '"+attnarray[35]+"', '"+attnarray[3]+"', '"+attnarray[4]+"', '"+attnarray[5]+"', '"+attnarray[6]+"', '"+attnarray[7]+"', '"+attnarray[8]+"', '"+attnarray[9]+"', '"+attnarray[10]+"', '"+attnarray[11]+"', '"+attnarray[12]+"', '"+attnarray[13]+"', '"+attnarray[14]+"', '"+attnarray[15]+"', '"+attnarray[16]+"', '"+attnarray[17]+"', '"+attnarray[18]+"', '"+attnarray[19]+"', '"+attnarray[20]+"', '"+attnarray[21]+"', '"+attnarray[22]+"', '"+attnarray[23]+"', '"+attnarray[24]+"', '"+attnarray[25]+"', '"+attnarray[26]+"', '"+attnarray[27]+"', '"+attnarray[28]+"', '"+attnarray[29]+"', '"+attnarray[30]+"', '"+attnarray[31]+"', '"+attnarray[32]+"', '"+attnarray[33]+"')";
                 // System.out.println("insert query---"+sqlin);
                   pstm = conn.prepareStatement(sqlin);
                   pstm.execute();
               }
               
               i++;
           }
           
           
           int val=0;
           String sqlselect= "select date1 date1,date2 date2, date3 date3, date4 date4, date5 date5, date6 date6, date7 date7, date8 date8, date9 date9, date10 date10, date11 date11, date12 date12, date13 date13, date14 date14, date15 date15, date16 date16, date17 date17, date18 date18, date19 date19, date20 date20, date21 date21, date22 date22, date23 date23, date24 date24, date25 date25, date26 date26, date27 date27, date28 date28, date29 date29, date30 date30, date31 date31,year year,month month,doc_no empid from  my_attn_excel";
       //    System.out.println("select tbl query---"+sqlselect);
           ResultSet rsselect =stmt.executeQuery(sqlselect);
           String  d1="",d2="",d3="",d4="",d5="",d6="",d7="",d8="",d9="",d10="",d11="",d12="",d13="",d14="",d15="",d16="",d17="",d18="",d19="",d20="",d21="",d22="",d23="",d24="",d25="",d26="",d27="",d28="",d29="",d30="",d31="";
           String dy="",dm="",empid="";
           while(rsselect.next()) {
               
               d1=rsselect.getString("date1");
               d2=rsselect.getString("date2"); 
               d3=rsselect.getString("date3");
               d4=rsselect.getString("date4");
               d5=rsselect.getString("date5");
               d6=rsselect.getString("date6");
               d7=rsselect.getString("date7");
               d8=rsselect.getString("date8");
               d9=rsselect.getString("date9");
               d10=rsselect.getString("date10");
               d11=rsselect.getString("date11");
               d12=rsselect.getString("date12");
               d13=rsselect.getString("date13");
               d14=rsselect.getString("date14");
               d15=rsselect.getString("date15");
               d16=rsselect.getString("date16");
               d17=rsselect.getString("date17");
               d18=rsselect.getString("date18");
               d19=rsselect.getString("date19");
               d20=rsselect.getString("date20");
               d21=rsselect.getString("date21"); 
               d22=rsselect.getString("date22"); 
               d23=rsselect.getString("date23"); 
               d24=rsselect.getString("date24"); 
               d25=rsselect.getString("date25"); 
               d26=rsselect.getString("date26"); 
               d27=rsselect.getString("date27"); 
               d28=rsselect.getString("date28"); 
               d29=rsselect.getString("date29"); 
               d30=rsselect.getString("date30"); 
               d31=rsselect.getString("date31"); 
               dy=rsselect.getString("year"); 
               dm=rsselect.getString("month"); 
               empid=rsselect.getString("empid"); 
               
               
             //  System.out.println("d1---------------"+dvalue(d1));
   int days =31,k=1,hot=0,ot=0;  
               
               while(days>0) {
                   String datesql ="select concat( '"+year+"-"+month+"-',LPAD("+k+",2,0)) dates ";
                  // System.out.println("dtsql-----------"+datesql);
                   ResultSet rsdates =stmts.executeQuery(datesql);
                   String dates="";
                   while(rsdates.next()){
                       dates=rsdates.getString("dates");
                   }
                   String sqlday="select if(DAYOFWEEK('"+dates+"')=1,1,0) sunday";
                   //System.out.println("sqlday-----------"+sqlday);
                   ResultSet rssqlday =stmts.executeQuery(sqlday);
                    int sunday=0;
                  
                    while(rssqlday.next()){ 
                        sunday=rssqlday.getInt("sunday");
                    } 
                    
                  
              //  System.out.println("sunday val-----"+sunday);
                    if(sunday==1) {
                        String datetype = rsselect.getString("date"+k);
                      //  if(!datetype.equalsIgnoreCase("H")  ) {
                        
                        if( !(datetype.equalsIgnoreCase("H")) && !(datetype.equalsIgnoreCase("P")) &&!(datetype.equalsIgnoreCase("A")) && !(datetype.equalsIgnoreCase("C")) && !(datetype.equalsIgnoreCase("S")) && !(datetype.equalsIgnoreCase("U")) &&  !(datetype.equalsIgnoreCase("M")) &&  !(datetype.equalsIgnoreCase("T")) &&  !(datetype.equalsIgnoreCase("A2")) && !(datetype.equalsIgnoreCase("C2")) && !(datetype.equalsIgnoreCase("S2")) && !(datetype.equalsIgnoreCase("U2")) &&  !(datetype.equalsIgnoreCase("M2")) &&  !(datetype.equalsIgnoreCase("T2")) && !(datetype.equalsIgnoreCase("LH")) && !(datetype.equalsIgnoreCase("N"))  && !(datetype.equalsIgnoreCase("N2"))) {
                            
                             hot+=Integer.parseInt(dvalue(rsselect.getString("date"+k)));

                        }
                     }else {
                         String datetype1 = rsselect.getString("date"+k);
                   if(!(datetype1.equalsIgnoreCase("P")) && !(datetype1.equalsIgnoreCase("H")) && !(datetype1.equalsIgnoreCase("A")) && !(datetype1.equalsIgnoreCase("C")) && !(datetype1.equalsIgnoreCase("S")) && !(datetype1.equalsIgnoreCase("U")) &&  !(datetype1.equalsIgnoreCase("M")) &&  !(datetype1.equalsIgnoreCase("T")) &&  !(datetype1.equalsIgnoreCase("A2")) && !(datetype1.equalsIgnoreCase("C2")) && !(datetype1.equalsIgnoreCase("S2")) && !(datetype1.equalsIgnoreCase("U2")) &&  !(datetype1.equalsIgnoreCase("M2")) &&  !(datetype1.equalsIgnoreCase("T2")) && !(datetype1.equalsIgnoreCase("LH")) && !(datetype1.equalsIgnoreCase("N"))  && !(datetype1.equalsIgnoreCase("N2"))) {
                       ot+=Integer.parseInt(dvalue(rsselect.getString("date"+k)));
                  }
    }
                    
                   k++;
                   days--;
               }
              
            //   System.out.println("hot-------------------------"+hot);
             
          
           // System.out.println("ot---------------------------------"+ot);
          
               
               
               String sqlup="update hr_timesheet t SET  t.date1='"+dvalue(d1)+"' , t.date2='"+dvalue(d2)+"' , t.date3='"+dvalue(d3)+"' , t.date4='"+dvalue(d4)+"', t.date5='"+dvalue(d5)+"' "
                       +"  , t.date6='"+dvalue(d6)+"', t.date7='"+dvalue(d7)+"', t.date8='"+dvalue(d8)+"', t.date9='"+dvalue(d9)+"', t.date10='"+dvalue(d10)+"' "
                       +"  , t.date11='"+dvalue(d11)+"', t.date12='"+dvalue(d12)+"', t.date13='"+dvalue(d13)+"', t.date14='"+dvalue(d14)+"', t.date15='"+dvalue(d15)+"' "
                       +"  , t.date16='"+dvalue(d16)+"', t.date17='"+dvalue(d17)+"', t.date18='"+dvalue(d18)+"', t.date19='"+dvalue(d19)+"', t.date20='"+dvalue(d20)+"' "
                       +"  , t.date21='"+dvalue(d21)+"', t.date22='"+dvalue(d22)+"', t.date23='"+dvalue(d23)+"', t.date24='"+dvalue(d24)+"', t.date25='"+dvalue(d25)+"' "
                       +"  , t.date26='"+dvalue(d26)+"', t.date27='"+dvalue(d27)+"', t.date28='"+dvalue(d28)+"', t.date29='"+dvalue(d29)+"', t.date30='"+dvalue(d30)+"' "
                       +"  , t.date31='"+dvalue(d31)+"',t.tot_hot='"+hot+"' ,t.tot_ot='"+ot+"' WHERE  t.year='"+dy+"' and t.month='"+dm+"' and empid='"+empid+"'";
              // System.out.println("up tbl query---"+sqlup);
               val= stmt1.executeUpdate(sqlup);
             //  System.out.println("val=================="+val);
              
           }
          
           if(val>0) {
               conn.commit();
               pstm.close();
               conn.close();
            
           }     
          
           return val;
       } catch(Exception e){
           e.printStackTrace();
           conn.close();
           return 0;
    } finally{
        conn.close();
    }
   }
    
    public String dvalue(String d1){
        String dateval="";
        //System.out.println("d1----------"+d1);
        if(d1.equalsIgnoreCase("P")) {
            dateval="1"; 
         }else if(d1.equalsIgnoreCase("H")){
            dateval="2"; 
         }else if(d1.equalsIgnoreCase("A")) {
             dateval="3";
         }else if(d1.equalsIgnoreCase("C")) {
             dateval="4";
         }else if(d1.equalsIgnoreCase("S")) {
             dateval="5";
         }else if(d1.equalsIgnoreCase("U")) {
             dateval="6";
         }else if(d1.equalsIgnoreCase("M")) {
             dateval="7";
         }else if(d1.equalsIgnoreCase("T")) {
             dateval="8";
         }else if(d1.equalsIgnoreCase("A2")) {
             dateval="32";
         }else if(d1.equalsIgnoreCase("C2")) {
             dateval="42";
         }else if(d1.equalsIgnoreCase("S2")) {
             dateval="52";
         }else if(d1.equalsIgnoreCase("U2")) {
             dateval="62";
         }else if(d1.equalsIgnoreCase("M2")) {
             dateval="72";
         }else if(d1.equalsIgnoreCase("T2")) {
             dateval="82";
         }else if(d1.equalsIgnoreCase("LH")) {
             dateval="9";
         }else if(d1.equalsIgnoreCase("N")) {
             dateval="10";
         }else if(d1.equalsIgnoreCase("N2")) {
             dateval="102";
         }else if(!(d1.equalsIgnoreCase("P")) || (d1.equalsIgnoreCase("H")) || (d1.equalsIgnoreCase("C")) || (d1.equalsIgnoreCase("S")) || (d1.equalsIgnoreCase("U")) ||  (d1.equalsIgnoreCase("M")) ||  (d1.equalsIgnoreCase("T")) ||  (d1.equalsIgnoreCase("A2")) || (d1.equalsIgnoreCase("C2")) || (d1.equalsIgnoreCase("S2")) || (d1.equalsIgnoreCase("U2")) ||  (d1.equalsIgnoreCase("M2")) ||  (d1.equalsIgnoreCase("T2")) || (d1.equalsIgnoreCase("LH")) || (d1.equalsIgnoreCase("N"))  || (d1.equalsIgnoreCase("N2")) ) {
             String[] Splitval = d1.split(":");
          //   System.out.println("splitval==="+Splitval);
            
            int Splitvalhr = (Integer.parseInt(Splitval[0]) * 60)+ Integer.parseInt(Splitval[1]); 
           dateval=Splitvalhr+"";
         }
        
     return dateval;
        
    }

}


