package com.humanresource.transactions.attendance;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import com.connection.ClsConnection;

public class ClsATTNExcelImport {
    
    ClsConnection connDAO = new ClsConnection();
    
    public int ExcelImport(String docNo,String year,String month) throws SQLException {
        Connection conn = null;
       
       try{
           conn=connDAO.getMyConnection();
           conn.setAutoCommit(false);
           Statement stmt = conn.createStatement();
           Statement stmt1 = conn.createStatement();
           Statement stmts = conn.createStatement();

           String path="";
           String strSql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='ATTN'";
           ResultSet rs = stmt.executeQuery(strSql);
           while(rs.next()) {
               path=rs.getString("path");
           }
           path = path.replace("\\", "//");
           
           java.sql.PreparedStatement pstm = null ;
           FileInputStream input = new FileInputStream(path);
           POIFSFileSystem fs = new POIFSFileSystem( input );
           HSSFWorkbook wb = new HSSFWorkbook(fs);
           HSSFSheet sheet = wb.getSheetAt(0);
           Row row;
           
           String sqltrun ="truncate my_attn_excel ";
           ResultSet trun=stmt.executeQuery(sqltrun);
           
           for(int i=1; i<=sheet.getLastRowNum(); i++){  //Changed i=0 because of header in excel - 2022/07/11
               String accounts="",description="";
               row = sheet.getRow(i);
               
               if(row.getCell(3)!=null){
                   row.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(4)!=null){
                   row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(5)!=null){
                   row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(6)!=null){
                   row.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(7)!=null){
                   row.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(8)!=null){
                   row.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(9)!=null){
                   row.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(10)!=null){
                  row.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(11)!=null){
                   row.getCell(11).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(12)!=null){
                   row.getCell(12).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(13)!=null){
                   row.getCell(13).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(14)!=null){
                   row.getCell(14).setCellType(Cell.CELL_TYPE_STRING);
                 }
               if(row.getCell(15)!=null){
                   row.getCell(15).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(16)!=null){
                   row.getCell(16).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(17)!=null){
                   row.getCell(17).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(18)!=null){
                   row.getCell(18).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(19)!=null){
                   row.getCell(19).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(20)!=null){
                   row.getCell(20).setCellType(Cell.CELL_TYPE_STRING);
                   }
               if(row.getCell(21)!=null){
                   row.getCell(21).setCellType(Cell.CELL_TYPE_STRING);
                    }
               if(row.getCell(22)!=null){
                   row.getCell(22).setCellType(Cell.CELL_TYPE_STRING);
                     }
               if(row.getCell(23)!=null){
                   row.getCell(23).setCellType(Cell.CELL_TYPE_STRING);
                     }
               if(row.getCell(24)!=null){
                   row.getCell(24).setCellType(Cell.CELL_TYPE_STRING);
                     }
               if(row.getCell(25)!=null){
                   row.getCell(25).setCellType(Cell.CELL_TYPE_STRING);
                     }
               if(row.getCell(26)!=null){
                   row.getCell(26).setCellType(Cell.CELL_TYPE_STRING);
                     }
               if(row.getCell(27)!=null){
                   row.getCell(27).setCellType(Cell.CELL_TYPE_STRING);
                     }
               if(row.getCell(28)!=null){
                   row.getCell(28).setCellType(Cell.CELL_TYPE_STRING);
                     }
               if(row.getCell(29)!=null){
                   row.getCell(29).setCellType(Cell.CELL_TYPE_STRING);
                     }
               if(row.getCell(30)!=null){
                   row.getCell(30).setCellType(Cell.CELL_TYPE_STRING);
                     }
               if(row.getCell(31)!=null){
                   row.getCell(31).setCellType(Cell.CELL_TYPE_STRING);
                     }
               if(row.getCell(32)!=null){
                   row.getCell(32).setCellType(Cell.CELL_TYPE_STRING);
                     }
               if(row.getCell(33)!=null){
                   row.getCell(33).setCellType(Cell.CELL_TYPE_STRING);
                   }
               
               int employeedocno = (int) row.getCell(0).getNumericCellValue();
               int empid = (int) row.getCell(1).getNumericCellValue(); 
               String date1 = row.getCell(3).getStringCellValue()=="" || row.getCell(3).getStringCellValue()==null?"0":row.getCell(3).getStringCellValue();
               String date2 = row.getCell(4).getStringCellValue()==""  || row.getCell(4).getStringCellValue()==null?"0":row.getCell(4).getStringCellValue();
               String date3 = row.getCell(5).getStringCellValue()==""  || row.getCell(5).getStringCellValue()==null?"0":row.getCell(5).getStringCellValue();
               String date4 = row.getCell(6).getStringCellValue()==""  || row.getCell(6).getStringCellValue()==null?"0":row.getCell(6).getStringCellValue();
               String date5 = row.getCell(7).getStringCellValue()==""  || row.getCell(7).getStringCellValue()==null?"0":row.getCell(7).getStringCellValue();
               String date6 = row.getCell(8).getStringCellValue()==""  || row.getCell(8).getStringCellValue()==null?"0":row.getCell(8).getStringCellValue();
               String date7 = row.getCell(9).getStringCellValue()==""  || row.getCell(9).getStringCellValue()==null?"0":row.getCell(9).getStringCellValue();
               String date8 = row.getCell(10).getStringCellValue()==""  || row.getCell(10).getStringCellValue()==null?"0":row.getCell(10).getStringCellValue();
               String date9 = row.getCell(11).getStringCellValue()==""  || row.getCell(11).getStringCellValue()==null?"0":row.getCell(11).getStringCellValue();
               String date10 = row.getCell(12).getStringCellValue()==""  || row.getCell(12).getStringCellValue()==null?"0":row.getCell(12).getStringCellValue();
               String date11 = row.getCell(13).getStringCellValue()==""  || row.getCell(13).getStringCellValue()==null?"0":row.getCell(13).getStringCellValue();
               String date12 = row.getCell(14).getStringCellValue()==""  || row.getCell(14).getStringCellValue()==null?"0":row.getCell(14).getStringCellValue();
               String date13 = row.getCell(15).getStringCellValue()==""  || row.getCell(15).getStringCellValue()==null?"0":row.getCell(15).getStringCellValue();
               String date14 = row.getCell(16).getStringCellValue()==""  || row.getCell(16).getStringCellValue()==null?"0":row.getCell(16).getStringCellValue();
               String date15 = row.getCell(17).getStringCellValue()==""  || row.getCell(17).getStringCellValue()==null?"0":row.getCell(17).getStringCellValue();
               String date16 = row.getCell(18).getStringCellValue()==""  || row.getCell(18).getStringCellValue()==null?"0":row.getCell(18).getStringCellValue();
               String date17 = row.getCell(19).getStringCellValue()==""  || row.getCell(19).getStringCellValue()==null?"0":row.getCell(19).getStringCellValue();
               String date18 = row.getCell(20).getStringCellValue()==""  || row.getCell(20).getStringCellValue()==null?"0":row.getCell(20).getStringCellValue();
               String date19 = row.getCell(21).getStringCellValue()==""  || row.getCell(21).getStringCellValue()==null?"0":row.getCell(21).getStringCellValue();
               String date20 = row.getCell(22).getStringCellValue()==""  || row.getCell(22).getStringCellValue()==null?"0":row.getCell(22).getStringCellValue();
               String date21 = row.getCell(23).getStringCellValue()==""  || row.getCell(23).getStringCellValue()==null?"0":row.getCell(23).getStringCellValue();
               String date22 = row.getCell(24).getStringCellValue()==""  || row.getCell(24).getStringCellValue()==null?"0":row.getCell(24).getStringCellValue();
               String date23 = row.getCell(25).getStringCellValue()==""  || row.getCell(25).getStringCellValue()==null?"0":row.getCell(25).getStringCellValue();
               String date24 = row.getCell(26).getStringCellValue()==""  || row.getCell(26).getStringCellValue()==null?"0":row.getCell(26).getStringCellValue();
               String date25 = row.getCell(27).getStringCellValue()==""  || row.getCell(27).getStringCellValue()==null?"0":row.getCell(27).getStringCellValue();
               String date26 = row.getCell(28).getStringCellValue()==""  || row.getCell(28).getStringCellValue()==null?"0":row.getCell(28).getStringCellValue();           
               String date27 = row.getCell(29).getStringCellValue()==""  || row.getCell(29).getStringCellValue()==null?"0":row.getCell(29).getStringCellValue();  
               String date28 = row.getCell(30).getStringCellValue()==""  || row.getCell(30).getStringCellValue()==null?"0":row.getCell(30).getStringCellValue();          
               String date29 = row.getCell(31).getStringCellValue()==""  || row.getCell(31).getStringCellValue()==null?"0":row.getCell(31).getStringCellValue();
               String date30 = row.getCell(32).getStringCellValue()==""  || row.getCell(32).getStringCellValue()==null?"0":row.getCell(32).getStringCellValue();            
               String date31 = row.getCell(33).getStringCellValue()==""  || row.getCell(33).getStringCellValue()==null?"0":row.getCell(33).getStringCellValue();
               int years = (int) row.getCell(34).getNumericCellValue(); 
               int months = (int) row.getCell(35).getNumericCellValue(); 
             
             
           
               String sql = "INSERT INTO my_attn_excel(doc_no, empId, year, month, date1, date2, date3, date4, date5, date6, date7, date8, date9, date10, date11, date12, date13, date14, date15, date16, date17, date18, date19, date20, date21, date22, date23, date24, date25, date26, date27, date28, date29, date30, date31) VALUES"
                       + " ('"+employeedocno+"', '"+empid+"', '"+years+"', '"+months+"', '"+date1+"', '"+date2+"', '"+date3+"', '"+date4+"', '"+date5+"', '"+date6+"', '"+date7+"', '"+date8+"', '"+date9+"', '"+date10+"', '"+date11+"', '"+date12+"', '"+date13+"', '"+date14+"', '"+date15+"', '"+date16+"', '"+date17+"', '"+date18+"', '"+date19+"', '"+date20+"', '"+date21+"', '"+date22+"', '"+date23+"', '"+date24+"', '"+date25+"', '"+date26+"', '"+date27+"', '"+date28+"', '"+date29+"', '"+date30+"', '"+date31+"')";
              //System.out.println("insert query---"+sql);
               pstm = conn.prepareStatement(sql);
               pstm.execute();
           }
          
       
         
          int val=0;
           String sqlselect= "select date1 date1,date2 date2, date3 date3, date4 date4, date5 date5, date6 date6, date7 date7, date8 date8, date9 date9, date10 date10, date11 date11, date12 date12, date13 date13, date14 date14, date15 date15, date16 date16, date17 date17, date18 date18, date19 date19, date20 date20, date21 date21, date22 date22, date23 date23, date24 date24, date25 date25, date26 date26, date27 date27, date28 date28, date29 date29, date30 date30, date31 date31,year year,month month,doc_no empid from  my_attn_excel";
           //System.out.println("select tbl query---"+sqlselect);
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
              
              // System.out.println("hot-------------------------"+hot);
             
          
            //System.out.println("ot---------------------------------"+ot);
             
               
       
             String sqlup="update hr_timesheet t SET  t.date1='"+dvalue(d1)+"' , t.date2='"+dvalue(d2)+"' , t.date3='"+dvalue(d3)+"' , t.date4='"+dvalue(d4)+"', t.date5='"+dvalue(d5)+"' "
                       +"  , t.date6='"+dvalue(d6)+"', t.date7='"+dvalue(d7)+"', t.date8='"+dvalue(d8)+"', t.date9='"+dvalue(d9)+"', t.date10='"+dvalue(d10)+"' "
                       +"  , t.date11='"+dvalue(d11)+"', t.date12='"+dvalue(d12)+"', t.date13='"+dvalue(d13)+"', t.date14='"+dvalue(d14)+"', t.date15='"+dvalue(d15)+"' "
                       +"  , t.date16='"+dvalue(d16)+"', t.date17='"+dvalue(d17)+"', t.date18='"+dvalue(d18)+"', t.date19='"+dvalue(d19)+"', t.date20='"+dvalue(d20)+"' "
                       +"  , t.date21='"+dvalue(d21)+"', t.date22='"+dvalue(d22)+"', t.date23='"+dvalue(d23)+"', t.date24='"+dvalue(d24)+"', t.date25='"+dvalue(d25)+"' "
                       +"  , t.date26='"+dvalue(d26)+"', t.date27='"+dvalue(d27)+"', t.date28='"+dvalue(d28)+"', t.date29='"+dvalue(d29)+"', t.date30='"+dvalue(d30)+"' "
                       +"  , t.date31='"+dvalue(d31)+"',t.tot_hot='"+hot+"' ,t.tot_ot='"+ot+"'  WHERE  t.year='"+dy+"' and t.month='"+dm+"' and empid='"+empid+"'";
            //System.out.println("up tbl query---"+sqlup);
               val= stmt1.executeUpdate(sqlup);
             //  System.out.println("val=================="+val);
              
           }
           if(val>0) {
               conn.commit();
               pstm.close();
               conn.close();
               input.close();
              
           }
           return val;
       }catch(Exception e){
           e.printStackTrace();
           conn.close();
           return 0;
    }finally{
        conn.close();
    }
   }
    
   public String dvalue(String d1){
       String dateval="";
      // System.out.println("d1----------"+d1);
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
        }else if(!((d1.equalsIgnoreCase("P")) && (d1.equalsIgnoreCase("H")) && (d1.equalsIgnoreCase("C")) && (d1.equalsIgnoreCase("S")) && (d1.equalsIgnoreCase("U")) &&  (d1.equalsIgnoreCase("M")) &&  (d1.equalsIgnoreCase("T")) &&  (d1.equalsIgnoreCase("A2")) && (d1.equalsIgnoreCase("C2")) && (d1.equalsIgnoreCase("S2")) || (d1.equalsIgnoreCase("U2")) ||  (d1.equalsIgnoreCase("M2")) &&  (d1.equalsIgnoreCase("T2")) && (d1.equalsIgnoreCase("LH")) && (d1.equalsIgnoreCase("N"))  && (d1.equalsIgnoreCase("N2"))) ) {
            String[] Splitval = d1.split(":");
           // System.out.println("splitval==="+Splitval);
           
           int Splitvalhr = (Integer.parseInt(Splitval[0]) * 60)+ Integer.parseInt(Splitval[1]); 
          dateval=Splitvalhr+"";
        }
       
    return dateval;
       
   }

}
