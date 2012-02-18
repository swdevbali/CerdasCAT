/** 
 * 
 */

package application.controllers;
import recite18th.controller.Controller;
import application.models.KonfigurasiModel;

public class Konfigurasi extends Controller
{
    private final static String body_content = "konfigurasi\\view_konfigurasi.jsp";
    public Konfigurasi()
    {
        controllerName = "Konfigurasi";
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        modelForm = new KonfigurasiModel();
    }
    public void index()
    {
        request.setAttribute("body_content",body_content);
        isNeedAuthorization = true;
        viewPage = "index.jsp";
        super.index();
    }
}
