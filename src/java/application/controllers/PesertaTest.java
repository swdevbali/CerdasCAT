package application.controllers;

import application.models.PaketSoalModel;
import application.models.PaketSoalTigaButirModel;
import application.models.PesertaTestModel;
import java.io.IOException;
import recite18th.controller.Controller;
import recite18th.library.Db;

/**
 * TODO : access level to controller, until its method level, not just controller level 
 * e.g PesertaTest will be accessible all to Admin, but signup can be accessed by PesertaTest
 *
 * @author Eko SW
 */
public class PesertaTest extends Controller
{
    public PesertaTest()
    {
        modelForm = new PesertaTestModel();
        controllerName = "PesertaTest";
        viewPage = "peserta_test/daftar_peserta_test.jsp";
        formPage = "peserta_test/form_peserta_test.jsp";
        sqlViewDataPerPage = "select * from peserta_test order by username,metode,model_logistik,inisialisasi_kemampuan,penyajian_soal";    

        //validation
        //text field validation
        validationAddRule("username","required");
        validationAddRule("password","required");

        
        //todo remove this unnecessary free input validation.
        validationAddRule("nomor_peserta","any");//actually, what we search is required. But because it's any, so it's not required :)
        validationAddRule("nama_lengkap","any");
        validationAddRule("asal","any");
        validationAddRule("tempat_lahir","any");
        validationAddRule("tanggal_lahir","any");

        //combo box validation
        validationAddRule("metode","!=-1");
        validationAddRule("model_logistik","!=-1");
        validationAddRule("inisialisasi_kemampuan","!=-1");
        validationAddRule("penyajian_soal","!=-1");
        validationAddRule("jenis_kelamin","!=-1");

        //paket_soal dan paket_soal_tiga_butir boleh tidak dipilih
    }
    

//accessible by PesertaTest
    public void signup() throws IOException
    {
        String id = ((PesertaTestModel) request.getSession().getAttribute("user_credential")).getId();
        PesertaTestModel model = (PesertaTestModel) Db.getById("peserta_test","id",PesertaTestModel.class.getName(),id);
        request.setAttribute("model",model);
        super.index("peserta_test\\signup.jsp");
    }

    @Override
    public void input(String pkFieldValue) {
        request.setAttribute("row_paket_soal",(new PaketSoalModel()).getAllData());
        request.setAttribute("row_paket_soal_tiga_butir",(new PaketSoalTigaButirModel()).getAllData());        
        super.input(pkFieldValue);
    }
    
    
}
