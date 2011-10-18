/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.PaketSoalJawabanModel;

public class PaketSoalJawaban extends Controller
{
    private final static String body_content = "paket_soal_jawaban\\view_paket_soal_jawaban.jsp";
    public PaketSoalJawaban()
    {
        controllerName = "PaketSoalJawaban";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new PaketSoalJawabanModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
