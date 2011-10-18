/** 
 * Autogenerated by Recite18th from table ruklis3.skl
 * Don't change this file. Instead, change the derived class SklModel
 * 
 */

package application.models;
import recite18th.model.Model;
public class _SklModel extends Model
{
    public String idskl;
    public String nama_skl;
    public String iddomain;
    public String prioritas;
    public _SklModel()
    {
        tableName="skl";
        pkFieldName="idskl";
        fqn = SklModel.class.getName();
        plainClassName = "SklModel";
    }
    public void setIdskl(String idskl)
    {
        this.idskl=idskl;
    }
    public String getIdskl()
    {        return this.idskl;
    }
    public void setNama_skl(String nama_skl)
    {
        this.nama_skl=nama_skl;
    }
    public String getNama_skl()
    {        return this.nama_skl;
    }
    public void setIddomain(String iddomain)
    {
        this.iddomain=iddomain;
    }
    public String getIddomain()
    {        return this.iddomain;
    }
    public void setPrioritas(String prioritas)
    {
        this.prioritas=prioritas;
    }
    public String getPrioritas()
    {        return this.prioritas;
    }
    public void get()
    {
        _SklModel result = (_SklModel) super.getModel();
        if(result!=null)
        {
            setIdskl(result.getIdskl());
            setNama_skl(result.getNama_skl());
            setIddomain(result.getIddomain());
            setPrioritas(result.getPrioritas());
        }
    }
}
