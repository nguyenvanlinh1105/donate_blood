using HIENMAUNHANDAO.Models;

namespace HIENMAUNHANDAO.ViewModel
{
    public class HomeViewModel
    {
        public Paging paging { get; set; }
        public List<SuKienHienMauViewModel> suKienHienMau {  get; set; }

        public List<string> listSKDKbyIdNguoiDung { set; get; }

        public HomeSearchViewModel modelHome { set; get; }

    }
}
