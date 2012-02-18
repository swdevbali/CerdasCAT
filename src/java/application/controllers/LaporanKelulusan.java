/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.LaporanKelulusanModel;

public class LaporanKelulusan extends Controller
{
    private final static String body_content = "laporan_kelulusan\\view_laporan_kelulusan.jsp";
    public LaporanKelulusan()
    {
        controllerName = "LaporanKelulusan";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new LaporanKelulusanModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
