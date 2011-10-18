/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.PaketSoalTigaButirDetailModel;

public class PaketSoalTigaButirDetail extends Controller
{
    private final static String body_content = "paket_soal_tiga_butir_detail\\view_paket_soal_tiga_butir_detail.jsp";
    public PaketSoalTigaButirDetail()
    {
        controllerName = "PaketSoalTigaButirDetail";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new PaketSoalTigaButirDetailModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
