/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.PesertaTestJawabanDenganModelModel;

public class PesertaTestJawabanDenganModel extends Controller
{
    private final static String body_content = "peserta_test_jawaban_dengan_model\\view_peserta_test_jawaban_dengan_model.jsp";
    public PesertaTestJawabanDenganModel()
    {
        controllerName = "PesertaTestJawabanDenganModel";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new PesertaTestJawabanDenganModelModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
