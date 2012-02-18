/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.KriteriaKelulusanModel;

public class KriteriaKelulusan extends Controller
{
    private final static String body_content = "kriteria_kelulusan\\view_kriteria_kelulusan.jsp";
    public KriteriaKelulusan()
    {
        controllerName = "KriteriaKelulusan";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new KriteriaKelulusanModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
