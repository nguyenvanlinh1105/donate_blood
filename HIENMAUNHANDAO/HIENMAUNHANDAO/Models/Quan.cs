using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class Quan
{
    public string IdQuan { get; set; } = null!;

    public string TenQuan { get; set; } = null!;

    public string IdThanhPho { get; set; } = null!;

    public virtual ThanhPho IdThanhPhoNavigation { get; set; } = null!;

    public virtual ICollection<Phuong> Phuongs { get; set; } = new List<Phuong>();
}
