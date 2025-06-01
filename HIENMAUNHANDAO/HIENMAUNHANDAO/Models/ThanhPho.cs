using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class ThanhPho
{
    public string IdThanhPho { get; set; } = null!;

    public string TenThanhPho { get; set; } = null!;

    public virtual ICollection<Quan> Quans { get; set; } = new List<Quan>();
}
