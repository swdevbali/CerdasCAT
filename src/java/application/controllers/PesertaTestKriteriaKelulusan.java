/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.PesertaTestKriteriaKelulusanModel;

public class PesertaTestKriteriaKelulusan extends Controller
{
    private final static String body_content = "peserta_test_kriteria_kelulusan\\view_peserta_test_kriteria_kelulusan.jsp";
    public PesertaTestKriteriaKelulusan()
    {
        controllerName = "PesertaTestKriteriaKelulusan";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new PesertaTestKriteriaKelulusanModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
