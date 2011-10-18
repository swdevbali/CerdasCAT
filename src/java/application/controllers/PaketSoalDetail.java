/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.PaketSoalDetailModel;

public class PaketSoalDetail extends Controller
{
    private final static String body_content = "paket_soal_detail\\view_paket_soal_detail.jsp";
    public PaketSoalDetail()
    {
        controllerName = "PaketSoalDetail";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new PaketSoalDetailModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
