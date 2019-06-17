var RoomTypes = []
//fetch Room types from database
function LoadRoomTypes(element) {
    if (RoomTypes.length == 0) {
        //ajax function for fetch Room types
        $.ajax({
            type: "GET",
            url: '/Reservation/GetRoomType',
            success: function (data) {
                RoomTypes = data;
                //render Room Types
                renderRoomTypes(element);
            }
        })
    }
    else {
        //render Room Types to the element
        renderRoomTypes(element);
    }
}

// function for render Room Types to the html element
function renderRoomTypes(element) {
    var $ele = $(element);
    $ele.empty();
    $ele.append($('<option/>').val('0').text('select Room Type'));
    for (var i = 0; i < RoomTypes.length; i++) {
        $ele.append($("<option value=" + RoomTypes[i].ID + " >" + RoomTypes[i].Type + "</option>"));
    }

}

//fetch rooms
function LoadRooms(RoomTypes) {
        //ajax function for fetch Rooms 
    $.ajax({
        type: "GET",
        url: "/Reservation/GetRoom",
        data: { 'RoomTypeID': $(RoomTypes).val() },
        success: function (data) {
            //render rooms to appropriate dropdown
            renderRooms($(RoomTypes).parents('.mycontainer').find('select.RoomName'), data);
        },
        error: function (error) {
            console.log(error);
        }
    })
}
function renderRooms(element, data) {
    //render Rooms to html element
    var $ele = $(element);
    $ele.empty();
    $ele.append($('<option/>').val('0').text('Select Room'));
    $.each(data, function (i, val) {
        $ele.append($('<option/>').val(val.ID).text(val.Name));
    })
}
//fetch price
function LoadPrice(RoomTypes) {
    //ajax function for fetch unit price of single room
    $.ajax({
        type: "GET",
        url: "/Reservation/GetUnitprice",
        data: { 'TypeID': $(RoomTypes).val() },
        success: function (data) {
            //render prices to appropriate dropdown
            renderPrice($(RoomTypes).parents('.mycontainer').find('input.UnitPrice')[0], data);
        },
        error: function (error) {
            console.log(error);
        }
    })
}
function renderPrice(element, data) {
    //render price to html  element
    var $ele = $(element);
    $ele.val(data.Price)
}
///function to calculate number of days
function OnchangeEndDate() {
    if ($('#StartDate').val().trim() != '' && $('#EndDate').val().trim() != '') {
  
        const StartDate = $('#StartDate').val().trim();
        const EndDate = $('#EndDate').val().trim();
        const timeDiff = (new Date(EndDate)) - (new Date(StartDate));
        const days = (timeDiff / (1000 * 60 * 60 * 24)) + 1;
        $('#Nodays').val(days);
    }
}
/// on Number of days changed calculate  price 

function onNodaysChanged() {
    if ($('#Nodays').val().trim() != '' && $('#UnitPrice').val().trim() != '') {
        var totalPrice = parseFloat($('#Nodays').val() || 0) * parseFloat($('#UnitPrice').val() || 0)
        $('#Price').val(totalPrice);

    }
}

$(document).ready(function () {
    //Add button click event
    $('#add').click(function () {
        //validation and add Reservation items
        var isAllValid = true;
        if ($('#RoomType').val() == "0") {
            isAllValid = false;
            $('#RoomType').siblings('span.error').css('visibility', 'visible');
        }
        else {
            $('#RoomType').siblings('span.error').css('visibility', 'hidden');
        }

        if ($('#RoomName').val() == "0") {
            isAllValid = false;
            $('#RoomName').siblings('span.error').css('visibility', 'visible');
        }
        else {
            $('#RoomName').siblings('span.error').css('visibility', 'hidden');
        }
        if ($('#StartDate').val() == '') {
            isAllValid = false;
            $('#StartDate').siblings('span.error').css('visibility', 'visible');
        }
        else {
            $('#StartDate').siblings('span.error').css('visibility', 'hidden');
        }
        if ($('#EndDate').val() == '') {
            isAllValid = false;
            $('#EndDate').siblings('span.error').css('visibility', 'visible');
        }
        else {
            $('#EndDate').siblings('span.error').css('visibility', 'hidden');
        }
        if (isAllValid) {
            var $newRow = $('#mainrow').clone().removeAttr('id');
            $('.pc', $newRow).val($('#RoomType').val());
            $('.RoomName', $newRow).val($('#RoomName').val());

            //Replace add button with remove button
            $('#add', $newRow).addClass('remove').val('X').removeClass('btn-success').addClass('btn-danger');
            //remove id attribute from new clone row
            $('#RoomType,#RoomName,#UnitPrice,#StartDate,#EndDate,#Nodays,#Price,#add', $newRow).removeAttr('id');
            $('span.error', $newRow).remove();
            //append clone row
            $('#ReservationDetails').append($newRow);
           
           
            //clear select data
            $('#RoomType,#RoomName').val('0');
            $('#UnitPrice,#StartDate,#EndDate,#Nodays,#Price').val('');
            $('#orderItemError').empty();
        }
    })
    //remove button click event
    $('#ReservationDetails').on('click', '.remove', function () {
        $(this).parents('tr').remove();
    });
    $('#submit').click(function () {
        var isAllValid = true;
        //validate reservation items
        $('#orderItemError').text('');
        var List = [];
        var errorItemCount = 0;
        $('#ReservationDetails tbody tr').each(function (index, ele) {
            if (
                $('select.pc', this).val() == "0" ||
                (parseInt($('.RoomName', this).val()) || 0) == 0
            ) {
                errorItemCount++;
                $(this).addClass('error');
            } else {
                var ReservationItems = {
                    RoomTypeID: $('select.pc', this).val(),
                    StartDate:$('.StartDate', this).val(),
                    EndDate: $('.EndDate', this).val(),
                    NoDays: parseInt($('.Nodays', this).val()),
                    TotalPrice: parseInt($('.Nodays', this).val()) * parseFloat($('.UnitPrice', this).val()),
                    RoomID: ($('.RoomName', this).val()),

                }
                List.push(ReservationItems);
                console.log(ReservationItems);
            }
        })
        if (errorItemCount > 0) {
            $('#orderItemError').text(errorItemCount + " invalid entry in Reservation item list.");
            isAllValid = false;
        }
        if (List.length == 0) {
            $('#orderItemError').text('select 0ne Room At least');
            isAllValid = false;
        }         
        if (isAllValid) {
            var data = {    
                
                Reservations: List,
            }

        
            $(this).val(' Wait...');
            $.ajax({
                type: 'POST',
                url: '/Reservation/Save',
                data: JSON.stringify(data),
                contentType: 'application/json',
                success: function (data) {
                    if (data.status) {
                        alert('Successfully saved');
                        //here we will clear the form
                        List = [];
                      
                        $('#ReservationDetails').empty();
                    }
                    else {
                        alert('Error');
                    }
                    $('#submit').val('Save');
                },
                error: function (error) {
                    console.log(error);
                    $('#submit').val('Save');
                }
            });
        }
    });
});
LoadRoomTypes($('#RoomType'));
LoadRooms($('#RoomType'));
LoadPrice($('#RoomType'));
