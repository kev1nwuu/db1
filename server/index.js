const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");

// Middleware
app.use(cors());
app.use(express.json());

// ROUTES
// Creating new customer
app.post("/createCustomer", async(req, res) => {
  try {
    // console.log(req.body)
    const ssn = req.body.SSN;
    const name = req.body.name;
    const address = req.body.address;
    const newCustomer = await pool.query(
      "INSERT INTO customer VALUES($1, $2, $3, CURRENT_DATE)",
      [ssn, name, address]
      );
    console.log("Successfully made a new customer");
  } catch (err) {
    console.error(err.message);
  }
});

// Creating new employee
app.post("/createEmployee", async(req, res) => {
  try {
    const name = req.body.name;
    const address = req.body.address;
    const role = req.body.role;
    const hotelID = req.body.hotelID;
    const ssn = req.body.ssn;
    console.log(req.body);
    const newCustomer = await pool.query(
      "INSERT INTO employee(SSN,name,address,role_pos,hotel_id) VALUES($5,$1,$2,$3,$4)",
      [name,address,role,hotelID,ssn]
      );
    console.log("Successfully made a new employee");
  } catch (err) {
    console.error(err.message);
  }
});

// Creating booking
app.post("/createBooking", async(req, res) => {
  try {
    const startDate = req.body.startDate;
    const endDate = req.body.endDate;
    const roomID = req.body.roomID;
    const ssn = req.body.ssn;
    const newBooking = await pool.query(
      "INSERT INTO booking(start_date, end_date, room_id, SSN) VALUES($1, $2, $3, $4)",
      [startDate, endDate, roomID, ssn]
      );
    console.log("Successfully made a new booking");
  } catch (err) {
    console.error(err.message);
  }
});

//Edit room
app.post("/editroom", async(req, res) => {
  try {
    const roomID = req.body.roomID;
    const roomNumber = req.body.roomNumber;
    const price = req.body.price;
    const capacity = req.body.capacity;
    const outsideView = req.body.outsideView;
    const extended = req.body.extended;
    const damage = req.body.damage;
    const rented = req.body.rented;
    console.log(req.body);
    const updateRoom = await pool.query(
      "UPDATE room SET room_num = $2, price = $3, capacity = $4, outside_view = $5, can_be_extended = $6, has_damage = $7, is_rented = $8 WHERE room_id = $1",
      [roomID,roomNumber,price,capacity,outsideView,extended,damage,rented]
      );
    console.log("Successfully updated room");
  } catch (err) {
    console.error(err.message);
  }
});

//Edit customer
app.post("/editCustomer", async(req, res) => {
  try {
    const name = req.body.name;
    const address = req.body.address;
    const ssn = req.body.ssn;
    console.log(req.body);
    const updateRoom = await pool.query(
      "UPDATE customer SET name = $1, address = $2 WHERE SSN = $3",
      [name,address, ssn]
      );
    console.log("Successfully updated customer");
  } catch (err) {
    console.error(err.message);
  }
});

//Edit hotel
app.post("/editHotel", async(req, res) => {
  try {
    const hotelID = req.body.hotelID;
    const rating = req.body.rating;
    const numRooms = req.body.numRooms;
    const address = req.body.address;
    const email = req.body.email;
    const phone = req.body.phone;

    console.log(req.body);
    const updateRoom = await pool.query(
      "UPDATE hotel SET rating = $2, num_rooms = $3, address = $4, email = $5, phone = $6 WHERE hotel_id = $1",
      [hotelID,rating,numRooms,address,email,phone]
      );
    console.log("Successfully updated hotel");
  } catch (err) {
    console.error(err.message);
  }
});


//Edit rental
app.post("/editRental", async(req, res) => {
  try {
    const startDate = req.body.startDate;
    const endDate = req.body.endDate;
    const roomID = req.body.roomID;

    console.log(req.body);
    const updateRoom = await pool.query(
      "UPDATE renting SET start_date = $1, end_date = $2 WHERE room_id = $3",
      [startDate,endDate,roomID]
      );
    console.log("Successfully updated rental");
  } catch (err) {
    console.error(err.message);
  }
});

