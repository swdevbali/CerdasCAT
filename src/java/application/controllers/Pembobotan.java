/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.PembobotanModel;

public class Pembobotan extends Controller
{
    private final static String body_content = "pembobotan\\view_pembobotan.jsp";
    public Pembobotan()
    {
        controllerName = "Pembobotan";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new PembobotanModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
