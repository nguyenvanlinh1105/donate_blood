namespace HIENMAUNHANDAO.ViewModel
{
    public class HomeSearchViewModel
    {
        public DateTime? fromDate { get; set; } = null;  
        public DateTime? toDate { get; set; } = null;

        public int pageActive { set; get; }
    }
}
