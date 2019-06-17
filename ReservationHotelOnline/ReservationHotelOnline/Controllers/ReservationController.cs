using ReservationHotelOnline.Models.DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace ReservationHotelOnline.Controllers
{
    public class ReservationController : Controller
    {
        //create new context to connect to data base
        ReservationHotelOnlineDBEntities RD = new ReservationHotelOnlineDBEntities();
        //constructor to make eager loading 
        public ReservationController()
        {
            RD.Configuration.LazyLoadingEnabled = false;
        }
        //index action to return setup screen to create new reservation
        public ActionResult Index()
        {
            return View();
        }

        //GetRoomType action to return JsonResult list of Room Types 
        public JsonResult GetRoomType()
        {
         List<RoomType> roomTypes = new List<RoomType>();
            roomTypes = RD.RoomTypes.OrderBy(c=>c.Type).ToList();
            return new JsonResult { Data = roomTypes ,JsonRequestBehavior= JsonRequestBehavior.AllowGet };
        }

        //GetRoom action to return JsonResult list of Rooms
        public JsonResult GetRoom(int RoomTypeID)
        {
            List<Room> rooms = new List<Room>();
            rooms = RD.Rooms.Where(c=>c.RoomTypeID== RoomTypeID).ToList();
            return new JsonResult { Data = rooms, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        //GetUnitprice action to return JsonResult  price of room type that has specific id 

        public JsonResult GetUnitprice(int TypeID)
        {
            RoomType RoomType = new RoomType();
            RoomType = RD.RoomTypes.Where(c => c.ID == TypeID).FirstOrDefault();
            return new JsonResult { Data = RoomType, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        //Save action to add data to database & return JsonResult message if successful or fail
        public JsonResult Save(MastarReservation Reservation)
        {

            bool status = false;
            Reservation.ReservationDate = DateTime.Now;
            var isValidModel = TryUpdateModel(Reservation);
            if (isValidModel)
            {
                
                RD.MastarReservations.Add(Reservation);
                RD.SaveChanges();
                status = true;
            }
            return new JsonResult { Data = new { status = status } };
        }
    }
}