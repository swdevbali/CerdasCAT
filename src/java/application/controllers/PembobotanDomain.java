/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.PembobotanDomainModel;

public class PembobotanDomain extends Controller
{
    private final static String body_content = "pembobotan_domain\\view_pembobotan_domain.jsp";
    public PembobotanDomain()
    {
        controllerName = "PembobotanDomain";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new PembobotanDomainModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
