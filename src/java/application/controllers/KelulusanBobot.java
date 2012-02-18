/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.KelulusanBobotModel;

public class KelulusanBobot extends Controller
{
    private final static String body_content = "kelulusan_bobot\\view_kelulusan_bobot.jsp";
    public KelulusanBobot()
    {
        controllerName = "KelulusanBobot";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new KelulusanBobotModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
