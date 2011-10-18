package application.controllers;

import recite18th.controller.Controller;
import application.config.Config;
import application.models.AdminModel;
import application.models.PengajarModel;
import application.models.PimpinanModel;
import application.models.PesertaTestModel;

import application.models.WaliPesertaTestModel;
import java.io.IOException;
import recite18th.controller.Controller;
import recite18th.library.Db;
import recite18th.util.ServletUtil;

/**
 *
 * @author Eko SW
 */
public class Login extends Controller
{
        public Login()
        {
                this.controllerName = "login";
                this.viewPage = "index.jsp";
        }

        public void login() throws IOException 
        {
                String peran = request.getParameter("peran")+"";
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                
                String table="";
                String pkFieldName="id";
                String fqn="";
                
                //TODO : validasi framework
                clearValidation();
                validationAddRule("username","required");
                validationAddRule("password","required");
                validationAddRule("peran","!=-1");

                if(validationRun()){                
                        if(peran.equals("Admin")){
                                table="admin";
                                fqn=AdminModel.class.getName();
                        }else if(peran.equals("Pengajar")){
                                table="pengajar";
                                fqn=PengajarModel.class.getName();
                        }else if(peran.equals("Peserta Test")){
                                table="peserta_test";
                                fqn=PesertaTestModel.class.getName();
                        }else if(peran.equals("Pimpinan")){
                                table="pimpinan";
                                fqn=PimpinanModel.class.getName();
                        }else if(peran.equals("Wali Peserta Test")){
                                table="wali_peserta_test";
                                fqn=WaliPesertaTestModel.class.getName();
                        }
                        
                        String data[][] = Db.getDataSet("select " + pkFieldName + " from " + table + " where username='"+ username + "' and password='" + password + "'");
                        if(data.length>0){
                                Object user_credential = Db.getById(table, pkFieldName, fqn, data[0][0]);
                                request.getSession().setAttribute("user_credential", user_credential);
                                request.getSession().removeAttribute("flash_error_message");
                                ServletUtil.redirect(Config.base_url + "index/home", request, response);
                        }else{
                                request.getSession().setAttribute("flash_error_message", "Maaf, informasi login Anda tidak dikenali");
                                ServletUtil.redirect(Config.base_url, request, response);
                        }
                }else{
                        request.getSession().setAttribute("flash_error_message", "Pilih jenis login Anda terlebih dahulu");
                        ServletUtil.redirect(Config.base_url, request, response);                       
                }
        }
        
        public void logout() throws IOException
        {
                request.getSession().invalidate();
                ServletUtil.redirect(Config.base_url, request, response);
        }
}