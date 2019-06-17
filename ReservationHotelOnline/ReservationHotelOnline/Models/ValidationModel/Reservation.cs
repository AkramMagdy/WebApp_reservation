using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ReservationHotelOnline.Models.DataModel
{
    [MetadataType(typeof(ReservationMeta))]
    public partial class Reservation
    {
    }
    public class ReservationMeta
    {
        [Required(ErrorMessage = "You Must Write StartDate")]
        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}", ApplyFormatInEditMode = true)]
        public System.DateTime StartDate { get; set; }
        [Required(ErrorMessage = "You Must Write EndDate ")]
        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}", ApplyFormatInEditMode = true)]
        public System.DateTime EndDate { get; set; }
    }
}