//Edit Employee
app.post("/editEmployee", async(req, res) => {
  try {
    const name = req.body.name;
    const address = req.body.address;
    const role = req.body.role;
    const hotelID = req.body.hotelID;
    const ssn = req.body.ssn;
    console.log(req.body);
    const updateRoom = await pool.query(
      "UPDATE employee SET name = $1, address = $2, role_pos = $3, hotel_id = $4 WHERE SSN = $5",
      [name,address,role,hotelID,ssn]
      );
    console.log("Successfully updated employee");
  } catch (err) {
    console.error(err.message);
  }
});

// Delete booking
app.post("/deleteBooking", async(req, res) => {
  const roomID = req.body.roomID;
  try {
    const deleteRental = await pool.query(
      "DELETE FROM booking WHERE room_id = $1",
      [roomID]
      );
  } catch (err) {
    console.error(err.message);
  }
});

//Create Rental
app.post("/createRental", async(req, res) => {
  try {
    const startDate = req.body.startDate;
    const endDate = req.body.endDate;
    const bookingID = req.body.bookingID;
    const roomID = req.body.roomID;
    const ssn = req.body.ssn;
    console.log(req.body);
    const newRental = await pool.query(
      "INSERT INTO renting(start_date, end_date, booking_id, room_id,ssn) VALUES($1, $2, $3, $4, $5)",
      [startDate, endDate,bookingID, roomID,ssn]
      );
    console.log("Successfully made a new rental");
  } catch (err) {
    console.error(err.message);
  }
});


// Get all hotels
app.get("/hotels", async(req, res) => {
  try {
    const allHotels = await pool.query("SELECT * FROM hotel");
    res.json(allHotels.rows);
    console.log("Successful query to get all hotels");
  } catch (err) {
    console.error(err.message);
  }
});

// Get all rooms
app.get("/rooms", async(req, res) => {
  try {
    const allRooms = await pool.query("SELECT * FROM room NATURAL JOIN hotel");
    res.json(allRooms.rows);
    console.log("Successful query to get all rooms");
  } catch (err) {
    console.error(err.message);
  }
});

// Get available rooms by date
app.post("/freeRoomsDate", async(req, res) => {
  try {
    const startDate = req.body.selectedStartDate;
    const endDate  = req.body.selectedEndDate;
    const allFreeRooms = await pool.query(
      "WITH roomID(id) as (SELECT DISTINCT room.room_id FROM room LEFT JOIN booking ON room.room_id = booking.room_id WHERE NOT EXISTS (SELECT 1 FROM booking WHERE booking.room_id = room.room_id AND booking.start_date < $1 AND booking.end_date > $2)) SELECT * FROM room, hotel, roomID WHERE room.hotel_id = hotel.hotel_id AND roomID.id = room.room_id",
      [endDate, startDate]
      );
    res.json(allFreeRooms.rows);
    console.log("Successful query to get all free rooms using dates");
  } catch (err) {
    console.error(err.message);
  }
});

// Get all customers
app.get("/customers", async (req, res) => {
  try {
    const allCustomers = await pool.query("SELECT * FROM customer");
    res.json(allCustomers.rows);
    console.log("Successful query to get all customers");
  } catch (err) {
    console.error(err.message);
  }
});

// Get all employees
app.get("/employees", async (req, res) => {
  try {
    const allEmployees = await pool.query("SELECT * FROM employee");
    res.json(allEmployees.rows);
    console.log("Successful query to get all employees");
  } catch (err) {
    console.error(err.message);
  }
});

// Get all bookings
app.get("/bookings", async (req, res) => {
  try {
    const allBookings = await pool.query("SELECT * FROM booking");
    res.json(allBookings.rows);
    console.log("Successful query to get all bookings");
  } catch (err) {
    console.error(err.message);
  }
});

//Get all rentals
app.get("/rentals", async (req, res) => {
  try {
    const allRentals = await pool.query("SELECT * FROM renting");
    res.json(allRentals.rows);
    console.log("Successful query to get all rentals");
  } catch (err) {
    console.error(err.message);
  }
});


app.listen(5000, () => {
  console.log("Server has started on port 5000");
});