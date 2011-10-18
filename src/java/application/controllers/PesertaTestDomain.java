/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.PesertaTestDomainModel;

public class PesertaTestDomain extends Controller
{
    private final static String body_content = "peserta_test_domain\\view_peserta_test_domain.jsp";
    public PesertaTestDomain()
    {
        controllerName = "PesertaTestDomain";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new PesertaTestDomainModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
