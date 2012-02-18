/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.KelulusanModel;

public class Kelulusan extends Controller
{
    private final static String body_content = "kelulusan\\view_kelulusan.jsp";
    public Kelulusan()
    {
        controllerName = "Kelulusan";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new KelulusanModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
