/** 
 * Autogenerated by Recite18th from table ruklis3.konfigurasi
 * Don't change this file. Instead, change the derived class KonfigurasiModel
 * 
 */

package application.models;
import recite18th.model.Model;
public class _KonfigurasiModel extends Model
{
    public String idkonfigurasi;
    public String kuota;
    public String skor_minimum;
    public _KonfigurasiModel()
    {
        tableName="konfigurasi";
        pkFieldName="idkonfigurasi";
        fqn = KonfigurasiModel.class.getName();
        plainClassName = "KonfigurasiModel";
    }
    public void setIdkonfigurasi(String idkonfigurasi)
    {
        this.idkonfigurasi=idkonfigurasi;
    }
    public String getIdkonfigurasi()
    {        return this.idkonfigurasi;
    }
    public void setKuota(String kuota)
    {
        this.kuota=kuota;
    }
    public String getKuota()
    {        return this.kuota;
    }
    public void setSkor_minimum(String skor_minimum)
    {
        this.skor_minimum=skor_minimum;
    }
    public String getSkor_minimum()
    {        return this.skor_minimum;
    }
    public void get()
    {
        _KonfigurasiModel result = (_KonfigurasiModel) super.getModel();
        if(result!=null)
        {
            setIdkonfigurasi(result.getIdkonfigurasi());
            setKuota(result.getKuota());
            setSkor_minimum(result.getSkor_minimum());
        }
    }
}
