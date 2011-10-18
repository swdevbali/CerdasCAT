/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.PaketSoalTigaButirJawabanModel;

public class PaketSoalTigaButirJawaban extends Controller
{
    private final static String body_content = "paket_soal_tiga_butir_jawaban\\view_paket_soal_tiga_butir_jawaban.jsp";
    public PaketSoalTigaButirJawaban()
    {
        controllerName = "PaketSoalTigaButirJawaban";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new PaketSoalTigaButirJawabanModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
